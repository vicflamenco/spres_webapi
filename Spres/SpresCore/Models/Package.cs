﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool
//     Changes to this file will be lost if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
namespace Spres.Models
{
    using System.Collections.Generic;

    public class Package
    {
        public Package()
        {
            Accounts = new HashSet<Account>();
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public bool HR { get; set; } // Human Resources (Recursos Humanos)
        public string ManagerGUID { get; set; }
        

        public virtual ICollection<Account> Accounts { get; set; }
    }
}
