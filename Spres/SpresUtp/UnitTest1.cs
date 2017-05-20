using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Net.Mail;

namespace SpresUtp
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            var fromName = "SPRES";
            var fromEmail = "spres.livsmart@gmail.com";

            var to = "vicflamenco.7@gmail.com";
            var messageContent = "prueba";

            var body = "<p>Email From: {0} ({1})</p><p>Message:</p><p>{2}</p>";
            var message = new MailMessage();
            message.To.Add(new MailAddress(to));
            message.Subject = "Asunto";
            message.Body = string.Format(body, fromName, fromEmail, messageContent);
            message.IsBodyHtml = true;
            using (var smtp = new SmtpClient())
            {
                smtp.Send(message);
            }
        }
    }
}
