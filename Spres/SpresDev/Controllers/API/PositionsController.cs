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
    public class PositionsController : ApiController
    {
        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetPositions(int companyId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var positions = dbContext.Positions
                        .Where(p=>p.CompanyId == companyId)
                        .OrderBy(p => p.Name)
                        .ToList()
                        .Select(p => new Position() { Id = p.Id, Name = p.Name, CompanyId = p.CompanyId })
                        .ToDataResult();

                    return Ok(positions);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostPosition(Position position)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {                 
                    dbContext.Positions.Add(position);
                    var company = dbContext.Companies.Find(position.CompanyId);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se creó " + position.Name + " como una nueva posición en la región " + company.Name );
                    return Ok(new Position() { Id = position.Id, Name = position.Name, CompanyId = position.CompanyId });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutPosition(Position position)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(position).State = EntityState.Modified;
                    var company = dbContext.Companies.Find(position.CompanyId);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se editó la posición " + position.Name + " en la región " + company.Name);
                    return Ok(new Position() { Id = position.Id, Name = position.Name, CompanyId = position.CompanyId });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult DeletePosition(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    Position position = dbContext.Positions.Find(id);

                    if (position == null)
                        return NotFound();
                    
                    if (position.Equipments != null && position.Equipments.Any())
                        return BadRequest("La posición tiene equipo(s) asignado(s)");
                    
                    if (position.Employees != null && position.Employees.Any())
                        return BadRequest("La posición tiene empleado(s) asociado(s)");

                    dbContext.Positions.Remove(position);
                    var company = dbContext.Companies.Find(position.CompanyId);
                    dbContext.SaveChanges();
                    
                    this.RegisterEvent("Se eliminó la posición " + position.Name + " en la región " +company.Name );
                    return Ok(position);
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
