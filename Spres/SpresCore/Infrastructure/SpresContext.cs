using Spres.Mapping;
using Spres.Models;
using System.Data.Entity;
using Spres.Infrastructure.Security;
using Spres.Infrastructure.Audit;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Spres.Infrastructure
{
    public class SpresContext : DbContext
    {
        public SpresContext() : base("name=SpresContext")
        {
            //Database.SetInitializer<SpresContext>(null);
        }

        public DbSet<AccountBudgetSource> AccountBudgetSources { get; set; }
        public DbSet<Account> Accounts { get; set; }
        public DbSet<Benefit> Benefits { get; set; }
        public DbSet<Programming> Programmings { get; set; }
        public DbSet<Budget> Budgets { get; set; }
        public DbSet<BudgetMonthDetail> BudgetMonthDetails { get; set; }

        public DbSet<BudgetMonthHistory> BudgetMonthHistories { get; set; }
        public DbSet<BudgetSheet> BudgetSheets { get; set; }
        public DbSet<BudgetLine> BudgetLines { get; set; }
        public DbSet<Company> Companies { get; set; }

        public DbSet<CompanyAuthorizer> CompanyAuthorizers { get; set; }
        public DbSet<CostCenter> CostCenters { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<Event> Events { get; set; }
        public DbSet<Package> Packages { get; set; }
        public DbSet<Position> Positions { get; set; }
        public DbSet<Premise> Premises { get; set; }
        public DbSet<PremiseType> PremiseTypes { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<Provider> Providers { get; set; }
        public DbSet<ProviderType> ProviderTypes { get; set; }
        public DbSet<Equipment> Equipments { get; set; }
        public DbSet<Permissions> Permissions { get; set; }
        public DbSet<Currency> Currencies { get; set; }
        public DbSet<ExchangeRate> ExchangeRates { get; set; }
        public DbSet<BudgetAuthorization> BudgetAuthorizations { get; set; }
        public DbSet<EmailTemplate> EmailTemplates { get; set; }
        public DbSet<ForecastProgramming> ForecastProgrammings { get; set; }


        //Infrastructure
        //public DbSet<User> Users { get; set; }
        //public DbSet<Role> Roles { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Configurations.Add(new AccountMap());
            modelBuilder.Configurations.Add(new BenefitMap());
            modelBuilder.Configurations.Add(new BudgetLineMap());
            modelBuilder.Configurations.Add(new BudgetMap());
            modelBuilder.Configurations.Add(new BudgetMonthDetailMap());
            modelBuilder.Configurations.Add(new BudgetMonthHistoryMap());
            modelBuilder.Configurations.Add(new BudgetSheetMap());
            modelBuilder.Configurations.Add(new CompanyMap());
            modelBuilder.Configurations.Add(new CompanyAuthorizerMap());
            modelBuilder.Configurations.Add(new CostCenterMap());
            modelBuilder.Configurations.Add(new EmployeeMap());
            modelBuilder.Configurations.Add(new EventMap());
            modelBuilder.Configurations.Add(new PackageMap());
            modelBuilder.Configurations.Add(new PositionMap());
            modelBuilder.Configurations.Add(new PremiseTypeMap());
            modelBuilder.Configurations.Add(new PremiseMap());
            modelBuilder.Configurations.Add(new ProgrammingMap());
            modelBuilder.Configurations.Add(new CountryMap());
            modelBuilder.Configurations.Add(new ProviderTypeMap());
            modelBuilder.Configurations.Add(new ProviderMap());
            modelBuilder.Configurations.Add(new EquipmentMap());
            modelBuilder.Configurations.Add(new PermissionsMap());
            modelBuilder.Configurations.Add(new CurrencyMap());
            modelBuilder.Configurations.Add(new ExchangeRateMap());
            modelBuilder.Configurations.Add(new BudgetAuthorizationMap());
            modelBuilder.Configurations.Add(new ForecastProgrammingMap());
            //modelBuilder.Configurations.Add(new UserMap());
            //modelBuilder.Configurations.Add(new RoleMap());
        }

        public async Task<IEnumerable<PeriodsBudgetCalculationResult>> PeriodsBudgetCalculation(int targetLine, int targetEntityId)
        {
            var targetLineParameter = new SqlParameter("@target_line", targetLine);
            var targetEntityIdParameter = new SqlParameter("@target_id", targetEntityId);
            var result = await this.Database.SqlQuery<PeriodsBudgetCalculationResult>("dbo.PeriodsBudgetCalculation @target_line, @target_id",
                targetLineParameter, targetEntityIdParameter).ToListAsync();

            return result;
        }

        public async Task<int> PeopleAllCostCentersCalculation(int companyId, int fiscalYear, int packageId, int accountId)
        {
            var companyIdParameter = new SqlParameter("@companyid", companyId);
            var fiscalYearParameter = new SqlParameter("@fiscalyear", fiscalYear);
            var packageIdParameter = new SqlParameter("@packageid", packageId);
            var accountIdParameter = new SqlParameter("@accountid", accountId);
            this.Database.CommandTimeout = 180;
            var result = await this.Database.ExecuteSqlCommandAsync("dbo.PeopleAllCostCentersCalculation @companyid,@fiscalyear,@packageid,@accountid",
                companyIdParameter, fiscalYearParameter, packageIdParameter, accountIdParameter);
            return result;
        }

        public async Task<string> GetXMLConsolidatedBudget(int fiscal, int company)
        {
            var fiscalParameter = new SqlParameter("@fiscal", fiscal);
            var companyParameter = new SqlParameter("@company", company);
            var result = await this.Database.SqlQuery<string>("dbo.getConsolidatedBudget @fiscal, @company", fiscalParameter, companyParameter).ToListAsync();
            return string.Join(string.Empty, result);
        }

        public string GetAOPCalculation(int fiscalYear, int companyId, int accountId)
        {
            var fiscalYearParameter = new SqlParameter("@fiscalyear", fiscalYear);
            var companyIdParameter = new SqlParameter("@companyid", companyId);
            var accountIdParameter = new SqlParameter("@accountid", accountId);
            this.Database.CommandTimeout = 180;
            var result = this.Database.SqlQuery<string>("exec dbo.AOPCalculation @fiscalyear,@companyid,@accountid", fiscalYearParameter, companyIdParameter, accountIdParameter);
            return string.Join(string.Empty, result);
        }
    }
}
