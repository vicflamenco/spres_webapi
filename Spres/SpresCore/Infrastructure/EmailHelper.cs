using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Spres.Infrastructure
{
    public class EmailHelper
    {
        public static void Send(string templateName, List<string> emailParameters, List<string> recipientAddresses)
        {
            if (bool.Parse(ConfigurationManager.AppSettings["EnableEmails"]))
            {
                using (var db = new SpresContext())
                {
                    var emailTemplate = db.EmailTemplates.FirstOrDefault(et => et.Name == templateName);

                    if (emailTemplate != null)
                    {
                        var message = new MailMessage();

                        foreach (var recipientAddress in recipientAddresses)
                        {
                            if (!message.To.Any(t => t.Address == recipientAddress))
                            {
                                message.To.Add(new MailAddress(recipientAddress));
                            }
                        }
                        var emailTemplateBody = emailTemplate.Body;

                        for (int i = 0; i < emailParameters.Count; i++)
                        {
                            emailTemplateBody = emailTemplateBody.Replace("{" + i.ToString() + "}", emailParameters[i]);
                        }

                        message.From = new MailAddress("spres.livsmart@gmail.com", "Spres Liv-Smart");
                        message.Subject = emailTemplate.Subject;
                        message.Body = emailTemplateBody;
                        message.IsBodyHtml = true;

                        using (var smtp = new SmtpClient())
                        {
                            smtp.Send(message);
                        }
                    }
                }
            }
        }
    }
}
