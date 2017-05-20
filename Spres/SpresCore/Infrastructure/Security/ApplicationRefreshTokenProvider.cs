using Microsoft.Owin.Security.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Infrastructure.Security
{
    public class ApplicationRefreshTokenProvider : AuthenticationTokenProvider
    {
        public override void Create(AuthenticationTokenCreateContext context)
        {
            context.Ticket.Properties.ExpiresUtc = DateTime.UtcNow.AddHours(2);
            context.SetToken(context.SerializeTicket());
        }

        public override void Receive(AuthenticationTokenReceiveContext context)
        {
            context.DeserializeTicket(context.Token);
        }
    }
}
