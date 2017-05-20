using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class ChangePasswordViewModel
    {
        public string id { get; set; }
        public string currentPassword { get; set; }
        public string newPassword { get; set; }
    }
}