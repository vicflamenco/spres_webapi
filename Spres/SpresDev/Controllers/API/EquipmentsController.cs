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
    public class EquipmentsController : ApiController
    {
        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAllEquipments()
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var equipments = dbContext.Equipments.OrderBy(e => e.Name).ToList();
                    return Ok(equipments.ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetEquimentById(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var equipment = dbContext.Equipments.Find(id);
                    if (equipment == null)
                        return NotFound();
                    return Ok(equipment);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostEquipment(Equipment equipment)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Equipments.Add(equipment);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se agregó " + equipment.Name + " como nuevo equipo de protección");
                    return Ok(new { result = new[] { equipment } });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutEquipment(Equipment equipment)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(equipment).State = EntityState.Modified;
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se modificó el equipo de protección " + equipment.Name);
                    return Ok(equipment);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }

            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult DeleteEquipment(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    Equipment equipment = dbContext.Equipments.Find(id);

                    if (equipment == null)
                        return NotFound();

                    dbContext.Equipments.Remove(equipment);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se eliminó el equipo de protección " + equipment.Name);
                    return Ok(equipment);
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
