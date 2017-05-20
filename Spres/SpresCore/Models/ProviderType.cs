using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class ProviderType
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public int PremiseTypeId { get; set; }
        public virtual PremiseType PremiseType { get; set; }

        public virtual ICollection<Provider> Providers { get; set; }
    }
}
