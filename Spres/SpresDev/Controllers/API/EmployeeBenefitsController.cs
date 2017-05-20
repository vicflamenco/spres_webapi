using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
namespace SpresDev.Controllers.Api
{
    public class EmployeeBenefitsController : ApiController
    {

        public IHttpActionResult GetEmployeeBenefits(int EmployeeId, bool attached)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var employee = dbContext.Employees.Find(EmployeeId);

                    if (employee == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        if (attached)
                        {
                            return Ok(employee.Benefits.ToList());
                        }
                        else
                        {
                            var benefits = dbContext.Benefits.ToList();
                            var lstBenefits = new List<Benefit>();
                            foreach (var benefit in benefits)
                            {
                                if (!employee.Benefits.Contains(benefit))
                                {
                                    lstBenefits.Add(benefit);
                                }
                            }
                            return Ok(lstBenefits);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }


        // ASOCIAAR BENEFICIO A EMPLEADO

        [Route("api/EmployeeBenefits/{EmployeeId}/{BenefitId}")]
        public IHttpActionResult PutAssociateBenefit(int EmployeeId, int BenefitId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var employee = dbContext.Employees.Find(EmployeeId);
                    var benefit = dbContext.Benefits.Find(BenefitId);

                    if (employee == null || benefit == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        employee.Benefits.Add(benefit);
                        dbContext.SaveChanges();
                        this.RegisterEvent("Se asignó el beneficio " + benefit.Name + " al empleado " + employee.Name);
                        return Ok(new Benefit { Id = benefit.Id, Name = benefit.Name, Target = benefit.Target });
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        //posiciones de Equipment

        // DESVINCULAR BENEFICIO DE EMPLEADO

        [Route("api/EmployeeBenefits/{EmployeeId}/{BenefitId}")]
        public IHttpActionResult PostDetatchBenefit(int EmployeeId, int BenefitId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var employee = dbContext.Employees.Find(EmployeeId);
                    var benefit = dbContext.Benefits.Find(BenefitId);

                    if (benefit == null || employee == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        if (!employee.Benefits.Contains(benefit))
                        {
                            return BadRequest("El beneficio no está asignado al empleado especificado.");
                        }
                        else
                        {
                            employee.Benefits.Remove(benefit);
                            dbContext.SaveChanges();
                            this.RegisterEvent("Se desasignó el beneficio " + benefit.Name + " del empleado " + employee.Name);
                            return Ok(new Benefit { Id = benefit.Id, Name = benefit.Name, Target = benefit.Target });
                        }
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
}
