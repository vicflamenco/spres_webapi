﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool
//     Changes to this file will be lost if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
namespace Spres.Models
{
    using System.Collections.Generic;

    public class Position
	{
        public Position()
        {
            Employees = new HashSet<Employee>();
            Equipments = new HashSet<Equipment>();
        }
		public  int Id { get; set; }

		public  string Name { get; set; }

        public int CompanyId { get; set; }
        public virtual Company Company { get; set; }

		public virtual  ICollection<Employee> Employees { get; set; }

		public virtual ICollection<Equipment> Equipments{ get; set; }

	}
}

