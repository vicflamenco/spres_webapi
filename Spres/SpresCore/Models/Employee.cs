﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool
//     Changes to this file will be lost if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
using System.Collections.Generic;
namespace Spres.Models
{

    public class Employee
	{
    
		public  int Id { get; set; }

		public  string Code { get; set; }

		public  string Name { get; set; }

		public  string UserId { get; set; }

        public bool Active { get; set; }

        public decimal Salary { get; set; }

        public decimal Variable { get; set; }

        public decimal LifeInsurance { get; set; }

        public int? PositionId { get; set; }
        public virtual Position Position { get; set; }

        public virtual ICollection<Benefit> Benefits { get; set; }
        public int? CostCenterId { get; set; }
        public virtual CostCenter CostCenter { get; set; }

    }
}

