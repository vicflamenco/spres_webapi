using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class Permissions
    {
        public string RolId { get; set; }
        public int Option { get; set; }
        public bool View { get; set; }
        public bool Edit { get; set; }
        public bool AllCostCenters { get; set; }

    }
}
