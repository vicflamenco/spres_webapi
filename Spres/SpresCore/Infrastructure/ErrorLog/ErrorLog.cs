using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
namespace Spres.Infrastructure.ErrorLog
{
    public class ErrorLog
    {
        private static void CreateSource()
        {
            if (!EventLog.SourceExists("Spres"))
            {
                EventLog.CreateEventSource("Spres","Application");
            }
        }

        public static void SaveError(Exception ex)
        {
            CreateSource();            
            EventLog eve = new EventLog("Application");
            eve.Source = "Spres";

            var exception = ex;
            var messageBuilder = new StringBuilder();
            while (exception != null)
            {
                messageBuilder.AppendLine(exception.Message);
                messageBuilder.AppendLine("Type: " + exception.GetType());
                messageBuilder.AppendLine("Source: " + exception.Source);
                messageBuilder.AppendLine("Stack:" + exception.StackTrace);
                messageBuilder.AppendLine();
                exception = exception.InnerException;                
            }

            eve.WriteEntry(messageBuilder.ToString(), EventLogEntryType.Error);
            
        }
    }
}
