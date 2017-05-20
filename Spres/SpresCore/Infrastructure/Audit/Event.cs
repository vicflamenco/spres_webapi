using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Infrastructure.Audit
{
    public class Event
    {        
        public long Id { get; set; }
        public EventType Type { get; set; }
        public string UserId { get; set; }
        public string Source { get; set; }
        public string Description { get; set; }
        public DateTime EventDate { get; set; }
        
    }
}
