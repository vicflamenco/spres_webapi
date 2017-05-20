using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;
namespace SpresDev.Controllers.Api
{
    public class CostCentersController : ApiController
    {
        public IHttpActionResult Get(int companyId, int id = 0)
        {
            try
            {
                using (var identityDb = new SpresIdentityDbContext())
                using (var db = new SpresContext())
                {
                    var costcenters = db.CostCenters.OrderBy(p => p.Name).Where(c => companyId == 0 || c.CompanyId == companyId).ToList();

                    if (id == 0) // Recursivo (hijos)
                    {

                        var childcostcenters = costcenters.Where(c => c.Parent != null).ToList();
                        return Ok(costcenters.Where(c => c.Parent == null).ToList().Select(c => new CostCenter
                        {
                            Id = c.Id,
                            Code = c.Code,
                            Name = c.Name,
                            ParentId = c.ParentId,
                            CompanyId = c.CompanyId,
                            ResponsibleGUID = c.ResponsibleGUID,
                            Children = GetChildren(childcostcenters, c.Id),
                            Type = c.Type,
                            Mirror = c.Mirror
                        }).ToDataResult());

                    }
                    else if (id == -1) // Asignados a un responsable
                    {
                        var username = User.Identity.Name;
                        var user = identityDb.UserManager.FindByName(username);

                        if (user != null) // Alerta: NO hacer operación AND para estos dos If anidados.
                        {
                            if (!PermissionsController.HasAllCostCentersPermission(user))
                            {
                                costcenters = costcenters.Where(c => c.ResponsibleGUID == user.Id).ToList();
                            }
                        }
                        else
                        {
                            costcenters = new List<CostCenter>();
                        }

                        return Ok(costcenters.Select(c => new CostCenter
                        {
                            Id = c.Id,
                            Code = c.Code,
                            Name = c.Name,
                            ParentId = c.ParentId,
                            CompanyId = c.CompanyId,
                            ResponsibleGUID = c.ResponsibleGUID,
                            Type = c.Type,
                            Mirror = c.Mirror
                        }).ToDataResult());
                    }
                    else // Recursivo
                    {
                        var parent = costcenters.FirstOrDefault(c => c.Id == id);
                        return Ok(parent.Children.ToList().Select(c => new CostCenter
                        {
                            Id = c.Id,
                            Code = c.Code,
                            Name = c.Name,
                            ParentId = c.ParentId,
                            CompanyId = c.CompanyId,
                            ResponsibleGUID = c.ResponsibleGUID,
                            Children = GetChildren(c.Children.ToList(), c.Id),
                            Type = c.Type,
                            Mirror = c.Mirror
                        }).ToDataResult());
                    }

                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }

        private static List<CostCenter> GetChildren(List<CostCenter> costcenter, int parentId)
        {
            return costcenter.Where(a => a.Parent.Id == parentId).Select(a => new CostCenter
            {
                Id = a.Id,
                Name = a.Name,
                Code = a.Code,
                ParentId = parentId,
                Children = GetChildren(costcenter, a.Id),
                Type = a.Type,
                Mirror = a.Mirror
            }).ToList();
        }

        [HttpPut]
        [Route("api/CostCenters/{costCenterId}/{GUID}/{associate}")]
        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult Put(int costCenterId, string GUID, bool associate, string mirror)
        {
            using (var db = new SpresContext())
            {
                try
                {
                    var cost = db.CostCenters.Find(costCenterId);
                    
                    if (cost == null)
                    {
                        return NotFound();
                    }
                    cost.ResponsibleGUID = (associate) ? GUID : null;
                    cost.Mirror = mirror;
                    db.Entry(cost).State = EntityState.Modified;
                    db.SaveChanges();
                    var uname = SecurityManager.GetUsername(GUID);                    
                    this.RegisterEvent("Se modificó el centro de costo " + cost.Display + ". Responsable: " + uname + ", Espejo: " + mirror);
                    return Ok();
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [Route("api/CostCenters/GetAllCostCenters")]
        public IHttpActionResult GetAllCostCenter()
        {
            try
            {
                using (SpresContext dbContext = new SpresContext())
                {
                    var companies = dbContext.Companies.ToList();

                    var result = new List<TreeViewModel>();

                    result.Add(new TreeViewModel()
                    {
                        HasChild = true,
                        Id = 9999999,
                        Name = "Todos",
                        ParentId = null
                    });

                    result.AddRange(companies.Select(a => new TreeViewModel()
                    {
                        Id = a.Id * -1,
                        Name = a.Name,
                        ParentId = 9999999,
                        HasChild = true
                    }).ToList());

                    result.AddRange(dbContext.CostCenters.Select(a => new TreeViewModel()
                    {
                        Id = a.Id,
                        Name = a.Name,
                        ParentId = a.CompanyId * -1,
                        HasChild = false
                    }).ToList());

                    return Ok(result);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }
    }
}
