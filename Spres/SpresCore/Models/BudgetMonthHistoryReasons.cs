using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public enum BudgetMonthHistoryReasons
    {
        Review = 0, // Ajuste en periodo presupuestario una vez que el presupuesto ya fue revisado o autorizado
        Adjustment = 1, // Ajuste en periodo de forecast (traslados de ahorros, ajustes de cuentas contables, ajustes de lineas de detalle)
        Increase = 2 // Incrementos de presupuesto
    }
}
