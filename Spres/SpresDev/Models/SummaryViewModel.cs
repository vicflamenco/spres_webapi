using Spres.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SpresDev.Models
{
    public class SummaryViewModel
    {
        public int Id { get; set; } // Guarda el BudgetLineId
        public int? ParentId { get; set; }
        public int? LevelOneId { get; set; } // Id para relacionar una linea padre con las cuentas hijos (niveles jerárquicos 1 y 2)
        public int? LevelTwoId { get; set; } // Id para relacionar una linea hijo con sus cuentas hijas (niveles jerárquicos 2 y 3)
        public string Package { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public decimal CurrentTotal { get; set; }
        public decimal PreviousForecast { get; set; }
        public decimal VarTotalVSFrcst { get; set; }
        public decimal VarTotalVSFrcstCoin { get; set; }
        public decimal PreviousReal { get; set; }
        public decimal VarTotalVSPreviousReal { get; set; }
        public decimal VarTotalVSPreviousRealCoin { get; set; }
        
    }
}
