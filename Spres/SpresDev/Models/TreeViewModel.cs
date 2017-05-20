using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class TreeViewModel
    {
        public int Id { get; set; }
        public int? ParentId { get; set; }
        public string Name { get; set; }
        public bool HasChild { get; set; }
    }
}