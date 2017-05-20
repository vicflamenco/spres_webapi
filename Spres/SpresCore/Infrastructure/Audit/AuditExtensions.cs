using System;
using Spres.Infrastructure;
using Spres.Infrastructure.Security;
using Spres.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Net.Http;
using System.Collections;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Xml.Linq;

namespace Spres.Infrastructure.Audit
{
    public static class AuditExtensions
    {
        public static void RegisterEvent(this ApiController controller, string description)
        {
            using (var model = new SpresContext())
            {
                var username = controller.Request.GetOwinContext().Authentication.User.Identity.Name;
                var source = new XElement("Source",
                    new XElement("Action", controller.ActionContext.ActionDescriptor.ActionName),
                    new XElement("Controller", controller.ControllerContext.ControllerDescriptor.ControllerName)
                );                

                var auditEvent = new Event
                {
                    Id = DateTime.Now.Ticks,
                    Description = description,
                    Type = (controller.Request.Method == HttpMethod.Post) ? EventType.Insert :
                        (controller.Request.Method == HttpMethod.Put) ? EventType.Update :
                            EventType.Delete,
                    UserId = SecurityManager.GetUser(username).Id,
                    Source = source.ToString(),
                    EventDate = DateTime.Now
                };

                model.Events.Add(auditEvent);
                model.SaveChanges();
            }
        }
    }
}
