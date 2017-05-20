using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class BudgetSheetsController : ApiController
    {

        [SpresSecurityAttribute("Budgeting", true, false)]
        public IHttpActionResult GetIsHumanResources(int id)
        {
            using (var identityDb = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                var sheet = db.BudgetSheets.Find(id);
                if (sheet == null)
                {
                    return NotFound();
                }
                else
                {
                    var user = identityDb.UserManager.FindById(User.Identity.GetUserId());
                    if (user == null)
                    {
                        return InternalServerError();
                    }
                    else
                    {
                        return Ok(new
                        {
                            IsHumanResources = sheet.Package.HR,
                            HasAllCostCentersPermission = PermissionsController.HasAllCostCentersPermission(user)
                        });
                    }
                }
            }
        }

        [Route("api/BudgetSheets/{costCenterId}/{fiscalYear}/{companyId}")]
        public IHttpActionResult GetBudgetSheets(int costCenterId, int fiscalYear, int companyId)
        {
            var username = User.Identity.Name;

            using (var db = new SpresContext())
            {
                var combinedPermissions = PermissionsController.GetCombinedPermissions(username);
                var budget = db.Budgets.FirstOrDefault(b => b.FiscalYear == fiscalYear && b.CompanyId == companyId && b.CostCenterId == costCenterId);

                if (budget == null)
                {
                    return Ok(new object[] { });
                }

                var result = new List<Object>();
                var costCenter = db.CostCenters.Find(costCenterId);

                if (combinedPermissions[1].View && (combinedPermissions[1].AllCostCenters || costCenter.ResponsibleGUID == User.Identity.GetUserId()))
                {
                    result.AddRange(budget.Sheets.Where(bs => bs.Package.HR).ToList().Select(bs => new
                    {
                        BudgetId = bs.BudgetId,
                        Id = bs.Id,
                        PackageId = bs.PackageId,
                        Package = new
                        {
                            Id = bs.PackageId,
                            Name = bs.Package.Name
                        },
                        AllowEditing = combinedPermissions[1].Edit
                    })
                    .OrderBy(bs => bs.PackageId)
                    .ToList());
                }

                if (combinedPermissions[0].View && (combinedPermissions[0].AllCostCenters || costCenter.ResponsibleGUID == User.Identity.GetUserId()))
                {
                    result.AddRange(budget.Sheets.Where(bs => !bs.Package.HR).ToList().Select(bs => new
                    {
                        BudgetId = bs.BudgetId,
                        Id = bs.Id,
                        PackageId = bs.PackageId,
                        Package = new
                        {
                            Id = bs.PackageId,
                            Name = bs.Package.Name
                        },
                        AllowEditing = combinedPermissions[0].Edit
                    })
                    .OrderBy(bs => bs.PackageId)
                    .ToList());
                }
                return Ok(result);
            }
        }

        // No agregar filtro de seguridad
        public IHttpActionResult PostBudgetSheet(Budget budgetRequest, [FromUri] int packageId)
        {
            try
            {
                using (var db = new SpresContext())
                {
                    var fiscalYear = budgetRequest.FiscalYear;
                    var companyId = budgetRequest.CompanyId;
                    var costCenterId = budgetRequest.CostCenterId;
                    var costCenter = db.CostCenters.Find(costCenterId);
                    var budget = db.Budgets.FirstOrDefault(b => b.FiscalYear == fiscalYear && b.CompanyId == companyId && b.CostCenterId == costCenterId);

                    if (budget == null)
                    {
                        budget = new Budget { CompanyId = companyId, CostCenterId = costCenterId, FiscalYear = fiscalYear };
                        db.Budgets.Add(budget);
                        db.SaveChanges();
                    }

                    if (budget.Sheets.Any(bs => bs.PackageId == packageId))
                    {
                        return BadRequest("Budget Sheet already exists.");
                    }
                    else
                    {
                        var lines = new List<BudgetLine>();
                        var package = db.Packages.Find(packageId);
                        var parentAccounts = package.Accounts.Where(a => a.Parent == null && a.Type.Split(',').Contains(costCenter.Type)).ToList();

                        foreach (var account in parentAccounts)
                        {
                            var lstMonthDetails = new List<BudgetMonthDetail>();

                            for (int i = 1; i <= 12; i++)
                                lstMonthDetails.Add(new BudgetMonthDetail() { Forecast = 0, Month = i, Quantity = 0, Real = 0, Target = 0, UnitCost = 0 });

                            lines.Add(new BudgetLine()
                            {
                                AccountId = account.Id,
                                Description = account.Display,
                                ParentId = null,
                                MonthDetails = lstMonthDetails
                            });
                        }

                        var sheet = new BudgetSheet() { BudgetId = budget.Id, PackageId = packageId, Lines = lines };

                        db.BudgetSheets.Add(sheet);
                        db.SaveChanges();

                        foreach (var line in lines)
                        {
                            var children = line.Account.Children
                                .Where(c => package.Accounts.Any(a => c.Id == a.Id) && c.Type.Split(',').Contains(costCenter.Type)).ToList();

                            foreach (var child in children.ToList())
                            {
                                var lstMonthDetails = new List<BudgetMonthDetail>();

                                for (int i = 1; i <= 12; i++)
                                    lstMonthDetails.Add(new BudgetMonthDetail() { Forecast = 0, Month = i, Quantity = 0, Real = 0, Target = 0, UnitCost = 0 });

                                line.Children.Add(new BudgetLine
                                {
                                    AccountId = child.Id,
                                    Description = child.Display,
                                    ParentId = line.Id,
                                    SheetId = sheet.Id,
                                    MonthDetails = lstMonthDetails
                                });
                            }
                        }
                        db.SaveChanges();
                        this.RegisterEvent("Se agregó una hoja de presupuestación del paquete " + sheet.Package.Name + " en el centro de costo " + sheet.Budget.CostCenter.Display);
                        return Ok();
                    }

                    
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError();
            }
        }

        [SpresSecurityAttribute("Budgeting", false, true)]
        public IHttpActionResult DeleteBudgetSheet(int id)
        {
            using (var db = new SpresContext())
            {
                try
                {
                    var sheet = db.BudgetSheets.Find(id);
                    var package = sheet.Package;
                    var sheets = sheet.Budget;
                    db.BudgetSheets.Remove(sheet);
                    db.SaveChanges();
                    
                    this.RegisterEvent("Se eliminó la hoja de presuspuestación del paquete " + package.Name + " en el centro de costo " + sheets.CostCenter.Display);
                    
                    return Ok();
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError();
                }
                
            }
        }
    }
}
