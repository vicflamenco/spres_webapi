namespace Spres.Models
{
	using System;
    using System.Collections.Generic;

    public class Programming
	{
		public int FiscalYear { get; set; }

		public DateTime BudgetStartDate { get; set; }

		public DateTime BudgetEndDate { get; set; }


        public int CompanyId { get; set; }
        public virtual Company Company { get; set; }

        public virtual ICollection<ForecastProgramming> ForecastProgrammings { get; set; }
	}
}

