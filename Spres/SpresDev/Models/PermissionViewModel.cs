using SpresDev.Controllers.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class PermissionViewModel
    {
        public PermissionViewModel(int id)
        {
            this.RolId = 0;
            this.OptionId = id;
            this.Option = PermissionsController.GetPermissionsTypes(id, 0);
            this.Display = PermissionsController.GetPermissionsTypes(id, 1);
            this.View = false;
            this.Edit = false;
            this.Process = false;
            this.AllCostCenters = false;
        }

        public int RolId { get; set; }
        public int OptionId { get; set; }
        public string Option { get; set; }
        public string Display { get; set; }
        public bool View { get; set; }
        public bool Edit { get; set; }
        public bool Process { get; set; }
        public bool AllCostCenters { get; set; }
    }
}