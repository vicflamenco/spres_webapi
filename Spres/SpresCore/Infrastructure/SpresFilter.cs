using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace Spres.Infrastructure
{
    public class SpresFilter : IActionFilter
    {        

        public async Task<HttpResponseMessage> ExecuteActionFilterAsync(HttpActionContext actionContext, CancellationToken cancellationToken, Func<Task<HttpResponseMessage>> continuation)
        {
            var request = actionContext.Request;
            HttpResponseMessage response = await continuation();
            
            var content = response.Content as ObjectContent;
            var requestquery = request.RequestUri.ParseQueryString();

            if (content != null && content.Value is DataResult)
            {                
                var value = content.Value as DataResult;
                var beginDate = DateTime.Now;
                Debug.WriteLine("Inicio de filtrado de acción: " + DateTime.Now.ToString());
                if (requestquery.AllKeys.Contains("$filter"))
                {
                    var initial = requestquery["$filter"].IndexOf("substringof('") + 13;
                    var final = requestquery["$filter"].IndexOf("',tolower(");
                    var filter = requestquery["$filter"].Substring(initial, final - initial);
                    var filteredResult = new ArrayList();
                    foreach (var item in value.Items)
                    {
                        if (item.GetType().GetProperty("Name") != null && 
                            item.GetType().GetProperty("Name").GetValue(item).ToString().IndexOf(filter, StringComparison.CurrentCultureIgnoreCase) >= 0)
                        {
                            filteredResult.Add(item);
                            continue;
                        }
                        if (item.GetType().GetProperty("Code") != null && 
                            item.GetType().GetProperty("Code").GetValue(item).ToString().IndexOf(filter, StringComparison.CurrentCultureIgnoreCase) >= 0)
                        {
                            filteredResult.Add(item);
                            continue;
                        }
                        if (item.GetType().GetProperty("Description") != null && 
                            item.GetType().GetProperty("Description").GetValue(item).ToString().IndexOf(filter, StringComparison.CurrentCultureIgnoreCase) >= 0)
                        {
                            filteredResult.Add(item);
                            continue;
                        }
                    }
                    value.Items = filteredResult;
                    Debug.WriteLine("Después de filtrar los resultados: " + DateTime.Now.Subtract(beginDate).Milliseconds);
                }

                if (requestquery.AllKeys.Contains("$top") || requestquery.AllKeys.Contains("$skip"))
                {
                    int top = requestquery["$top"] == null ? value.Items.Cast<object>().Count() : int.Parse(requestquery["$top"]);
                    int skip = requestquery["$skip"] == null ? 0 : int.Parse(requestquery["$skip"]);

                    var items = value.Items.Cast<object>();
                    value.Items = items.Skip(skip).Take(top);
                    value.Count = items.Count();
                    Debug.WriteLine("Después de paginar los resultados: " + DateTime.Now.Subtract(beginDate).Milliseconds);
                }
                
            }


            return response;
        }

        public bool AllowMultiple
        {
            get { return false; }
        }
    }
}
