using Spres.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SpresDev.Models
{
    public class BudgetLineViewModel
    {
        public int Id { get; set; } // Guarda el BudgetLineId

        public int? ParentId { get; set; }
        public int? LevelOneId { get; set; } // Id para relacionar una linea padre con las cuentas hijos (niveles jerárquicos 1 y 2)
        public int? LevelTwoId { get; set; } // Id para relacionar una linea hijo con sus cuentas hijas (niveles jerárquicos 2 y 3)
        public BudgetExpenseType ExpenseType { get; set; }
        public int? PremiseId { get; set; }
        public int AccountId { get; set; }
        public string Description { get; set; }

        // ENERO
        public int January_Quantity { get; set; }
        public decimal January_UnitCost { get; set; }
        public decimal January_Target { get; set; }
        public decimal January_Forecast { get; set; }
        public decimal January_Real { get; set; }


        // FEBRERO
        public int February_Quantity { get; set; }
        public decimal February_UnitCost { get; set; }
        public decimal February_Target { get; set; }
        public decimal February_Forecast { get; set; }
        public decimal February_Real { get; set; }


        // MARZO
        public int March_Quantity { get; set; }
        public decimal March_UnitCost { get; set; }
        public decimal March_Target { get; set; }
        public decimal March_Forecast { get; set; }
        public decimal March_Real { get; set; }


        //  ABRIL
        public int April_Quantity { get; set; }
        public decimal April_UnitCost { get; set; }
        public decimal April_Target { get; set; }
        public decimal April_Forecast { get; set; }
        public decimal April_Real { get; set; }

        // MAYO
        public int May_Quantity { get; set; }
        public decimal May_UnitCost { get; set; }
        public decimal May_Target { get; set; }
        public decimal May_Forecast { get; set; }
        public decimal May_Real { get; set; }


        // JUNIO
        public int June_Quantity { get; set; }
        public decimal June_UnitCost { get; set; }
        public decimal June_Target { get; set; }
        public decimal June_Forecast { get; set; }
        public decimal June_Real { get; set; }


        // JULIO
        public int July_Quantity { get; set; }
        public decimal July_UnitCost { get; set; }
        public decimal July_Target { get; set; }
        public decimal July_Forecast { get; set; }
        public decimal July_Real { get; set; }


        // AGOSTO
        public int August_Quantity { get; set; }
        public decimal August_UnitCost { get; set; }
        public decimal August_Target { get; set; }
        public decimal August_Forecast { get; set; }
        public decimal August_Real { get; set; }


        // SEPTIEMBRE 
        public int September_Quantity { get; set; }
        public decimal September_UnitCost { get; set; }
        public decimal September_Target { get; set; }
        public decimal September_Forecast { get; set; }
        public decimal September_Real { get; set; }


        // OCTUBRE
        public int October_Quantity { get; set; }
        public decimal October_UnitCost { get; set; }
        public decimal October_Target { get; set; }
        public decimal October_Forecast { get; set; }
        public decimal October_Real { get; set; }


        // NOVIEMBRE
        public int November_Quantity { get; set; }
        public decimal November_UnitCost { get; set; }
        public decimal November_Target { get; set; }
        public decimal November_Forecast { get; set; }
        public decimal November_Real { get; set; }


        // DICIEMBRE
        public int December_Quantity { get; set; }
        public decimal December_UnitCost { get; set; }
        public decimal December_Target { get; set; }
        public decimal December_Forecast { get; set; }
        public decimal December_Real { get; set; }


        public decimal Summary_YearTotal { get; set; }
        public decimal Summary_PreviousYear { get; set; }
        public decimal Summary_DifferenceTotal { get; set; }
        public decimal Summary_DifferencePercentage { get; set; }
    }
}
