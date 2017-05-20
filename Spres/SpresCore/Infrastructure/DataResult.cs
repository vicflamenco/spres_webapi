using System.Collections;
using System.Collections.Generic;

namespace Spres.Infrastructure
{    

    public class DataResult
    {
        public int Count { get; set; }

        public IEnumerable Items { get; set; }
    }


}