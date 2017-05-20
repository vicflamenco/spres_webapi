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
    public class PositionEquipmentsController : ApiController
    {

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetPositionEquipments(int PositionId, bool attached)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var position = dbContext.Positions.Find(PositionId);

                    if (position == null)
                        return NotFound();

                    if (attached)
                        return Ok(position.Equipments.ToList().Select(eq => new Equipment { Id = eq.Id, Name = eq.Name }));

                    var equipments = dbContext.Equipments.ToList();
                    var lstEquipments = new List<Equipment>();

                    foreach (var equipment in equipments)
                        if (!position.Equipments.Contains(equipment))
                            lstEquipments.Add(equipment);

                    return Ok(lstEquipments);

                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        // ASOCIAAR EQUIPO A POSICION

        [SpresSecurityAttribute("Catalogs", false, true)]
        [Route("api/PositionEquipments/{PositionId}/{EquipmentId}")]
        public IHttpActionResult PutAssociateEquipment(int PositionId, int EquipmentId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var position = dbContext.Positions.Find(PositionId);
                    var equipment = dbContext.Equipments.Find(EquipmentId);

                    if (position == null || equipment == null)
                        return NotFound();

                    position.Equipments.Add(equipment);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se asoció el equipo de protección " + equipment.Name + " a la posición " + position.Name );
                    return Ok(new Equipment { Id = equipment.Id, Name = equipment.Name });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        //posiciones de Equipment

        // DESVINCULAR EQUIPO DE POSICION
        [SpresSecurityAttribute("Catalogs", false, true)]
        [Route("api/PositionEquipments/{PositionId}/{EquipmentId}")]
        public IHttpActionResult PostDetatchEquipment(int PositionId, int EquipmentId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var position = dbContext.Positions.Find(PositionId);
                    var equipment = dbContext.Equipments.Find(EquipmentId);

                    if (equipment == null || position == null)
                        return NotFound();

                    if (!position.Equipments.Contains(equipment))
                        return BadRequest("Benefit is not attached to specified position.");

                    position.Equipments.Remove(equipment);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se desvinculó el equipo de protección " + equipment.Name + " de la posición " + position.Name);
                    return Ok(new Equipment { Id = equipment.Id, Name = equipment.Name });
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
