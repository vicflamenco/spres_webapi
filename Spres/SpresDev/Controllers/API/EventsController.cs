using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;
using System.Xml.Linq;
namespace SpresDev.Controllers.Api
{
    public class EventsController : ApiController
    {
        [SpresSecurityAttribute("Security", true, false)]
        //[Route("api/Events/GetEvents/{startDate}/{endDate}")]
        public IHttpActionResult GetEvents(DateTime startDate, DateTime endDate , EventType? evenType, string userId, string source)
        {
            using (var model = new SpresContext())
            {


                var data = model.Events
                   .Where(p => DbFunctions.TruncateTime(p.EventDate) >= startDate && DbFunctions.TruncateTime(p.EventDate) <= endDate && (userId == null || userId == "" || p.UserId == userId) && (evenType == null || p.Type == evenType.Value))
                   .ToList()
                   //.Where(p => p.EventDate >)
                   .Where(p => source == "" || source == null || p.Source.Contains(source))
                   .Select(p => new Event
                   {
                       Id = p.Id,
                       UserId = p.UserId,
                       Type = p.Type,
                       Description = p.Description,
                       Source = String.Format("Controlador: {0}, Accion: {1}",
                        XElement.Parse(p.Source).Element("Controller").Value,
                        XElement.Parse(p.Source).Element("Action").Value),
                       EventDate = p.EventDate
                   }).OrderByDescending(p => p.Id).
                   ToList();

                return Ok(data.ToDataResult());
            }
        }

        [SpresSecurityAttribute("Security", true, false)]
        [Route("api/Events/GetEventTypes")]
        public IHttpActionResult GetALLEvenTypes()
        {
            try
            {
                var names = Enum.GetNames(typeof(EventType));
                var types = names.Select(n => new { Id = Array.IndexOf(names, n) + 1, Name = n });
                return Ok(types.ToDataResult());
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }

        [SpresSecurityAttribute("Security", true, false)]
        [Route("api/Events/GetSources")]
        public IHttpActionResult GetSources()
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                   var controllerDictionary =  GlobalConfiguration.Configuration.Services.GetHttpControllerSelector().GetControllerMapping();
                   return Ok(controllerDictionary.Keys.Select(d => new { Name = d }).ToDataResult());
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
