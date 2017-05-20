namespace Spres.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Spres.Models;
    using System.Collections.Generic;
    using System.IO;

    internal sealed class Configuration : DbMigrationsConfiguration<Spres.Infrastructure.SpresContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(Spres.Infrastructure.SpresContext context)
        {
        }
    }
}
