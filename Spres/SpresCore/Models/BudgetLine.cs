﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool
//     Changes to this file will be lost if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
namespace Spres.Models
{
    using System.Collections.Generic;

    public class BudgetLine
    {
        public BudgetLine()
        {
            MonthDetails = new HashSet<BudgetMonthDetail>();
            Children = new HashSet<BudgetLine>();
        }

        public int Id { get; set; }


        // ID de BudgetLine (se asignará al momento de consultar los datos de la BD)
        public int Item { get; set; }

        public int? Tag { get; set; } // Id del empleado
        public int SheetId { get; set; }
        public virtual BudgetSheet Sheet { get; set; }

        public string Description { get; set; }

        public int? ParentId { get; set; }
        public BudgetLine Parent { get; set; }

        public int AccountId { get; set; }
        public virtual Account Account { get; set; }

        public int? PremiseId { get; set; }
        public virtual Premise Premise { get; set; }


        public virtual ICollection<BudgetLine> Children { get; set; }

        public virtual ICollection<BudgetMonthDetail> MonthDetails { get; set; }
    }
}

