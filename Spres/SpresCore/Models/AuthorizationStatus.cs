using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public enum AuthorizationStatus
    {
        Pending = 0,
        Reviewed = 1,
        Authorized = 2,
        Enabled = 3
    }
}
