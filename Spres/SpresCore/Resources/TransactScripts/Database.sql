/****** Object:  Database [Spres]    Script Date: 11/1/2016 09:53:39 ******/
CREATE DATABASE [Spres]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Spres].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Spres] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Spres] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Spres] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Spres] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Spres] SET ARITHABORT OFF 
GO
ALTER DATABASE [Spres] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Spres] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Spres] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Spres] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Spres] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Spres] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Spres] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Spres] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Spres] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Spres] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Spres] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Spres] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Spres] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Spres] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Spres] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Spres] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Spres] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Spres] SET RECOVERY FULL 
GO
ALTER DATABASE [Spres] SET  MULTI_USER 
GO
ALTER DATABASE [Spres] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Spres] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Spres] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Spres] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Spres] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Spres', N'ON'
GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeChristmasBonus]    Script Date: 11/1/2016 09:53:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeChristmasBonus](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	set @salary=dbo.fn_employeeSalary(@period,@target_id) / 12	

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeHolidays]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeHolidays](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	select @salary=dbo.fn_employeeSalary(@period,@target_id) / 30 * 15 * 0.3 / 12	

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeIndemnityProvision]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeIndemnityProvision](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	set @salary=dbo.fn_employeeSalary(@period,@target_id)

	if @salary >= 986.4
		set @salary = 986.4 / 12
	else
		set @salary = @salary / 12

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeLifeInsurance]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeLifeInsurance](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	select @salary=LifeInsurance * 0.32 / 1000
	from Employees
	where id=@target_id

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeMeals]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeMeals](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	if exists(select 1 from Benefits b inner join EmployeeBenefits eb on b.Id = eb.Benefit_Id where Employee_Id=@target_id and Code='CCAFET')
		set @salary=9.60
	else
		set @salary = 0
	
	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeNightlyBonus]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeNightlyBonus](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	if exists(select 1 from Benefits b inner join EmployeeBenefits eb on b.Id = eb.Benefit_Id where Employee_Id=@target_id and Code='BONONI')
		set @salary= dbo.fn_employeeSalary(@period,@target_id) / 30 / 7 * 0.25 * 15 / 2
	else
		set @salary = 0
	
	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeRetirementPlan]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeRetirementPlan](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	select @salary=sum(d.Target) from BudgetMonthDetails d inner join BudgetLines l
	on d.LineId=l.Id inner join BudgetSheets s
	on l.SheetId=s.Id inner join Budgets b
	on s.BudgetId=b.Id
	where l.AccountId in (2,221,3,222,4,223,6,7,225,226,14,233,29,248)
		and l.Tag = @target_id
		and d.Month = month(@period)
		and b.FiscalYear = year(@period)
	
	if @salary <= 6377.15
		set @salary *= 0.675
	else
		set @salary = 6377.15 * 0.675

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeSalary]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeSalary](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	select @salary=Salary + (Salary / 30 * 5 / 12)
	from Employees
	where id=@target_id

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeSocialSecurity]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeSocialSecurity](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	select @salary=sum(d.Target) from BudgetMonthDetails d inner join BudgetLines l
	on d.LineId=l.Id inner join BudgetSheets s
	on l.SheetId=s.Id inner join Budgets b
	on s.BudgetId=b.Id
	where l.AccountId in (2,221,3,222,4,223,6,7,225,226,14,233,29,248)
		and l.Tag = @target_id
		and d.Month = month(@period)
		and b.FiscalYear = year(@period)
	
	if @salary <= 685.71
		set @salary *= 0.085
	else
		set @salary = 685.71 * 0.085

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeTargetBonus]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeTargetBonus](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	declare @targetBonus nvarchar(30)

	select @targetBonus = code from Benefits b inner join EmployeeBenefits eb on b.Id = eb.Benefit_Id where Employee_Id=@target_id and Code in ('BONO25','BONO30')
	
	if @targetBonus is null
		set @salary = 0
	else
	begin

		declare @coef money, @perc money

		if month(@period) > 3 set @coef = 1 else set @coef = 0.8
		if @targetBonus = 'BONO25' set @perc = 0.25 else set @perc = 0.3

		set @salary=(dbo.fn_employeeSalary(@period,@target_id) * @perc * 13) / 12 * @coef

	end			

	return @salary

end

GO
/****** Object:  UserDefinedFunction [dbo].[fn_employeeVariableSalary]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_employeeVariableSalary](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	select @salary=isnull(Variable * 0.8,0)
	from Employees
	where id=@target_id

	return @salary

end

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountBudgetSources]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountBudgetSources](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Source] [nvarchar](max) NULL,
	[Formule] [nvarchar](max) NULL,
	[AccountId] [int] NOT NULL,
	[ExpenseType] [int] NOT NULL,
	[PremiseTypeId] [int] NULL,
 CONSTRAINT [PK_dbo.AccountBudgetSources] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ParentId] [int] NULL,
	[Type] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Accounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[PasswordTemp] [nvarchar](max) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Benefits]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benefits](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Target] [int] NOT NULL,
	[Code] [nvarchar](30) NOT NULL DEFAULT (''),
 CONSTRAINT [PK_dbo.Benefits] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BudgetLines]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetLines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SheetId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[AccountId] [int] NOT NULL,
	[ParentId] [int] NULL,
	[PremiseId] [int] NULL,
	[Tag] [int] NULL,
 CONSTRAINT [PK_dbo.BudgetLines] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BudgetMonthDetails]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetMonthDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LineId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [decimal](18, 2) NOT NULL,
	[Target] [decimal](18, 2) NOT NULL,
	[Forecast] [decimal](18, 2) NOT NULL,
	[ExpenseDetail] [xml] NULL,
	[Real] [decimal](18, 2) NOT NULL,
	[Month] [int] NOT NULL,
 CONSTRAINT [PK_dbo.BudgetMonthDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Budgets]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Budgets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FiscalYear] [int] NOT NULL,
	[Authorized] [bit] NOT NULL,
	[CostCenterId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[Reviewed] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Budgets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BudgetSheets]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetSheets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [int] NOT NULL,
	[BudgetId] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.BudgetSheets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Companies]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Country] [nvarchar](2) NOT NULL,
 CONSTRAINT [PK_dbo.Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CostCenters]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostCenters](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[ParentId] [int] NULL,
	[Responsible_Id] [int] NULL,
	[Type] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.CostCenters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [nvarchar](2) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DefaultCurrencyId] [nvarchar](3) NOT NULL DEFAULT (''),
 CONSTRAINT [PK_dbo.Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Currencies]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currencies](
	[Id] [nvarchar](3) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Currencies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeBenefits]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeBenefits](
	[Employee_Id] [int] NOT NULL,
	[Benefit_Id] [int] NOT NULL,
 CONSTRAINT [PK_dbo.EmployeeBenefits] PRIMARY KEY CLUSTERED 
(
	[Employee_Id] ASC,
	[Benefit_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[UserId] [nvarchar](255) NULL,
	[PositionId] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[CostCenterId] [int] NULL,
	[Variable] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[LifeInsurance] [decimal](18, 2) NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Equipments]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Equipments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyId] [nvarchar](3) NOT NULL,
	[TradeDate] [datetime] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_dbo.ExchangeRates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PackageAccounts]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageAccounts](
	[Package_Id] [int] NOT NULL,
	[Account_Id] [int] NOT NULL,
 CONSTRAINT [PK_dbo.PackageAccounts] PRIMARY KEY CLUSTERED 
(
	[Package_Id] ASC,
	[Account_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Packages]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Packages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[EmployeeId] [int] NULL,
 CONSTRAINT [PK_dbo.Packages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[RolId] [nvarchar](128) NOT NULL,
	[Option] [int] NOT NULL,
	[View] [bit] NOT NULL,
	[Edit] [bit] NOT NULL,
	[Process] [bit] NOT NULL,
	[CostCenterFilter] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Permissions] PRIMARY KEY CLUSTERED 
(
	[RolId] ASC,
	[Option] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PositionEquipments]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PositionEquipments](
	[Position_Id] [int] NOT NULL,
	[Equipment_Id] [int] NOT NULL,
 CONSTRAINT [PK_dbo.PositionEquipments] PRIMARY KEY CLUSTERED 
(
	[Position_Id] ASC,
	[Equipment_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Positions]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Positions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CompanyId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Positions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Premises]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Premises](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Expenses] [xml] NULL,
	[FiscalYear] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[PremiseTypeId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Premises] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PremiseTypes]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremiseTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Definition] [xml] NOT NULL,
 CONSTRAINT [PK_dbo.PremiseTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Programmings]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programmings](
	[FiscalYear] [int] NOT NULL,
	[BudgetStartDate] [datetime] NOT NULL,
	[BudgetEndDate] [datetime] NOT NULL,
	[CompanyId] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Programmings] PRIMARY KEY CLUSTERED 
(
	[FiscalYear] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Providers]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Providers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ProviderTypeId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Providers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProviderTypes]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProviderTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PremiseTypeId] [int] NULL,
 CONSTRAINT [PK_dbo.ProviderTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_AccountId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_AccountId] ON [dbo].[AccountBudgetSources]
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PremiseTypeId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_PremiseTypeId] ON [dbo].[AccountBudgetSources]
(
	[PremiseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ParentId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_ParentId] ON [dbo].[Accounts]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 11/1/2016 09:53:40 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 11/1/2016 09:53:40 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AccountId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_AccountId] ON [dbo].[BudgetLines]
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ParentId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_ParentId] ON [dbo].[BudgetLines]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PremiseId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_PremiseId] ON [dbo].[BudgetLines]
(
	[PremiseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SheetId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_SheetId] ON [dbo].[BudgetLines]
(
	[SheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LineId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_LineId] ON [dbo].[BudgetMonthDetails]
(
	[LineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CostCenterId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_CostCenterId] ON [dbo].[Budgets]
(
	[CostCenterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FiscalYear_CompanyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_FiscalYear_CompanyId] ON [dbo].[Budgets]
(
	[FiscalYear] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BudgetId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_BudgetId] ON [dbo].[BudgetSheets]
(
	[BudgetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PackageId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_PackageId] ON [dbo].[BudgetSheets]
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CompanyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_CompanyId] ON [dbo].[CostCenters]
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ParentId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_ParentId] ON [dbo].[CostCenters]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Responsible_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Responsible_Id] ON [dbo].[CostCenters]
(
	[Responsible_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DefaultCurrencyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_DefaultCurrencyId] ON [dbo].[Countries]
(
	[DefaultCurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Benefit_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Benefit_Id] ON [dbo].[EmployeeBenefits]
(
	[Benefit_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employee_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Employee_Id] ON [dbo].[EmployeeBenefits]
(
	[Employee_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CostCenterId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_CostCenterId] ON [dbo].[Employees]
(
	[CostCenterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PositionId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_PositionId] ON [dbo].[Employees]
(
	[PositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CurrencyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_CurrencyId] ON [dbo].[ExchangeRates]
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Account_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Account_Id] ON [dbo].[PackageAccounts]
(
	[Account_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Package_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Package_Id] ON [dbo].[PackageAccounts]
(
	[Package_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EmployeeId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeId] ON [dbo].[Packages]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Equipment_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Equipment_Id] ON [dbo].[PositionEquipments]
(
	[Equipment_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Position_Id]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Position_Id] ON [dbo].[PositionEquipments]
(
	[Position_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CompanyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_CompanyId] ON [dbo].[Positions]
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FiscalYear_CompanyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_FiscalYear_CompanyId] ON [dbo].[Premises]
(
	[FiscalYear] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PremiseTypeId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_PremiseTypeId] ON [dbo].[Premises]
(
	[PremiseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CompanyId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_CompanyId] ON [dbo].[Programmings]
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProviderTypeId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_ProviderTypeId] ON [dbo].[Providers]
(
	[ProviderTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PremiseTypeId]    Script Date: 11/1/2016 09:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_PremiseTypeId] ON [dbo].[ProviderTypes]
(
	[PremiseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountBudgetSources]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AccountBudgetSources_dbo.Accounts_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountBudgetSources] CHECK CONSTRAINT [FK_dbo.AccountBudgetSources_dbo.Accounts_AccountId]
GO
ALTER TABLE [dbo].[AccountBudgetSources]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AccountBudgetSources_dbo.PremiseTypes_PremiseTypeId] FOREIGN KEY([PremiseTypeId])
REFERENCES [dbo].[PremiseTypes] ([Id])
GO
ALTER TABLE [dbo].[AccountBudgetSources] CHECK CONSTRAINT [FK_dbo.AccountBudgetSources_dbo.PremiseTypes_PremiseTypeId]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Accounts_dbo.Accounts_Parent_Id] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_dbo.Accounts_dbo.Accounts_Parent_Id]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[BudgetLines]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetLines_dbo.Accounts_AccountId] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BudgetLines] CHECK CONSTRAINT [FK_dbo.BudgetLines_dbo.Accounts_AccountId]
GO
ALTER TABLE [dbo].[BudgetLines]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetLines_dbo.BudgetLines_Parent_Id] FOREIGN KEY([ParentId])
REFERENCES [dbo].[BudgetLines] ([Id])
GO
ALTER TABLE [dbo].[BudgetLines] CHECK CONSTRAINT [FK_dbo.BudgetLines_dbo.BudgetLines_Parent_Id]
GO
ALTER TABLE [dbo].[BudgetLines]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetLines_dbo.BudgetSheets_SheetId] FOREIGN KEY([SheetId])
REFERENCES [dbo].[BudgetSheets] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BudgetLines] CHECK CONSTRAINT [FK_dbo.BudgetLines_dbo.BudgetSheets_SheetId]
GO
ALTER TABLE [dbo].[BudgetLines]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetLines_dbo.Premises_Premise_Id] FOREIGN KEY([PremiseId])
REFERENCES [dbo].[Premises] ([Id])
GO
ALTER TABLE [dbo].[BudgetLines] CHECK CONSTRAINT [FK_dbo.BudgetLines_dbo.Premises_Premise_Id]
GO
ALTER TABLE [dbo].[BudgetMonthDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetMonthDetails_dbo.BudgetLines_IdLine] FOREIGN KEY([LineId])
REFERENCES [dbo].[BudgetLines] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BudgetMonthDetails] CHECK CONSTRAINT [FK_dbo.BudgetMonthDetails_dbo.BudgetLines_IdLine]
GO
ALTER TABLE [dbo].[Budgets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Budgets_dbo.Companies_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Budgets] CHECK CONSTRAINT [FK_dbo.Budgets_dbo.Companies_CompanyId]
GO
ALTER TABLE [dbo].[Budgets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Budgets_dbo.CostCenters_CostCenterId] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[CostCenters] ([Id])
GO
ALTER TABLE [dbo].[Budgets] CHECK CONSTRAINT [FK_dbo.Budgets_dbo.CostCenters_CostCenterId]
GO
ALTER TABLE [dbo].[Budgets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Budgets_dbo.Programmings_FiscalYear_CompanyId] FOREIGN KEY([FiscalYear], [CompanyId])
REFERENCES [dbo].[Programmings] ([FiscalYear], [CompanyId])
GO
ALTER TABLE [dbo].[Budgets] CHECK CONSTRAINT [FK_dbo.Budgets_dbo.Programmings_FiscalYear_CompanyId]
GO
ALTER TABLE [dbo].[BudgetSheets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetSheets_dbo.Budgets_BudgetId] FOREIGN KEY([BudgetId])
REFERENCES [dbo].[Budgets] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BudgetSheets] CHECK CONSTRAINT [FK_dbo.BudgetSheets_dbo.Budgets_BudgetId]
GO
ALTER TABLE [dbo].[BudgetSheets]  WITH CHECK ADD  CONSTRAINT [FK_dbo.BudgetSheets_dbo.Packages_PackageId] FOREIGN KEY([PackageId])
REFERENCES [dbo].[Packages] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BudgetSheets] CHECK CONSTRAINT [FK_dbo.BudgetSheets_dbo.Packages_PackageId]
GO
ALTER TABLE [dbo].[CostCenters]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CostCenters_dbo.Companies_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
GO
ALTER TABLE [dbo].[CostCenters] CHECK CONSTRAINT [FK_dbo.CostCenters_dbo.Companies_CompanyId]
GO
ALTER TABLE [dbo].[CostCenters]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CostCenters_dbo.CostCenters_Parent_Id] FOREIGN KEY([ParentId])
REFERENCES [dbo].[CostCenters] ([Id])
GO
ALTER TABLE [dbo].[CostCenters] CHECK CONSTRAINT [FK_dbo.CostCenters_dbo.CostCenters_Parent_Id]
GO
ALTER TABLE [dbo].[CostCenters]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CostCenters_dbo.Employees_Responsible_Id] FOREIGN KEY([Responsible_Id])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[CostCenters] CHECK CONSTRAINT [FK_dbo.CostCenters_dbo.Employees_Responsible_Id]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Countries_dbo.Currencies_DefaultCurrencyId] FOREIGN KEY([DefaultCurrencyId])
REFERENCES [dbo].[Currencies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_dbo.Countries_dbo.Currencies_DefaultCurrencyId]
GO
ALTER TABLE [dbo].[EmployeeBenefits]  WITH CHECK ADD  CONSTRAINT [FK_dbo.EmployeeBenefits_dbo.Benefits_Benefit_Id] FOREIGN KEY([Benefit_Id])
REFERENCES [dbo].[Benefits] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployeeBenefits] CHECK CONSTRAINT [FK_dbo.EmployeeBenefits_dbo.Benefits_Benefit_Id]
GO
ALTER TABLE [dbo].[EmployeeBenefits]  WITH CHECK ADD  CONSTRAINT [FK_dbo.EmployeeBenefits_dbo.Employees_Employee_Id] FOREIGN KEY([Employee_Id])
REFERENCES [dbo].[Employees] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployeeBenefits] CHECK CONSTRAINT [FK_dbo.EmployeeBenefits_dbo.Employees_Employee_Id]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.CostCenters_CostCenterId] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[CostCenters] ([Id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.CostCenters_CostCenterId]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employees_dbo.Positions_PositionId] FOREIGN KEY([PositionId])
REFERENCES [dbo].[Positions] ([Id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_dbo.Employees_dbo.Positions_PositionId]
GO
ALTER TABLE [dbo].[ExchangeRates]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ExchangeRates_dbo.Currencies_CurrencyId] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currencies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExchangeRates] CHECK CONSTRAINT [FK_dbo.ExchangeRates_dbo.Currencies_CurrencyId]
GO
ALTER TABLE [dbo].[PackageAccounts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PackageAccounts_dbo.Accounts_Account_Id] FOREIGN KEY([Account_Id])
REFERENCES [dbo].[Accounts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageAccounts] CHECK CONSTRAINT [FK_dbo.PackageAccounts_dbo.Accounts_Account_Id]
GO
ALTER TABLE [dbo].[PackageAccounts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PackageAccounts_dbo.Packages_Package_Id] FOREIGN KEY([Package_Id])
REFERENCES [dbo].[Packages] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageAccounts] CHECK CONSTRAINT [FK_dbo.PackageAccounts_dbo.Packages_Package_Id]
GO
ALTER TABLE [dbo].[Packages]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Packages_dbo.Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[Packages] CHECK CONSTRAINT [FK_dbo.Packages_dbo.Employees_EmployeeId]
GO
ALTER TABLE [dbo].[PositionEquipments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PositionEquipments_dbo.Equipments_Equipment_Id] FOREIGN KEY([Equipment_Id])
REFERENCES [dbo].[Equipments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PositionEquipments] CHECK CONSTRAINT [FK_dbo.PositionEquipments_dbo.Equipments_Equipment_Id]
GO
ALTER TABLE [dbo].[PositionEquipments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PositionEquipments_dbo.Positions_Position_Id] FOREIGN KEY([Position_Id])
REFERENCES [dbo].[Positions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PositionEquipments] CHECK CONSTRAINT [FK_dbo.PositionEquipments_dbo.Positions_Position_Id]
GO
ALTER TABLE [dbo].[Positions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Positions_dbo.Companies_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Positions] CHECK CONSTRAINT [FK_dbo.Positions_dbo.Companies_CompanyId]
GO
ALTER TABLE [dbo].[Premises]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Premises_dbo.Companies_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Premises] CHECK CONSTRAINT [FK_dbo.Premises_dbo.Companies_CompanyId]
GO
ALTER TABLE [dbo].[Premises]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Premises_dbo.PremiseTypes_PremiseTypeId] FOREIGN KEY([PremiseTypeId])
REFERENCES [dbo].[PremiseTypes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Premises] CHECK CONSTRAINT [FK_dbo.Premises_dbo.PremiseTypes_PremiseTypeId]
GO
ALTER TABLE [dbo].[Premises]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Premises_dbo.Programmings_FiscalYear_CompanyId] FOREIGN KEY([FiscalYear], [CompanyId])
REFERENCES [dbo].[Programmings] ([FiscalYear], [CompanyId])
GO
ALTER TABLE [dbo].[Premises] CHECK CONSTRAINT [FK_dbo.Premises_dbo.Programmings_FiscalYear_CompanyId]
GO
ALTER TABLE [dbo].[Programmings]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Programmings_dbo.Companies_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Programmings] CHECK CONSTRAINT [FK_dbo.Programmings_dbo.Companies_CompanyId]
GO
ALTER TABLE [dbo].[Providers]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Providers_dbo.ProviderTypes_ProviderType_Id] FOREIGN KEY([ProviderTypeId])
REFERENCES [dbo].[ProviderTypes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Providers] CHECK CONSTRAINT [FK_dbo.Providers_dbo.ProviderTypes_ProviderType_Id]
GO
ALTER TABLE [dbo].[ProviderTypes]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ProviderTypes_dbo.PremiseTypes_PremiseTypeId] FOREIGN KEY([PremiseTypeId])
REFERENCES [dbo].[PremiseTypes] ([Id])
GO
ALTER TABLE [dbo].[ProviderTypes] CHECK CONSTRAINT [FK_dbo.ProviderTypes_dbo.PremiseTypes_PremiseTypeId]
GO
/****** Object:  StoredProcedure [dbo].[getConsolidatedBudget]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getConsolidatedBudget]
(
	@fiscal int,
	@company int
)
as
begin
	set language Spanish 
	select * from (
						select
							cc.Code [CECO],
							a.Code [Cuenta],
							cc.code + a.Code [Match],
							DateName( month , DateAdd( month , bmd.Month , -1 ) ) [Mes],
							bmd.Target [Target]
						from 
							CostCenters cc
							inner join Budgets b on b.CostCenterId = cc.Id
							inner join BudgetSheets bs on bs.BudgetId = b.Id
							inner join PackageAccounts pa on pa.Package_Id = bs.PackageId
							inner join Accounts a on pa.Account_Id = a.Id
							inner join BudgetLines bl on bl.AccountId = a.Id and bl.SheetId = bs.Id
							inner join BudgetMonthDetails bmd on bmd.LineId = bl.Id
						where
							a.ParentId is not null
							and bl.Tag is null
							and b.FiscalYear = @fiscal
							and b.CompanyId = @company
					)
	as Model pivot (
					Sum(Target) for Mes IN 
					([Enero], [Febrero], [Marzo], [Abril], [Mayo], [Junio], [Julio],
					[Agosto], [Septiembre], [Octubre], [Noviembre], [Diciembre] )) AS Fila
					WHERE Enero > 0 or Febrero > 0 or Marzo > 0 or Abril > 0 or Mayo > 0 or Junio > 0 or Julio > 0	or Agosto > 0 or Septiembre > 0 or Octubre > 0 or Noviembre > 0 or Diciembre > 0
	for xml auto, elements, root('Filas')
	return
end

GO
/****** Object:  StoredProcedure [dbo].[PeriodsBudgetCalculation]    Script Date: 11/1/2016 09:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[PeriodsBudgetCalculation]
	@target_line int,
	@target_id int
as
begin

	declare @periodsbudget table(
		budgetmonth int,
		cost money
	)

	declare @account_id int, @year int, @source nvarchar(100), @formule nvarchar(100), @expense_type int

	select @account_id=bl.AccountId, @year=b.FiscalYear
	from BudgetLines bl inner join BudgetSheets bs
	on bl.SheetId = bs.Id inner join Budgets b
	on bs.BudgetId = b.Id
	where bl.Id=@target_line
	
	
	if exists(select 1 from Accounts where Id=@account_id and ParentId is null)
		return

	
	
	select @source=Source, @formule=Formule, @expense_type=ExpenseType from AccountBudgetSources ab
	where ab.AccountId=@account_id

	if @expense_type <> 1
		raiserror('No se puede calcular el presupuesto para una fuente diferente a formula',16,1)

	if isnull(@formule,'') = ''
		return

	declare @period datetime, @month int, @scriptModel nvarchar(200), @cost money

	select @month=1,@scriptModel = N'select @cost=' + @formule + '(@period,@target_id)'

	while @month <= 12
	begin
		set @period = convert(varchar,@year) + '-' + convert(varchar,@month) + '-1'
		
		execute sp_executesql @scriptModel,N'@cost money output, @period datetime, @target_id int',@cost=@cost output, @period = @period, @target_id = @target_id

		insert @periodsbudget
		select month(@period),@cost

		set @month += 1

	end

	select * from @periodsbudget
end

GO
ALTER DATABASE [Spres] SET  READ_WRITE 
GO
