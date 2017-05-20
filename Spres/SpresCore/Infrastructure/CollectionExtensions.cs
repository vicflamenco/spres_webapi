using System.Collections.Generic;
using System.Linq;

namespace Spres.Infrastructure
{
    public static class CollectionExtensions
    {
        public static DataResult ToDataResult<T>(this IEnumerable<T> items)
        {
            var result = new DataResult();
            result.Items = items.ToList();
            result.Count = items.Count();
            return result;
        }
    }
}