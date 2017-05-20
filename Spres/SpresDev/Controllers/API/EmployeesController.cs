using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;
namespace SpresDev.Controllers.Api
{
    public class EmployeesController : ApiController
    {

        [SpresSecurity("Catalogs", true, false)]
        public IHttpActionResult GetEmployees(int companyId)
        {
            using(SpresContext db = new SpresContext())
            {
                try
                {
                    return Ok(db.Employees
                        .OrderBy(e => e.Name)
                        .Where(e => companyId == 0 || e.Position.CompanyId == companyId)
                        .ToList().Select(e => new Employee()
                            {
                                Id = e.Id,
                                Code = e.Code,
                                Name = e.Name,
                                PositionId = e.PositionId,
                                Salary = e.Salary,
                                CostCenterId = e.CostCenterId,
                                Active = e.Active,
                                Variable = e.Variable,
                                LifeInsurance = e.LifeInsurance
                            }).ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }

        }


        [Route("api/Employees/GetEmployeesByCostCenter/{costCenterId}")]
        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetEmployeesByCostCenter(int costCenterId)
        {
            using (SpresContext db = new SpresContext())
            {
                try
                {
                    return Ok(db.Employees
                        .OrderBy(e => e.Name)
                        .Where(e => e.CostCenterId == costCenterId)
                        .ToList().Select(e => new
                        {
                            Id = e.Id,
                            Name = string.Format("{0} ({1})", e.Name, e.Position.Name)
                        }).ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }

        }


        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetEmployeeById(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var Employee = dbContext.Employees.Find(id);
                    if (Employee == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        return Ok(new Employee()
                        {
                            Id = Employee.Id,
                            Code = Employee.Code,
                            Name = Employee.Name,
                            PositionId = Employee.PositionId,
                            Salary = Employee.Salary,
                            CostCenterId = Employee.CostCenterId,
                            Active = Employee.Active,
                            Variable = Employee.Variable,
                            LifeInsurance = Employee.LifeInsurance
                        });
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetExists(string code, string name)
        {
            using (var db = new SpresContext())
            {
                var exists = db.Employees.Where(e => e.Code.Equals(code) || e.Name.Equals(name)).Any();
                return Json(exists);
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostEmployee(Employee employee)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var exists = dbContext.Employees.Where(e => e.Code.Equals(employee.Code) || e.Name.Equals(employee.Name)).Any();
                    if (!exists)
                    {
                        dbContext.Employees.Add(employee);
                        dbContext.SaveChanges();
                        this.RegisterEvent("Se agregó a " + employee.Name + " como nuevo empleado");
                        return Ok(new Employee
                        {
                            Id = employee.Id,
                            Code = employee.Code,
                            Name = employee.Name,
                            Active = employee.Active,
                            Variable = employee.Variable,
                            LifeInsurance = employee.LifeInsurance
                        });
                    }
                    else
                    {
                        return Ok();
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutEmployee(Employee employee)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(employee).State = EntityState.Modified;
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se modificó el empleado " + employee.Name);
                    return Ok(new Employee
                    {
                        Id = employee.Id,
                        Code = employee.Code,
                        Name = employee.Name,
                        PositionId = employee.PositionId,
                        Salary = employee.Salary,
                        CostCenterId = employee.CostCenterId,
                        Active = employee.Active,
                        Variable = employee.Variable,
                        LifeInsurance = employee.LifeInsurance
                    });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }

            }
        }
    }
}
