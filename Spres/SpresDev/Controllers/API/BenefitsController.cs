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
    public class BenefitsController : ApiController
    {

        [Route("api/Benefits/BenefitTargetTypes")]
        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetBenefitTargetTypes()
        {
            var names = Enum.GetNames(typeof(BenefitTargetType));
            var types = names.Select(n => new { Id = Array.IndexOf(names, n) + 1, Name = n });
            return Ok(types.ToDataResult());
        }

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAllBenefits()
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    return Ok(dbContext.Benefits.OrderBy(b => b.Name).ToList().Select(p => new Benefit { Id = p.Id, Name = p.Name, Target = p.Target }).ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetBenefitById(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var benefit = dbContext.Benefits.Find(id);
                    if (benefit == null)
                        return NotFound();
                    return Ok(new Benefit { Id = benefit.Id, Name = benefit.Name, Target = benefit.Target });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostBenefit(Benefit benefit)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Benefits.Add(benefit);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se agregó " + benefit.Name + " como nuevo beneficio de tipo " + benefit.Target);
                    return Ok(new Benefit { Id = benefit.Id, Name = benefit.Name, Target = benefit.Target });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutBenefit(Benefit benefit)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(benefit).State = EntityState.Modified;
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se editó el beneficio " + benefit.Name);
                    return Ok(new Benefit { Id = benefit.Id, Name = benefit.Name, Target = benefit.Target });

                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }

            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult DeleteBenefit(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    Benefit benefit = dbContext.Benefits.Find(id);

                    if (benefit == null)
                        return NotFound();

                    dbContext.Benefits.Remove(benefit);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se eliminó el beneficio " + benefit.Name + " de tipo " + benefit.Target);
                    return Ok(new Benefit { Id = benefit.Id, Name = benefit.Name, Target = benefit.Target });
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
