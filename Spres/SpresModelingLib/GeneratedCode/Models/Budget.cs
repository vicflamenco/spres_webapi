﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool
//     Changes to this file will be lost if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
namespace Models
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Text;

	public class Budget
	{
		public virtual int FiscalYear
		{
			get;
			set;
		}

		public virtual int Id
		{
			get;
			set;
		}

		public virtual bool Authorized
		{
			get;
			set;
		}

		public virtual BudgetSheet Sheets
		{
			get;
			set;
		}

		public virtual CostCenter CostCenter
		{
			get;
			set;
		}

		public virtual Company Company
		{
			get;
			set;
		}

	}
}

