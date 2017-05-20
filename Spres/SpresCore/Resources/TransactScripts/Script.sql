USE Spres
GO

SET IDENTITY_INSERT EmailTemplates ON
GO

INSERT INTO EmailTemplates (Id, Name, Subject, Body) VALUES (1, 'UserCreated', 'Cuenta de usuario creada',
'<div>
	<h3>
		<strong><u>Sistema de administración de presupuestos (Spres)</u></strong>
	</h3>
	
	<h4>
		Su cuenta de usuario ha sido creada exitosamente con las siguientes credenciales:
	</h4>

	<p>
		<strong>Nombre: </strong> {0}
	</p>

	<p>
		<strong>Usuario: </strong> {1}
	</p>

    <p>
		<strong>Contraseña temporal: </strong> {2}
	</p>
</div>')

INSERT INTO EmailTemplates (Id, Name, Subject, Body) VALUES (2, 'PasswordChanged', 'Contraseña reseteada',
'<div>
	<h3>
		<strong><u>Sistema de administración de presupuestos (Spres)</u></strong>
	</h3>
	
	<h4>
		La contraseña de su cuenta de usuario ha sido reseteada exitosamente con las siguientes credenciales:
	</h4>

	<p>
		<strong>Nombre: </strong> {0}
	</p>

	<p>
		<strong>Usuario: </strong> {1}
	</p>

    <p>
		<strong>Contraseña temporal: </strong> {2}
	</p>
</div>')


INSERT INTO EmailTemplates (Id, Name, Subject, Body) VALUES (3, 'ProgrammingCreated', 'Período de presupuestación habilitado',
'<div>
	<h3>
		<strong><u>Sistema de administración de presupuestos (Spres)</u></strong>
	</h3>
	
	<h4>
		El siguiente período de presupuestación ha sido habilitado:
	</h4>

	<p>
		<strong>Año fiscal: </strong> {0}
	</p>

	<p>
		<strong>Fecha de inicio: </strong> {1}
	</p>

    <p>
		<strong>Fecha final: </strong> {2}
	</p>
</div>')


INSERT INTO EmailTemplates (Id, Name, Subject, Body) VALUES (4, 'ProgrammingChanged', 'Período de presupuestación modificado',
'<div>
	<h3>
		<strong><u>Sistema de administración de presupuestos (Spres)</u></strong>
	</h3>
	
	<h4>
		El siguiente período de presupuestación ha sido modificado:
	</h4>

	<p>
		<strong>Año fiscal: </strong> {0}
	</p>

	<p>
		<strong>Fecha de inicio: </strong> {1}
	</p>

    <p>
		<strong>Fecha final: </strong> {2}
	</p>
</div>')

INSERT INTO EmailTemplates (Id, Name, Subject, Body) VALUES (5, 'AuthorizationRequested', 'Solicitud de autorización de presupuesto',
'<div>
	<h3>
		<strong><u>Sistema de administración de presupuestos (Spres)</u></strong>
	</h3>
	
	<h4>
		Tiene una nueva petición de autorización de presupuesto:
	</h4>

	<p>
		<strong>Responsable: </strong> {0}
	</p>

	<p>
		<strong>Región: </strong> {1}
	</p>

    <p>
		<strong>Año fiscal: </strong> {2}
	</p>

	<p>
		<strong>Centro de costos: </strong> {3}
	</p>
</div>')


INSERT INTO EmailTemplates (Id, Name, Subject, Body) VALUES (6, 'BudgetAuthorized', 'Autorización de presupuesto',
'<div>
	<h3>
		<strong><u>Sistema de administración de presupuestos (Spres)</u></strong>
	</h3>
	
	<h4>
		El siguiente presupuesto ha recibido una nueva aprobación:
	</h4>

	<p>
		<strong>Región: </strong> {0}
	</p>

    <p>
		<strong>Año fiscal: </strong> {1}
	</p>

	<p>
		<strong>Centro de costos: </strong> {2}
	</p>

	<p>
		<strong>Autorizado por: </strong> {3}
	</p>
</div>')

SET IDENTITY_INSERT EmailTemplates OFF
GO

DELETE Currencies
GO
INSERT INTO Currencies(Id,Name) VALUES ('MXN','Peso Mexicano')
INSERT INTO Currencies(Id,Name) VALUES ('GTQ','Quetzal')
INSERT INTO Currencies(Id,Name) VALUES ('USD','US Dólar')

DELETE Countries
GO
INSERT INTO Countries(Id,Name,DefaultCurrencyId) VALUES ('MX','México','MXN')
INSERT INTO Countries(Id,Name,DefaultCurrencyId) VALUES ('SV','El Salvador','USD')
INSERT INTO Countries(Id,Name,DefaultCurrencyId) VALUES ('GT','Guatemala','GTQ')
INSERT INTO Countries(Id,Name,DefaultCurrencyId) VALUES ('CO','Colombia','GTQ')
INSERT INTO Countries(Id,Name,DefaultCurrencyId) VALUES ('EC','Ecuador','GTQ')
GO
DELETE Employees
GO
DELETE Positions
GO
DELETE CostCenters
GO
DELETE Companies
GO
SET IDENTITY_INSERT Companies ON
GO
INSERT INTO Companies(Id,Name,Country) VALUES (1,'El Salvador','SV')
INSERT INTO Companies(Id,Name,Country) VALUES (2,'Guatemala','GT')
INSERT INTO Companies(Id,Name,Country) VALUES (3,'México','MX')
INSERT INTO Companies(Id,Name,Country) VALUES (4,'CA Norte','GT')
INSERT INTO Companies(Id,Name,Country) VALUES (5,'CA, USA & Caribe','GT')
INSERT INTO Companies(Id,Name,Country) VALUES (6,'Colombia','CO')
INSERT INTO Companies(Id,Name,Country) VALUES (7,'Ecuador','EC')
GO
SET IDENTITY_INSERT Companies OFF


SET IDENTITY_INSERT ExchangeRates ON
GO
INSERT INTO ExchangeRates(Id,CurrencyId,TradeDate,Rate) VALUES (2,'GTQ','2016-01-01', 7.6399)
INSERT INTO ExchangeRates(Id,CurrencyId,TradeDate,Rate) VALUES (1,'MXN','2016-01-01', 17.8957)
GO
SET IDENTITY_INSERT ExchangeRates OFF
GO

DELETE Programmings
GO
INSERT INTO Programmings(FiscalYear,BudgetStartDate,BudgetEndDate,CompanyId) VALUES (2016,'2016-01-01', '2016-01-31',1)
GO
INSERT ForecastProgrammings(FiscalYear,CompanyId,Item) VALUES (2016,1,1), (2016,1,2), (2016,1,3)
GO
DELETE ProviderTypes
GO
DELETE AccountBudgetSources
GO
DELETE PremiseTypes
GO
SET IDENTITY_INSERT PremiseTypes ON
GO
INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (1,'Viajes',
	'<Definition VariableKey="Country" PremiseType="Travels"  Constraint="false"  OnlyConstraint="false">
        <Variables>
            <Variable Name="Country" Display="Destino" Type="Option" Source="Countries" Quantifiable="false" />
            <Variable Name="Breakfast" Type="Money" Quantifiable="true" Display="Desayuno" />
            <Variable Name="Lunch" Type="Money" Quantifiable="true" Display="Almuerzo" />
            <Variable Name="Dinner" Type="Money" Quantifiable="true" Display="Cena" />
            <Variable Name="Hotel" Type="Money" Quantifiable="true" Display="Hotel" />
            <Variable Name="Transportation" Type="Money" Quantifiable="true" Display="Pasaje" />
			<Variable Name="Others" Type="Money" Quantifiable="true" Display="Otros" />
        </Variables>
    </Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (2,'Papelería',
	'<Definition VariableKey="Stationery" PremiseType="Stationery"  Constraint="true" OnlyConstraint="false">
		<Variables>
			<Variable Name="Name" Type="Text" Display="Nombre" Quantifiable="false" />
			<Variable Name="Unit" Type="Text" Display="Unidad" Quantifiable="false" />
			<Variable Name="Cost" Type="Money" Display="Costo" Quantifiable="false" />
			<Variable Name="Provider" Type="Option" Display="Proveedor" Source="Providers" Quantifiable="false" />
		</Variables>
	</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (3,'Telefonía Fija',
	'<Definition VariableKey="FixedTelephony" PremiseType="FixedTelephony"  Constraint="true" OnlyConstraint="false">
		<Variables>
			<Variable Name="FixedCost" Type="Money" Display="Cuota fija" Quantifiable="false" />
		</Variables>
	</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (4,'Telefonía Móvil',
	'<Definition VariableKey="MobileTelephony" PremiseType="MobileTelephony"  Constraint="true" OnlyConstraint="false">
		<Variables>
			<Variable Name="PhoneNumber" Type="Text" Display="Número de teléfono" Quantifiable="false" />
			<Variable Name="Employee" Type="Option" Display="Empleado" Source="Employees" Quantifiable="false" />
			<Variable Name="Data" Type="Money" Display="Datos (MB)" Quantifiable="false" />
			<Variable Name="Cost" Type="Money" Display="Costo" Quantifiable="true" />
		</Variables>
	</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (5,'Mantenimiento y equipo de cómputo',
	'<Definition VariableKey="Maintenance" PremiseType="Maintenance"  Constraint="true" OnlyConstraint="false">
		<Variables>
			<Variable Name="Provider" Type="Option" Display="Proveedor" Source="Providers" Quantifiable="false" />
			<Variable Name="Cost" Type="Money" Display="Costo Unitario" Quantifiable="true" />
		</Variables>
	</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (6,'Fotoimpresión B y N',
'<Definition VariableKey="Imprint" PremiseType="Imprint"  Constraint="true" OnlyConstraint="false">
	<Variables>
		<Variable Name="Provider" Type="Option" Display="Proveedor" Source="Providers" Quantifiable="false" />
		<Variable Name="CopyType" Type="Text" Display="Tipo de Copia" Quantifiable="false" />
		<Variable Name="Cost" Type="Money" Display="Costo Unitario" Quantifiable="true" />
		<Variable Name="Location" Type="Text" Display="Ubicación" Quantifiable="false" />
	</Variables>
</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (7,'Cintas y Tóner',
'<Definition VariableKey="Toner" PremiseType="Toner"  Constraint="true" OnlyConstraint="false">
	<Variables>
		<Variable Name="Provider" Type="Option" Display="Proveedor" Source="Providers" Quantifiable="false" />
		<Variable Name="MeasurementType" Type="Text" Display="Tipo de medida" Quantifiable="false" />
		<Variable Name="Cost" Type="Money" Display="Costo Unitario" Quantifiable="true" />
		<Variable Name="ImprintType" Type="Text" Display="Tipo de impresión" Quantifiable="false" />
	</Variables>
</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (8,'Licenciamientos',
'<Definition VariableKey="Licencing" PremiseType="Licencing"  Constraint="true" OnlyConstraint="false">

	<Variables>
		<Variable Name="Provider" Type="Option" Display="Proveedor" Source="Providers" Quantifiable="false" />
		<Variable Name="LicenceType" Type="Text" Display="Tipo de Licencia" Quantifiable="false" />
		<Variable Name="Cost" Type="Money" Display="Costo" Quantifiable="true" />
	</Variables>
</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (9,'Equipos de protección',
	'<Definition VariableKey="Equipment" PremiseType="Equipment"  Constraint="true" OnlyConstraint="false">
		<Variables>
			<Variable Name="Equipment" Type="Option" Display="Equipo" Source="Equipments" Quantifiable="false" />
			<Variable Name="Expense" Type="Money" Display="Costo" Quantifiable="true" />
			<Variable Name="Provider" Type="Option" Display="Proveedor" Source="Providers" Quantifiable="false" />
		</Variables>
	</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (10,'Reparación y Mantenimiento de Plantas Telefonicas y Telefonos',
	'<Definition VariableKey="Employee" PremiseType="Equipment"  Constraint="true" OnlyConstraint="false">
		<Variables>
			<Variable Name="Expense" Type="Money" Display="Costo" Quantifiable="true" />
		</Variables>
	</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (11,'Enlace de Datos',
'<Definition VariableKey="Employee" PremiseType="Equipment"  Constraint="true" OnlyConstraint="false">
	<Variables>
		<Variable Name="Expense" Type="Money" Display="Costo" Quantifiable="true" />
	</Variables>
</Definition>')

INSERT INTO PremiseTypes(Id,Name,Definition) VALUES (12,'Líneas Restringidas',
'<Definition VariableKey="" PremiseType=""  Constraint="true" OnlyConstraint="true">
	<Variables>
		<Variable Name="UnitCost" Type="Money" Display="Costo Unitario" Quantifiable="true" />
		<Variable Name="Quantity" Type="Quantity" Display="Cantidad" Quantifiable="true" />
	</Variables>
</Definition>')

GO
SET IDENTITY_INSERT PremiseTypes OFF
GO

DELETE ProviderTypes
GO
SET IDENTITY_INSERT ProviderTypes ON
GO

INSERT INTO ProviderTypes(Id,Name,PremiseTypeId) VALUES (1,'Equipo de Protección',1)
INSERT INTO ProviderTypes(Id,Name,PremiseTypeId) VALUES (2,'Papelería',1)
INSERT INTO ProviderTypes(Id,Name,PremiseTypeId) VALUES (3,'Mantenimiento y equipo de cómputo',1)
INSERT INTO ProviderTypes(Id,Name,PremiseTypeId) VALUES (4,'Costo de fotoimpresión B y N',1)
INSERT INTO ProviderTypes(Id,Name,PremiseTypeId) VALUES (5,'Cintas y toner',1)
INSERT INTO ProviderTypes(Id,Name,PremiseTypeId) VALUES (6,'Licenciamiento',1)
GO
SET IDENTITY_INSERT ProviderTypes OFF
GO

DELETE Providers
GO
SET IDENTITY_INSERT Providers ON
GO

INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (1,'Ancora',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (2,'GM Group',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (3,'Bodega',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (4,'General Safety',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (5,'Insumos Diversos',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (6,'Quimsa',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (7,'Oxgasa',1)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (8,'Vasquez Chavez',3)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (9,'Valdez',3)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (10,'Equibarras',3)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (11,'UH Internacional',3)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (12,'PBS',3)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (13,'Diver, SA. DE CV.',3)
INSERT INTO Providers(Id,Name,ProviderTypeId) VALUES (14,'Papelería el Progreso',2)
GO

SET IDENTITY_INSERT Providers OFF
GO

DELETE Accounts
GO

SET IDENTITY_INSERT Packages ON
GO
INSERT Packages(Id,Name,HR) VALUES(1,'GENTE',1)
INSERT Packages(Id,Name,HR) VALUES(2,'PRESTACIONES',1)
INSERT Packages(Id,Name,HR) VALUES(3,'INDIRECTOS GENTE',1)
INSERT Packages(Id,Name,HR) VALUES(4,'VIAJES',0)
INSERT Packages(Id,Name,HR) VALUES(5,'TERCEROS',0)
INSERT Packages(Id,Name,HR) VALUES(6,'MANTENIMIENTO',0)
INSERT Packages(Id,Name,HR) VALUES(7,'ARRENDAMIENTOS',0)
INSERT Packages(Id,Name,HR) VALUES(8,'DISTRIBUCION',0)
INSERT Packages(Id,Name,HR) VALUES(9,'FLETES FIJOS',0)
INSERT Packages(Id,Name,HR) VALUES(10,'GASTOS ENERGETICOS',0)
INSERT Packages(Id,Name,HR) VALUES(11,'INFORMATICA',0)
INSERT Packages(Id,Name,HR) VALUES(12,'COMUNICACIONES',0)
INSERT Packages(Id,Name,HR) VALUES(13,'GASTOS DE OPERACIÓN',0)
INSERT Packages(Id,Name,HR) VALUES(14,'GASTOS GENERALES',0)
INSERT Packages(Id,Name,HR) VALUES(15,'GASTOS DE OCUPACION',0)
INSERT Packages(Id,Name,HR) VALUES(16,'GASTOS FINANCIEROS',0)
INSERT Packages(Id,Name,HR) VALUES(17,'MERCADEO',0)
INSERT Packages(Id,Name,HR) VALUES(18,'OTROS',0)
GO
SET IDENTITY_INSERT Packages OFF
GO
SET IDENTITY_INSERT Accounts ON
GO
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(1,'51110100','Sueldos/Salarios Ordinarios',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(2,'51110101','Sueldos/Salarios Ordinarios',1,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(3,'51110102','Bonos Salariales',1,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(4,'51110103','Sueldos/ Salarios Variables',1,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(5,'51110200','Sueldos/Salarios Extraordinarios',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(6,'51110201','Horas Extras Simples',5,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(7,'51110202','Horas Extras Dobles',5,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(8,'51110203','Días Festivos / Domingos',5,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(9,'51110300','Comisiones/Bonificaciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(10,'51110301','Comisiones  ',9,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(11,'51110302','Bonificaciones',9,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(12,'51110400','Bonos e Incentivos Patronales',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(13,'51110401','Bono por Resultados',12,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(14,'51110402','Bono Nocturno',12,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(15,'51110403','Bono Administración/ Vacional',12,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(16,'51110404','Contribucion para El Retiro',12,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(17,'51110500','Bonos e Incentivos Laborales',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(18,'51110501','Bono Incentivo Laboral',17,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(19,'51110502','Participación Trabajadores en las utilidades',17,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(20,'51110600','Beneficios Labores y Patronales',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(21,'51110601','Seguro Social',20,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(22,'51110602','Contribución Recreacional',20,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(23,'51110603','Contribución Educación',20,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(24,'51110604','Contribución Para El Retiro',20,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(25,'51110605','Contribución Para Vivienda',20,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(26,'51110700','Aguinaldo',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(27,'51110701','Aguinaldo',26,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(28,'51110800','Vacaciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(29,'51110801','Vacaciones',28,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(30,'51110900','Indemnizaciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(31,'51110901','Provisiones',30,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(32,'51110902','Liquidaciones Laborales',30,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(33,'51111000','Jubilaciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(34,'51111001','Jubilaciones',33,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(35,'51111100','Bono 14',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(36,'51111101','Bono 14',35,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(37,'51111200','Seguro sobre Empleo',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(38,'51111201','Seguros Empleados Federal',37,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(39,'51111202','Seguros Empleados Estatal',37,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(40,'51120100','Gastos de Viajes y Viaticos',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(41,'51120101','Viajes y Viaticos Locales',40,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(42,'51120102','Viajes y Viaticos Exterior',40,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(43,'51120103','Boletos de Transporte',40,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(44,'51120200','Gastos de Vehículo Colaboradores',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(45,'51120201','Depreciacion Vehiculos Empleados',44,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(46,'51120202','Combustible Vehiculos Empleados',44,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(47,'51120300','Consumo de Comestibles',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(48,'51120301','Cosumo de Cafeterias',47,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(49,'51120302','Consumo Interno de Producto',47,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(50,'51120303','Consumo de Actividades Operativas',47,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(51,'51120400','Medicinas',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(52,'51120401','Medicinas',51,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(53,'51120500','Seguridad Industrial',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(54,'51120501','Vestimenta de Personal',53,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(55,'51120502','Equipo de Proteccion Individual',53,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(56,'51120503','Seguridad del Area de Trabajo',53,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(57,'51120600','Gastos de Reclutamiento',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(58,'51120601','Investigaciones Socio-Economicas',57,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(59,'51120602','Anuncion / Publicaciones',57,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(60,'51120603','Servicios de Reclutamiento',57,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(61,'51120700','Publicaciones a Colaboradores',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(62,'51120701','Publicaciones a Empleados',61,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(63,'51120800','Relacionas Laborales',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(64,'51120801','Actividades y/o Eventos',63,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(65,'51120802','Transporte de Personal',63,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(66,'51120803','Reconocimientos a Empleados',63,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(67,'51120804','Ayudas y Pensiones',63,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(68,'51120805','Programas Educacionales',63,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(69,'51120806','Infraestructura para Eventos ',63,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(70,'51120900','Capacitacion',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(71,'51120901','Capacitacion / Material de Capacitacion',70,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(72,'51120902','Infraestructura para Capacitacion',70,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(73,'51121000','Seguros de Empleados',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(74,'51121001','Seguro de Vida',73,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(75,'51121002','Seguro Medico',73,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(76,'51121003','Seguro por Incapacidad',73,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(77,'51131100','Reparacion y Manteminiento de Edificios',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(78,'51131101','Reparacion y Manteminiento de Edificios',77,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(79,'51131200','Reparacion y Manteminiento de Muebles y Enseres',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(80,'51131201','Reparacion y Manteminiento de Muebles y Enseres',79,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(81,'51131300','Reparacion y Manteminiento de Equipo de Refrigeracion',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(82,'51131301','Coolers',81,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(83,'51131302','Equipo de Post Mix',81,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(84,'51131303','Billeteras / Monederas (Vending)',81,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(85,'51131400','Reparación y Mantenimiento de Equipo de Computo',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(86,'51131401','Reparacion y Mantenimiento de Servidores y Equipo de Red',85,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(87,'51131402','Reparacion y Mantenimiento de Software',85,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(88,'51131403','Reparación y Mantenimiento de Equipo de Computo Personal',85,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(89,'51131404','Reparación y Mantenimiento de Hand Helds',85,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(90,'51131405','Reparación y Mantenimiento de Equipos de Impresión',85,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(91,'51131500','Reparacion y Manteminiento de Maquinaria y Equipo',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(92,'51131501','Servicios Técnicos',91,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(93,'51131502','Repuestos',91,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(94,'51131503','Consumibles y/o Genericos',91,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(95,'51131600','Reparacion y Manteminiento de Vehiculos',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(96,'51131601','Reparacion de Camiones',95,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(97,'51131602','Motos',95,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(98,'51131603','Reparacion de Pick Ups / Paneles',95,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(99,'51131604','Reparacion de Automoviles',95,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(100,'51131605','Reparacion de Montacargas',95,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(101,'51131800','Seguros',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(102,'51131801','Instalaciones / Todo Riesgo',101,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(103,'51131802','Vehiculos',101,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(104,'51131803','Responsabilidad Civil',101,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(105,'51131804','Fianzas / Otros',101,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(106,'51131805','Directors & Officers',101,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(107,'51131900','Alquileres',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(108,'51131901','Inmuebles - Agencias / Bodegas',107,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(109,'51131902','Inmuebles - MiniBodegas / Locales',107,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(110,'51131903','Alquiler de Vehiculos',107,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(111,'51131904','Alquiler de Maquinaria y Equipo',107,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(112,'51132000','Lavado y Sanitizado de Envase',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(113,'51132001','Lavado y Sanitizado de Envase',112,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(114,'51132100','Rotura de Envase y Cajilla',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(115,'51132101','Rotura de Envase y Cajilla',114,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(116,'51132200','Producto Fuera de Norma',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(117,'51132201','Producto Fuera de Norma - Manufactura',116,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(118,'51132202','Producto Fuera de Norma - Agencias / Bodegas',116,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(119,'51132203','Producto Fuera de Norma - Mercado',116,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(120,'51132300','Fletes Fijos',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(121,'51132301','Fletes Fijos',120,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(122,'51132400','Impuestos y Contribuciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(123,'51132401','Territoriales',122,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(124,'51132402','Circulacion',122,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(125,'51132403','Tasas y/o Arbitrios Municipales',122,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(126,'51132404','Multas y/o Otros Recargos',122,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(127,'51132405','Otros Impuestos',122,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(128,'51132500','Llantas, Tubos y Accesorios',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(129,'51132501','Camiones',128,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(130,'51132502','Motos',128,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(131,'51132503','Pick Ups / Paneles',128,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(132,'51132504','Automoviles',128,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(133,'51132505','Montacargas',128,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(134,'51132600','Combustibles y Lubricantes',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(135,'51132601','Bunker',134,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(136,'51132602','Gasolina Regular',134,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(137,'51132603','Diesel',134,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(138,'51132604','Gas Propano',134,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(139,'51132605','Aceites, Lubricantes y Adhitivos',134,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(140,'51132700','Gastos de Aeronave',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(141,'51132701','Fijo',140,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(142,'51132702','Variable',140,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(143,'51132800','Materiales de Operación',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(144,'51132801','Tarimas de Madera',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(145,'51132802','Soda Caustica',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(146,'51132803','Lubricantes de Produccion',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(147,'51132804','Equipo de Laboratorio',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(148,'51132805','Material de Reempaque',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(149,'51132806','Otros Materiales de Operación',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(150,'51132807','Consumo de Agua',143,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(151,'51132900','Diferencia de Inventarios',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(152,'51132901','Diferencia de Inventarios',151,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(153,'51132902','Diferencia en Inventarios Envase',151,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(154,'51132903','Diferencia en Inventarios Cajilla',151,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(155,'51132904','Diferencia en Inventarios Otros',151,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(156,'51133000','Robos y Asaltos',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(157,'51133001','Robos y Asaltos',156,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(158,'51133100','Cuentas Incobrables',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(159,'51133101','Cuentas Incobrables',158,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(160,'51133200','Reconciliacion de la Renta',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(161,'51133201','Reconciliacion de la Renta',160,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(162,'51133202','Corporation Tax',160,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(163,'51133800','Baterias y Accesorios',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(164,'51133801','Camiones',163,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(165,'51133802','Motos',163,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(166,'51133803','Pick Ups / Paneles',163,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(167,'51133804','Automoviles',163,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(168,'51133805','Montacargas',163,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(169,'51140100','Servicio de Personas Ajenas',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(170,'51140101','Servicios Ejecutivos',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(171,'51140102','Servicios Bancarios',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(172,'51140103','Servicios Directos Linea de Produccion',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(173,'51140104','Impulsadores',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(174,'51140105','Servicios Medicos / Enfermeria',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(175,'51140106','Servicios de Mensajeria',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(176,'51140107','Servicios Tramites Aduanales',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(177,'51140108','Servicios de Conserjeria',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(178,'51140109','Servicios de Extraccion de Desechos',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(179,'51140110','Servicios Personal Logistico',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(180,'51140111','Cargos Servicios Compartidos',169,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(181,'51140200','Servicio de Seguridad y Vigilancia',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(182,'51140201','Seguridad y Vigilancia Instalaciones',181,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(183,'51140202','Seguridad y Vigilancia Movil',181,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(184,'51140203','Transporte Logistico y Custodia de Valores',181,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(185,'51140204','Servicios de Investigacion',181,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(186,'51140400','Honorarios / Consultoria Profesional',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(187,'51140401','Legales',186,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(188,'51140402','Consultoria Administrativa',186,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(189,'51140403','Consultoria Comercializacion',186,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(190,'51140404','Auditorias Externas',186,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(191,'51140405','Gastos Judiciales',186,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(192,'51150100','Donaciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(193,'51150101','Donaciones',192,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(194,'51150200','Gastos de Representacion y Relaciones Publicas',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(195,'51150201','Gastos de Representacion y Relaciones Publicas',194,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(196,'51150300','Materiales de Limpieza',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(197,'51150301','Materiales de Limpieza',196,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(198,'51150400','Gastos de Fotoimpresion',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(199,'51150401','Costo de Fotoimpresion',198,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(200,'51150402','Papel de Impresión',198,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(201,'51150403','Cintas, Toner o Cartucho para Fotoimpresion',198,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(202,'51150500','Dietas',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(203,'51150600','Tele-Comunicaciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(204,'51150501','Dietas',202,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(205,'51150601','Telefonia Fija',203,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(206,'51150602','Telefonia Movil',203,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(207,'51150603','Reparación y Mantenimiento de Plantas Telefonicas y Telefonos',203,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(208,'51150604','Enlaces de Datos',203,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(209,'51150605','Frecuncias de Radio',203,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(210,'51150800','Papeleria y Utiles',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(211,'51150801','Formatos y Formularios Preimpresos',210,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(212,'51150802',' ',210,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(213,'51150900','Energia Electrica',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(214,'51150901','Energia Electrica',213,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(215,'51151000','Cuotas y Suscripciones',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(216,'51151001','Contribuciones y/o Cuotas',215,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(217,'51151002','Suscripciones',215,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(218,'51151100','Activos No Capitalizables',NULL,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(219,'51151101','Activos No Capitalizables',218,'P')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(220,'61110100','Sueldos/Salarios Ordinarios',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(221,'61110101','Sueldos/Salarios Ordinarios',220,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(222,'61110102','Bonos Salariales',220,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(223,'61110103','Sueldos/ Salarios Variables',220,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(224,'61110200','Sueldos/Salarios Extraordinarios',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(225,'61110201','Horas Extras Simples',224,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(226,'61110202','Horas Extras Dobles',224,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(227,'61110203','Días Festivos / Domingos',224,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(228,'61110300','Comisiones/Bonificaciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(229,'61110301','Comisiones  ',228,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(230,'61110302','Bonificaciones',228,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(231,'61110400','Bonos e Incentivos Patronales',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(232,'61110401','Bono por Resultados',231,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(233,'61110402','Bono Nocturno',231,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(234,'61110403','Bono Administración/ Vacional',231,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(235,'61110404','Contribucion para El Retiro',231,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(236,'61110500','Bonos e Incentivos Laborales',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(237,'61110501','Bono Incentivo Laboral',236,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(238,'61110502','Participación Trabajadores en las utilidades',236,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(239,'61110600','Beneficios Labores y Patronales',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(240,'61110601','Seguro Social',239,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(241,'61110602','Contribución Recreacional',239,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(242,'61110603','Contribución Educación',239,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(243,'61110604','Contribución Para El Retiro',239,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(244,'61110605','Contribución Para Vivienda',239,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(245,'61110700','Aguinaldo',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(246,'61110701','Aguinaldo',245,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(247,'61110800','Vacaciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(248,'61110801','Vacaciones',247,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(249,'61110900','Indemnizaciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(250,'61110901','Provisiones',249,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(251,'61110902','Liquidaciones Laborales',249,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(252,'61111000','Jubilaciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(253,'61111001','Jubilaciones',252,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(254,'61111100','Bono 14',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(255,'61111101','Bono 14',254,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(256,'61111200','Seguro sobre Empleo',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(257,'61111201','Seguros Empleados Federal',256,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(258,'61111202','Seguros Empleados Estatal',256,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(259,'61120100','Gastos de Viajes y Viaticos',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(260,'61120101','Viajes y Viaticos Locales',259,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(261,'61120102','Viajes y Viaticos Exterior',259,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(262,'61120103','Boletos de Transporte',259,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(263,'61120200','Gastos de Vehículo Colaboradores',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(264,'61120201','Depreciacion Vehiculos Empleados',263,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(265,'61120202','Combustible Vehiculos Empleados',263,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(266,'61120300','Consumo de Comestibles',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(267,'61120301','Cosumo de Cafeterias',266,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(268,'61120302','Consumo Interno de Producto',266,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(269,'61120303','Consumo de Actividades Operativas',266,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(270,'61120400','Medicinas',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(271,'61120401','Medicinas',270,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(272,'61120500','Seguridad Industrial',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(273,'61120501','Vestimenta de Personal',272,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(274,'61120502','Equipo de Proteccion Individual',272,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(275,'61120503','Seguridad del Area de Trabajo',272,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(276,'61120600','Gastos de Reclutamiento',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(277,'61120601','Investigaciones Socio-Economicas',276,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(278,'61120602','Anuncion / Publicaciones',276,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(279,'61120603','Servicios de Reclutamiento',276,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(280,'61120700','Publicaciones a Colaboradores',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(281,'61120701','Publicaciones a Empleados',280,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(282,'61120800','Relacionas Laborales',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(283,'61120801','Actividades y/o Eventos',282,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(284,'61120802','Transporte de Personal',282,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(285,'61120803','Reconocimientos a Empleados',282,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(286,'61120804','Ayudas y Pensiones',282,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(287,'61120805','Programas Educacionales',282,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(288,'61120806','Infraestructura para Eventos ',282,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(289,'61120900','Capacitacion',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(290,'61120901','Capacitacion / Material de Capacitacion',289,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(291,'61120902','Infraestructura para Capacitacion',289,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(292,'61121000','Seguros de Empleados',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(293,'61121001','Seguro de Vida',292,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(294,'61121002','Seguro Medico',292,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(295,'61121003','Seguro por Incapacidad',292,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(296,'61131100','Reparacion y Manteminiento de Edificios',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(297,'61131101','Reparacion y Manteminiento de Edificios',296,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(298,'61131200','Reparacion y Manteminiento de Muebles y Enseres',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(299,'61131201','Reparacion y Manteminiento de Muebles y Enseres',298,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(300,'61131300','Reparacion y Manteminiento de Equipo de Refrigeracion',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(301,'61131301','Coolers',300,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(302,'61131302','Equipo de Post Mix',300,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(303,'61131303','Billeteras / Monederas (Vending)',300,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(304,'61131400','Reparación y Mantenimiento de Equipo de Computo',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(305,'61131401','Reparacion y Mantenimiento de Servidores y Equipo de Red',304,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(306,'61131402','Reparacion y Mantenimiento de Software',304,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(307,'61131403','Reparación y Mantenimiento de Equipo de Computo Personal',304,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(308,'61131404','Reparación y Mantenimiento de Hand Helds',304,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(309,'61131405','Reparación y Mantenimiento de Equipos de Impresión',304,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(310,'61131500','Reparacion y Manteminiento de Maquinaria y Equipo',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(311,'61131501','Servicios Técnicos',310,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(312,'61131502','Repuestos',310,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(313,'61131503','Consumibles y/o Genericos',310,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(314,'61131600','Reparacion y Manteminiento de Vehiculos',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(315,'61131601','Camiones',314,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(316,'61131602','Motos',314,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(317,'61131603','Pick Ups / Paneles',314,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(318,'61131604','Automoviles',314,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(319,'61131605','Montacargas',314,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(320,'61131800','Seguros',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(321,'61131801','Instalaciones / Todo Riesgo',320,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(322,'61131802','Vehiculos',320,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(323,'61131803','Responsabilidad Civil',320,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(324,'61131804','Fianzas / Otros',320,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(325,'61131805','Directors & Officers',320,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(326,'61131900','Alquileres',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(327,'61131901','Inmuebles - Agencias / Bodegas',326,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(328,'61131902','Inmuebles - MiniBodegas / Locales',326,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(329,'61131903','Vehiculos',326,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(330,'61131904','Maquinaria y Equipo',326,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(331,'61132000','Lavado y Sanitizado de Envase',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(332,'61132001','Lavado y Sanitizado de Envase',331,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(333,'61132100','Rotura de Envase y Cajilla',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(334,'61132101','Rotura de Envase y Cajilla',333,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(335,'61132200','Producto Fuera de Norma',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(336,'61132201','Producto Fuera de Norma - Manufactura',335,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(337,'61132202','Producto Fuera de Norma - Agencias / Bodegas',335,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(338,'61132203','Producto Fuera de Norma - Mercado',335,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(339,'61132300','Fletes Fijos',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(340,'61132301','Fletes Fijos',339,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(341,'61132400','Impuestos y Contribuciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(342,'61132401','Territoriales',341,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(343,'61132402','Circulacion',341,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(344,'61132403','Tasas y/o Arbitrios Municipales',341,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(345,'61132404','Multas y/o Otros Recargos',341,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(346,'61132405','Otros Impuestos',341,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(347,'61132500','Llantas, Tubos y Accesorios',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(348,'61132501','Camiones',347,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(349,'61132502','Motos',347,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(350,'61132503','Pick Ups / Paneles',347,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(351,'61132504','Automoviles',347,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(352,'61132505','Montacargas',347,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(353,'61132600','Combustibles y Lubricantes',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(354,'61132601','Bunker',353,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(355,'61132602','Gasolina Regular',353,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(356,'61132603','Diesel',353,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(357,'61132604','Gas Propano',353,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(358,'61132605','Aceites, Lubricantes y Adhitivos',353,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(359,'61132700','Gastos de Aeronave',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(360,'61132701','Fijo',359,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(361,'61132702','Variable',359,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(362,'61132800','Materiales de Operación',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(363,'61132801','Tarimas de Madera',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(364,'61132802','Soda Caustica',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(365,'61132803','Lubricantes de Produccion',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(366,'61132804','Equipo de Laboratorio',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(367,'61132805','Material de Reempaque',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(368,'61132806','Otros Materiales de Operación',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(369,'61132807','Consumo de Agua',362,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(370,'61132900','Diferencia de Inventarios',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(371,'61132901','Diferencia de Inventarios',370,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(372,'61132902','Diferencia en Inventarios Envase',370,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(373,'61132903','Diferencia en Inventarios Cajilla',370,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(374,'61132904','Diferencia en Inventarios Otros',370,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(375,'61133000','Robos y Asaltos',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(376,'61133001','Robos y Asaltos',375,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(377,'61133100','Cuentas Incobrables',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(378,'61133101','Cuentas Incobrables',377,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(379,'61133200','Reconciliacion de la Renta',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(380,'61133201','Reconciliacion de la Renta',379,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(381,'61133202','Corporation Tax',379,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(382,'61133800','Baterias y Accesorios',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(383,'61133801','Camiones',382,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(384,'61133802','Motos',382,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(385,'61133803','Pick Ups / Paneles',382,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(386,'61133804','Automoviles',382,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(387,'61133805','Montacargas',382,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(388,'61140100','Servicio de Personas Ajenas',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(389,'61140101','Servicios Ejecutivos',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(390,'61140102','Servicios Bancarios',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(391,'61140103','Servicios Directos Linea de Produccion',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(392,'61140104','Impulsadores',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(393,'61140105','Servicios Medicos / Enfermeria',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(394,'61140106','Servicios de Mensajeria',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(395,'61140107','Servicios Tramites Aduanales',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(396,'61140108','Servicios de Conserjeria',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(397,'61140109','Servicios de Extraccion de Desechos',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(398,'61140110','Servicios Personal Logistico',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(399,'61140111','Cargos Servicios Compartidos',388,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(400,'61140200','Servicio de Seguridad y Vigilancia',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(401,'61140201','Seguridad y Vigilancia Instalaciones',400,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(402,'61140202','Seguridad y Vigilancia Movil',400,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(403,'61140203','Transporte Logistico y Custodia de Valores',400,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(404,'61140204','Servicios de Investigacion',400,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(405,'61140400','Honorarios / Consultoria Profesional',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(406,'61140401','Legales',405,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(407,'61140402','Consultoria Administrativa',405,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(408,'61140403','Consultoria Comercializacion',405,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(409,'61140404','Auditorias Externas',405,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(410,'61140405','Gastos Judiciales',405,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(411,'61150100','Donaciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(412,'61150101','Donaciones',411,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(413,'61150200','Gastos de Representacion y Relaciones Publicas',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(414,'61150201','Gastos de Representacion y Relaciones Publicas',413,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(415,'61150300','Materiales de Limpieza',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(416,'61150301','Materiales de Limpieza',415,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(417,'61150400','Gastos de Fotoimpresion',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(418,'61150401','Costo de Fotoimpresion',417,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(419,'61150402','Papel de Impresión',417,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(420,'61150403','Cintas, Toner o Cartucho para Fotoimpresion',417,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(421,'61150500','Dietas',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(422,'61150501','Dietas',421,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(423,'61150600','Tele-Comunicaciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(424,'61150601','Telefonia Fija',423,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(425,'61150602','Telefonia Movil',423,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(426,'61150603','Reparación y Mantenimiento de Plantas Telefonicas y Telefonos',423,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(427,'61150604','Enlaces de Datos',423,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(428,'61150605','Frecuncias de Radio',423,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(429,'61150800','Papeleria y Utiles',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(430,'61150801','Formatos y Formularios Preimpresos',429,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(431,'61150802','Papeleria y Utiles de Oficina',429,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(432,'61150900','Energia Electrica',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(433,'61150901','Energia Electrica',432,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(434,'61151000','Cuotas y Suscripciones',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(435,'61151001','Contribuciones y/o Cuotas',434,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(436,'61151002','Suscripciones',434,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(437,'61151100','Activos No Capitalizables',NULL,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(438,'61151101','Activos No Capitalizables',437,'M,A')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(439,'61160601','Publicidad del Exterior',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(440,'61161201','Eventos Especiales Pull',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(441,'61161301','Eventos Musicales Pull',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(442,'61161501','Degustaciones',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(443,'61161601','Gastos de Introduccion de Productos ',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(444,'61161701','PROMOCIONES MASIVAS',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(445,'61161801','Articulos Promocionales',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(446,'61162001','Radio',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(447,'61162201','PRENSA',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(448,'61162301','Internet',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(449,'61162401','Cable',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(450,'61162501','Cine',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(451,'61162601','Produccion de Medios',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(452,'61163001','Material POP Liviano',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(453,'61163101','Investigación de Mercado Pull',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(454,'61163401','Material POP Permanente',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(455,'61163901','Promociones Tacticas al Consumidor Final',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(456,'61173101','Investigación de mercado Push',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(457,'61173201','Bonos e incentivos a la fuerza de ventas',NULL,'C')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(458,'71111000','CITIBANK',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(459,'71111700','BANCO AGRICOLA',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(460,'71112000','BANCO AMERICA CENTRAL',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(461,'71310100','COMISIONES DE INSTITUCIONES BANCARIAS Y FINANCIERA',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(462,'71310200','OTROS GASTOS FINANCIEROS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(463,'72111000','CITIBANK',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(464,'72111700','BANCO AGRICOLA',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(465,'72112000','BANCO AMERICA CENTRAL',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(466,'72310100','OTROS PRODUCTOS FINANCIEROS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(467,'81110100','OTROS GASTOS NO OPERATIVOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(468,'81110200','INTERESES MINORITARIOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(469,'81110300','ISR DIFERIDO',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(470,'81110400','PERDIDA EN VENTA DE ACTIVOS FIJOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(471,'81110500','PERDIDA EN BAJA DE ACTIVOS FIJOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(472,'81110600','PERDIDA DE CAPITAL',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(473,'81110800','ISR DEFINITIVO',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(474,'81120100','OTROS PRODUCTOS  NO OPERATIVOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(475,'81120200','INTERESES MINORITARIOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(476,'81120400','GANANCIA EN VENTA DE ACTIVOS FIJOS',NULL,'F')
INSERT Accounts(Id,Code,Name,ParentId,Type) VALUES(477,'81140100','OTROS PRODUCTOS OPERATIVOS',NULL,'F')
GO
SET IDENTITY_INSERT Accounts OFF
GO
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,1)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,2)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,3)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,4)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,5)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,6)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,7)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,8)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,9)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,10)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,11)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,12)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,13)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,14)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,15)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,16)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,17)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,17)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,18)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,19)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,20)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,21)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,22)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,23)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,24)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,25)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,26)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,27)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,28)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,29)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,30)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,31)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,32)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,33)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,34)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,35)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,36)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,37)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,38)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,39)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,40)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,41)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,42)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,43)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,44)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,45)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,46)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,47)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,48)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,49)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,50)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,51)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,52)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,53)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,54)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,55)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,56)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,57)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,58)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,59)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,60)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,61)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,62)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,63)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,64)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,65)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,66)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,67)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,68)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,69)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,70)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,71)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,72)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,73)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,74)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,75)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,76)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,77)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,78)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,79)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,80)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,81)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,82)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,83)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,84)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,85)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,86)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,87)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,88)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,89)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,90)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,91)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,92)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,93)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,94)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,95)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,96)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,97)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,98)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,99)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,100)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,101)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,102)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,103)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,104)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,105)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,106)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,107)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,108)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,109)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,110)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,111)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,112)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,113)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,114)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,115)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,116)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,117)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,118)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,119)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(9,120)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(9,121)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,122)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,123)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,124)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,125)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,126)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,127)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,128)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,129)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,130)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,131)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,132)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,133)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,134)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,135)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,136)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,137)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,138)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,139)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,140)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,141)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,142)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,143)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,144)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,145)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,146)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,147)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,148)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,149)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,150)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,151)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,152)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,153)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,154)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,155)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,156)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,157)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,158)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,159)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,160)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,161)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,162)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,163)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,164)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,165)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,166)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,167)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,168)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,169)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,169)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,170)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,171)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,172)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,173)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,174)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,175)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,176)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,177)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,178)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,179)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,180)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,181)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,182)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,183)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,184)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,185)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,186)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,187)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,188)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,189)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,190)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,191)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,192)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,193)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,194)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,195)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,196)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,197)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,198)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,199)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,200)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,201)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,202)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,203)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,204)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,205)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,206)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,207)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,208)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,209)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,210)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,211)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,212)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,213)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,214)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,215)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,216)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,217)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,218)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,219)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,220)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,221)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,222)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,223)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,224)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,225)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,226)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,227)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,228)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,229)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,230)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,231)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,232)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,233)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,234)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,235)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,236)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,236)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,237)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,238)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,239)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,240)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,241)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,242)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,243)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,244)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,245)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,246)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,247)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,248)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,249)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,250)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,251)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,252)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,253)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,254)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,255)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,256)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,257)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(2,258)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,259)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,260)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,261)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,262)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,263)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,264)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,265)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,266)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,267)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,268)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,269)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,270)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,271)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,272)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,273)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,274)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,275)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,276)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,277)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,278)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,279)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,280)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,281)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,282)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,283)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,284)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,285)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,286)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,287)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,288)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,289)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,290)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,291)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,292)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,293)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,294)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(3,295)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,296)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,297)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,298)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,299)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,300)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,301)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,302)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,303)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,304)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,305)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,306)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,307)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,308)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,309)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,310)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,311)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,312)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,313)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,314)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,315)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,316)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,317)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,318)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,319)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,320)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,321)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,322)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,323)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,324)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,325)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,326)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,327)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,328)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,329)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(7,330)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,331)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,332)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,333)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,334)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,335)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,336)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,337)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,338)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(9,339)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(9,340)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,341)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,342)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,343)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,344)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,345)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,346)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,347)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,348)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,349)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,350)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,351)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,352)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,353)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,354)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,355)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,356)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,357)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,358)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,359)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,360)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(4,361)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,362)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,363)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,364)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,365)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,366)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,367)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,368)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,369)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,370)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,371)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,372)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,373)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,374)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,375)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,376)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,377)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(8,378)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,379)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,380)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(15,381)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,382)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,383)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,384)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,385)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,386)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(6,387)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,388)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,388)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,389)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,390)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,391)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,392)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,393)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,394)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,395)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,396)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,397)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,398)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,399)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,400)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,401)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,402)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,403)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,404)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,405)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,406)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,407)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,408)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,409)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(5,410)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,411)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,412)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,413)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,414)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,415)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,416)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,417)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,418)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,419)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(11,420)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,421)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(1,422)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,423)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,424)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,425)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,426)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,427)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(12,428)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,429)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,430)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(13,431)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,432)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(10,433)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,434)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,435)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,436)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,437)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(14,438)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,439)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,440)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,441)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,442)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,443)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,444)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,445)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,446)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,447)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,448)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,449)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,450)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,451)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,452)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,453)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,454)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,455)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,456)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(17,457)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,458)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,459)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,460)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,461)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,462)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,463)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,464)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,465)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(18,466)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,467)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,468)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,469)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,470)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,471)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,472)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,473)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,474)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,475)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,476)
INSERT PackageAccounts(Package_Id,Account_Id) VALUES(16,477)
GO

INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('FBB29B76-7715-4579-837E-894AF2DB2D53','Moises Abrego','mabrego@liv-smart.com',1,'mabrego',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('3C443C9A-A562-4073-9CEA-5F23CF289156','Roberto Herbert Portillo Aparicio','rhportillo@liv-smart.com',1,'rportillo',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('6F9CA625-6F6D-4F4E-AB97-90DD3AEA1646','Sergio Mejia','smejia@liv-smart.com',1,'smejia',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('E536409E-64F0-4458-A5F8-3069AC683A53','Dalia Villalobos','dvillalobos@liv-smart.com',1,'dvillalobos',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('9F980C18-F3B0-43B8-8F61-32EDB72AD66A','Diego Sales','dsales@liv-smart.com',1,'dsales',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('9A000C18-F3C0-43B8-8F61-0ADA72AD66B1','Jovani Funes','jfunes@liv-smart.com',1,'jfunes',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('7C62875E-F607-4BCA-AC87-71496FB39D22','Melissa Parada','mparada@liv-smart.com',1,'mparada',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('190F3956-FC9E-46B9-8FAF-A3C9AA33FEC2','Guillermo Peña','gapeña@liv-smart.com',1,'gpeña',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('15601288-057A-455D-9846-FC2716A96872','Delfina Solorzano','dsolorzano@liv-smart.com',1,'dsolorzano',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('A14C3EA3-6E63-42AB-A847-B92092720942','Gabriela Tovar','gtovar@liv-smart.com',1,'gtovar',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('C30325CA-A3F3-440C-B0BA-DC6B485D890C','Mario Guerra','mguerra@liv-smart.com',1,'mguerra',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('DB6CAE3F-6277-4F80-AFBB-D787B9956C49','Mauricio Galvez','mrgalvez@liv-smart.com',1,'mgalvez',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('9A96C685-2150-4899-B155-629D5E02985F','Sofia Olivo','sofiao@liv-smart.com',1,'solivo',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('B2DB0FBB-DC8B-4770-BAEB-514471CAD5CA','Brenda Julissa','balvanez@liv-smart.com',1,'balvanez',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('7978468A-84B0-411C-8BA2-C95D6CDF504B','Ana Katalina Linares','alinares@liv-smart.com',1,'alinares',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('4FA9F733-A097-4094-AA33-F29B99AA4706','Luis Pedro Valladares','lvalladares@liv-smart.com',1,'lvalladares',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('453B6A84-5A4C-4515-A862-F0CB93F0C7CE','Erick Espinoza','eespinoza@liv-smart.com',1,'eespinoza',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('FA4F60FD-487D-494E-ACA8-39E578700E87','Melvin Menbreño','mmenbreno@liv-smart.com',1,'mmenbreño',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('91F080AD-ED1F-44A6-96B7-5550F2D23BE2','Monica Palma','mpalma@liv-smart.com',1,'mpalma',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('B8B49AE6-B737-4228-AF8E-42F905981FEF','Carlos Mauricio Medina','cmmedina@liv-smart.com',1,'cmedina',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('F7A5BAED-952E-419E-AAB9-5F8E6C3E3938','Jennifer Lisseth Torres','jtorres@liv-smart.com',1,'jtorres',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('C2BFB80A-D895-46F7-B3F1-5848331DF2F3','Omar Arturo Pineda','oapineda@liv-smart.com',1,'opineda',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('DBFBA997-3BCA-491F-A16A-6157917C91B3','Atilio Moran','amoran@liv-smart.com',1,'amoran',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('24DC4AF0-EBCC-42BC-B800-427B42095972','Gabriela Murcia','gmmurcia@liv-smart.com',1,'gmurcia',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('1B861ED8-8B29-4003-8B17-1702B355C468','Helios Muñoz','heliosm@liv-smart.com',1,'hmunoz',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('AB9F1F43-D661-4E31-9B22-EABA10FF7BC0','Lissette Guzman','lguzman@liv-smart.com',1,'lguzman',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('7B865FF7-E4CC-4DA5-A2C7-9C500E118529','Elmer Molina','emolina@liv-smart.com',1,'emolina',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('094D704C-8BD2-4CEF-94B9-2E83300E7C72','David Lee','dlee@liv-smart.com',1,'dlee',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('262FE84F-0805-49CE-ADC7-1302CA46FF4C','Ricardo Kiehnle','rkiehnle@liv-smart.com',1,'rkiehnle',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('5923FF8E-B38B-4C14-948D-A6AF8DE8F713','Rocio Velasco','rvelasco@liv-smart.com',1,'rvelasco',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('863C267D-2EA0-4680-8EBA-F6A9C9D181E0','Marvell Sumala','msumala@liv-smart.com',1,'msumala',0,0,0,0,0)
INSERT AspNetUsers(Id,Name,Email,Status,UserName,EmailConfirmed,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEnabled,AccessFailedCount) VALUES('863C267D-2EA0-4680-8EBA-F6A9C9D181E1','Gustavo Rauda','gustavo.rauda@grupobabel.com',1,'grauda',0,0,0,0,0)
GO

DELETE CostCenters
GO

SET IDENTITY_INSERT CostCenters ON
GO
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(1,'SV03010101','LINEA 1 PET (PP.1)',1,NULL,'P','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(2,'SV03020101','LINEA 1 PET (PP.1)',1,NULL,'M','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(3,'SV03010102','LINEA 2 PET (PP.1)',1,NULL,'P','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(4,'SV03020102','LINEA 2 PET (PP.1)',1,NULL,'M','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(5,'SV03010103','LINEA 3 LATA 12 ONZ',1,NULL,'P','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(6,'SV03020103','LINEA 3 LATA 12 ONZ',1,NULL,'M','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(7,'SV03010104','LINEA 4 200 ML (PP.1',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(8,'SV03020104','LINEA 4 200 ML (PP.1',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(9,'SV03010105','LINEA 5 200 ML (MID 3)',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(10,'SV03020105','LINEA 5 200 ML (MID 3)',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(11,'SV03010106','LINEA 6 200 ML (MID 4)',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(12,'SV03020106','LINEA 6 200 ML (MID 4)',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(13,'SV03010107','LINEA 7 SLIM (PP.1)',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(14,'SV03020107','LINEA 7 SLIM (PP.1)',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(15,'SV03010108','LINEA 8 A3FLEX',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(16,'SV03020108','LINEA 8 A3FLEX',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(17,'SV03010109','LINEA 9 PRISMA (PP.1',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(18,'SV03020109','LINEA 9 PRISMA (PP.1',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(19,'SV03010110','MULTIEMPAQUE',1,NULL,'P','6F9CA625-6F6D-4F4E-AB97-90DD3AEA1646')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(20,'SV03020110','MULTIEMPAQUE',1,NULL,'M','6F9CA625-6F6D-4F4E-AB97-90DD3AEA1646')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(21,'SV03010111','LINEA 11 FRUTSI (PLASTICO)',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(22,'SV03020111','LINEA 11 FRUTSI (PLASTICO)',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(23,'SV03010112','LINEA 12 Dream CAP',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(24,'SV03020112','LINEA 12 Dream CAP',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(25,'SV03010113','LINEA A3SPEED',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(26,'SV03020113','LINEA A3SPEED',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(27,'SV03010115','LINEA COMPAC',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(28,'SV03020115','LINEA COMPAC',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(29,'SV03010152','JARABES (PP.1)',1,NULL,'P','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(30,'SV03020152','JARABES (PP.1)',1,NULL,'M','FBB29B76-7715-4579-837E-894AF2DB2D53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(31,'SV03010153','DESARROLLO DE PRODUCTOS ',1,NULL,'P','E536409E-64F0-4458-A5F8-3069AC683A53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(32,'SV03020153','DESARROLLO DE PRODUCTOS ',1,NULL,'M','E536409E-64F0-4458-A5F8-3069AC683A53')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(33,'SV03010157','CUARTO DE MAQUINAS (Facilidades)',1,NULL,'P','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(34,'SV03010160','MATERIAS PRIMAS (Almacen)',1,NULL,'P','7C62875E-F607-4BCA-AC87-71496FB39D22')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(35,'SV03020160','MATERIAS PRIMAS (Almacen)',1,NULL,'M','7C62875E-F607-4BCA-AC87-71496FB39D22')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(36,'SV03011101','LINEA 1 - SOPLADO',1,NULL,'P','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(37,'SV03021101','LINEA 1 - SOPLADO',1,NULL,'M','3C443C9A-A562-4073-9CEA-5F23CF289156')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(38,'SV03010161','CENTRO DE DISTRIBUCION',1,NULL,'P','190F3956-FC9E-46B9-8FAF-A3C9AA33FEC2')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(39,'SV03020161','CENTRO DE DISTRIBUCION',1,NULL,'M','190F3956-FC9E-46B9-8FAF-A3C9AA33FEC2')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(40,'SV03020159','GASTOS DE IMPORTACION',1,NULL,'M','15601288-057A-455D-9846-FC2716A96872')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(43,'SV03023103','EXPORTACIONES',1,NULL,'M','A14C3EA3-6E63-42AB-A847-B92092720942')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(44,'SV03030101','GENTE Y GESTION',1,NULL,'A','C30325CA-A3F3-440C-B0BA-DC6B485D890C')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(45,'SV03030104','GENTE Y GESTION',1,NULL,'A','C30325CA-A3F3-440C-B0BA-DC6B485D890C')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(46,'SV03040304','BIENESTAR EMPRESARIAL (Vigilancia)',1,NULL,'A','DB6CAE3F-6277-4F80-AFBB-D787B9956C49')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(47,'SV03060103','TESORERIA',1,NULL,'A','9A96C685-2150-4899-B155-629D5E02985F')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(48,'SV03060104','SISTEMAS',1,NULL,'A','B2DB0FBB-DC8B-4770-BAEB-514471CAD5CA')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(49,'SV03060105','AUDITORIA',1,NULL,'A','7978468A-84B0-411C-8BA2-C95D6CDF504B')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(50,'SV03060106','JURIDICO - LEGALES',1,NULL,'A','4FA9F733-A097-4094-AA33-F29B99AA4706')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(51,'SV03010154','GERENCIA DE PRODUCCION',1,NULL,'P','6F9CA625-6F6D-4F4E-AB97-90DD3AEA1646')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(52,'SV0301015401','GERENCIA DE PRODUCCION',1,NULL,'P','6F9CA625-6F6D-4F4E-AB97-90DD3AEA1646')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(53,'SV0302015401','GERENCIA DE PRODUCCION',1,NULL,'M','6F9CA625-6F6D-4F4E-AB97-90DD3AEA1646')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(54,'SV0301015402','SISTEMAS DE GESTION',1,NULL,'P','453B6A84-5A4C-4515-A862-F0CB93F0C7CE')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(55,'SV0302015402','SISTEMAS DE GESTION',1,NULL,'M','453B6A84-5A4C-4515-A862-F0CB93F0C7CE')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(56,'SV0301015403','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE',1,NULL,'P','FA4F60FD-487D-494E-ACA8-39E578700E87')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(57,'SV0302015403','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE',1,NULL,'M','FA4F60FD-487D-494E-ACA8-39E578700E87')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(58,'SV03010155','CONTROL DE CALIDAD',1,NULL,'P','91F080AD-ED1F-44A6-96B7-5550F2D23BE2')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(59,'SV0301015501','ASEGURAMIENTO  DE CALIDAD LINEAS',1,NULL,'P','B8B49AE6-B737-4228-AF8E-42F905981FEF')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(60,'SV0302015501','ASEGURAMIENTO  DE CALIDAD LINEAS',1,NULL,'M','B8B49AE6-B737-4228-AF8E-42F905981FEF')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(61,'SV0301015502','ASEGURAMIENTO  DE CALIDAD MATERIALES',1,NULL,'P','F7A5BAED-952E-419E-AAB9-5F8E6C3E3938')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(62,'SV0302015502','ASEGURAMIENTO  DE CALIDAD MATERIALES',1,NULL,'M','F7A5BAED-952E-419E-AAB9-5F8E6C3E3938')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(63,'SV0301015503','GERENCIA DE ASEGURAMIENTO DE CALIDAD',1,NULL,'P','91F080AD-ED1F-44A6-96B7-5550F2D23BE2')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(64,'SV0302015503','GERENCIA DE ASEGURAMIENTO DE CALIDAD',1,NULL,'M','91F080AD-ED1F-44A6-96B7-5550F2D23BE2')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(65,'SV0301015504','MICROBIOLOGIA',1,NULL,'P','C2BFB80A-D895-46F7-B3F1-5848331DF2F3')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(66,'SV0302015504','MICROBIOLOGIA',1,NULL,'M','C2BFB80A-D895-46F7-B3F1-5848331DF2F3')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(67,'SV03010156','MANTENIMIENTO',1,NULL,'P','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(68,'SV0301015601','COORDINACIÓN (Comatto)',1,NULL,'P','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(69,'SV03020156','MANTENIMIENTO',1,NULL,'M','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(70,'SV0302015601','COORDINACIÓN (Comatto)',1,NULL,'M','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(71,'SV0301015602','DEPTO. MANTENIMIENTO(Dmatto)',1,NULL,'P','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(72,'SV0302015602','DEPTO. MANTENIMIENTO(Dmatto)',1,NULL,'M','9F980C18-F3B0-43B8-8F61-32EDB72AD66A')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(73,'SV0301015603','DPTO PROYECTOS',1,NULL,'P','DBFBA997-3BCA-491F-A16A-6157917C91B3')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(74,'SV0302015603','DPTO PROYECTOS',1,NULL,'M','DBFBA997-3BCA-491F-A16A-6157917C91B3')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(75,'SV0301015604','ALMACEN DE REPUESTOS',1,NULL,'P','24DC4AF0-EBCC-42BC-B800-427B42095972')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(76,'SV0302015604','ALMACEN DE REPUESTOS',1,NULL,'M','24DC4AF0-EBCC-42BC-B800-427B42095972')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(77,'SV03060102','FINANZAS',1,NULL,'A','1B861ED8-8B29-4003-8B17-1702B355C468')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(78,'SV0306010201','FINANZAS - CONTABILIDAD',1,NULL,'A','AB9F1F43-D661-4E31-9B22-EABA10FF7BC0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(79,'SV0306010202','FINANZAS - PRESUPUESTOS',1,NULL,'A','7B865FF7-E4CC-4DA5-A2C7-9C500E118529')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(80,'SV0306010203','FINANZAS - GERENCIA FINANCIERA',1,NULL,'A','1B861ED8-8B29-4003-8B17-1702B355C468')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(81,'SV03060101','GERENCIA',1,NULL,'A','094D704C-8BD2-4CEF-94B9-2E83300E7C72')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(82,'SV0306010101','ADMON LIVSMART GT',2,NULL,'A','094D704C-8BD2-4CEF-94B9-2E83300E7C72')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(83,'SV0306010102','LIVSMART Centro America CBC',4,NULL,'A','262FE84F-0805-49CE-ADC7-1302CA46FF4C')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(84,'SV0306010103','LIVSMART Centro America NO CBC',5,NULL,'A','262FE84F-0805-49CE-ADC7-1302CA46FF4C')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(85,'SV0306010104','ADMON LIVSMART MEXICO',3,NULL,'A','5923FF8E-B38B-4C14-948D-A6AF8DE8F713')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(86,'SV0306010105','ADMON LIVSMART COLOMBIA',6,NULL,'A','262FE84F-0805-49CE-ADC7-1302CA46FF4C')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(87,'SV0306010106','ADMON LIVSMART ECUADOR',7,NULL,'A','262FE84F-0805-49CE-ADC7-1302CA46FF4C')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(88,'SV0306011401','COMPRAS',1,NULL,'M','15601288-057A-455D-9846-FC2716A96872')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(89,'SV0306011402','LOGISTICA ABASTECIMIENTO (Compras 2)',1,NULL,'M','15601288-057A-455D-9846-FC2716A96872')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(90,'SV03100101','GASTOS FINANCIEROS',1,NULL,'F','1B861ED8-8B29-4003-8B17-1702B355C468')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(91,'SV03070103','LIVSMART SV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(92,'SV03080108','FINANZAS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(93,'SV03100201','PRODUCTOS FINANCIER',1,NULL,'F','1B861ED8-8B29-4003-8B17-1702B355C468')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(94,'SV03050301','COMERCIALIZACION',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(95,'SV03050209','MERCADEO PETIT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(96,'SV0305020901','PETIT - USAF',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(97,'SV0305020902','PETIT - GRAN IMPORT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(98,'SV0305020903','PETIT - CIAMESA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(99,'SV0305020904','PETIT - ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(100,'SV0305020907','PETIT - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(101,'SV0305020908','PETIT - HOCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(102,'SV0305020909','PETIT - NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(103,'SV0305020910','PETIT - HOSR',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(104,'SV0305020911','PETIT - PAIT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(105,'SV0305020912','PETIT - Dom',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(106,'SV0305020913','PETIT - KASIM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(107,'SV0305020914','PETIT - MXLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(108,'SV0305020915','PETIT - PRCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(109,'SV0305020916','PETIT - COL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(110,'SV0305020918','PETIT - ECUA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(111,'SV0305020919','PETIT - ESLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(112,'SV0305020920','PETIT - GTLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(113,'SV0305020921','PETIT - CR ISLEÑA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(114,'SV0305020922','NECTARS, VEGGIES Y MEAL REPACEMENT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(115,'SV0305020923','MERCADEO PETIT - JUICE DRINKS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(116,'SV0305020924','MERCADEO PETIT - PREMIUM JUICE',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(117,'SV0305020925','MERCADEO PETIT - STILL DRINKS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(118,'SV0305020926','MERCADEO PETIT - DAIRY',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(119,'SV0305020927','MERCADEO PETIT - NEW BUSINESS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(120,'SV0305020928','PETIT MAIN LINE - USRG',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(121,'SV0305020929','APOYO MKT  TETRA PACK',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(122,'SV0305020931','petit rio grande',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(123,'SV0305020932','Petit africa',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(124,'SV0305020935','PETIT - CALIF',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(125,'SV0305021003','CALIFORNIA N - CRCI',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(126,'SV0305021004','CALIFORNIA - COMERCIALIZADORA INTERAMERI',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(127,'SV0305021006','CALIFORNIA N - ESDIZ',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(128,'SV0305021009','CALIFORNIA N - NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(129,'SV0305021011','CALIFORNIA N - PAIT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(130,'SV0305021101','campestre la nacional',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(131,'SV0305021507','ICE COOL - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(132,'SV0305021508','ICE COOL - HOCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(133,'SV0305021509','ICE COOL - NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(134,'SV0305021510','ICE COOL - GRUPO SAN RAFAEL, SA DE CV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(135,'SV0305021514','ICE COOL - MXLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(136,'SV0305021519','ICE COOL - ESLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(137,'SV0305021520','ICE COOL - GTLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(138,'SV0305022101','squiz Ecuador',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(139,'SV0305022102','squiz La reyna',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(140,'SV0305022103','squiz Mariposa',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(141,'SV0305022404','WELCH - ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(142,'SV0305022407','WELCH - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(143,'SV0305022408','WELCH - HOCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(144,'SV0305022409','WELCH - NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(145,'SV0305022412','WELCH - DOM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(146,'SV0305023804','FRUTI POP - ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(147,'SV0305024815','C-TRUST - PEPSI COLA PUERTO RICO DISTRIB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(148,'SV0305025001','JUGAZZO - ALL FOODS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(149,'SV0305025007','JUGAZZO - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(150,'SV0305025008','JUGAZZO - HOCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(151,'SV0305025009','JUGAZZO - NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(152,'SV0305025010','JUGAZZO - HOSR',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(153,'SV0305025011','Jugazzo importadora Trasmundi',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(154,'SV0305025014','JUGAZZO - NOVAMEX',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(155,'SV0305025016','JUGAZZO - COL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(156,'SV0305025017','JUGAZZO - Ecuador',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(157,'SV0305025018','JUGAZZO - Isleña',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(158,'SV0305025302','COSECHA PURA - GRAN IMPORT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(159,'SV0305025304','COSECHA PURA - ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(160,'SV0305025307','COSECHA PURA - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(161,'SV0305025311','COSECHA PURA - PAIT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(162,'SV0305025312','COSECHA PURA - DOM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(163,'SV0305025314','COSECHA PURA - MXLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(164,'SV0305025315','COSECHA PURA - PRCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(165,'SV0305025316','COSECHA PURA - COL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(166,'SV0305025321','COSECHA PURA - CR ISLEÑA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(167,'SV0305025332','COSECHA PURA - PANU',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(168,'SV0305025701','FRUTADO PR',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(169,'SV0305025704','FRUTADO - ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(170,'SV0305025707','FRUTADO - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(171,'SV0305025708','FRUTADO - HOCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(172,'SV0305025709','FRUTADO - NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(173,'SV0305025712','FRUTADO - DOM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(174,'SV0305025719','FRUTADO - ESLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(175,'SV0305025720','FRUTADO - GTLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(176,'SV0305025807','LECHE - GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(177,'SV0305025819','LECHE - ESLIV',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(178,'SV0305027305','ALOE-CRIS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(179,'SV0305027307','ALOE-GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(180,'SV0305027311','ALOE-PAIT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(181,'SV0305027313','ALOE-KASIM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(182,'SV0305027331','ALOE-TEXAS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(183,'SV0305027404','ARTESANO-ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(184,'SV0305027405','ARTESANO-CRIS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(185,'SV0305027408','ARTESANO-HOCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(186,'SV0305027432','ARTESANO-PANU',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(187,'SV0305027511','AVENA-PAIT',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(188,'SV0305027512','AVENA-DOM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(189,'SV0305027513','AVENA-KASIM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(190,'SV0305027518','AVENA-ECUA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(191,'SV0305027531','AVENA-TEXAS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(192,'SV0305027707','CONC. ICE COOL-GTCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(193,'SV0305027904','FRUTA FRESCA-ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(194,'SV0305027905','FRUTA FRESCA-CRIS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(195,'SV0305027909','FRUTA FRESCA-NICAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(196,'SV0305027912','FRUTA FRESCA-DOM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(197,'SV0305027932','FRUTA FRESCA-PANU',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(198,'SV0305028034','INTELIGENCIA DE MERCADO SITM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(199,'SV0305028112','ECONO-DOMDOM',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(200,'SV0305027604','CONC. FRUTADO-ESCAB',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(201,'SV0305025017','JUGAZZO ECUADOR',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(202,'SV0305027633','CONC. FRUTADO-ECUACOL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(203,'SV0305027833','CONC. PETIT-ECUACOL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(204,'SV0305028801','AVENA RIO GRANDE',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(205,'SV0305028802','AVENA ALL FOODS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(206,'SV0305028803','AVENA MARES',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(207,'SV0305028804','AVENA MARIPOSA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(208,'SV0305028805','AVENA LA REYNA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(209,'SV0305028806','AVENA PUERTO RICO',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(210,'SV0305028807','AVENA ISLEÑA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(211,'SV0305028901','ALOE ALL FOODS',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(212,'SV0305028902','ALOE PUERTO RICO',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(213,'SV0305028903','ALOE IMPADOEL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(214,'SV0305029001','ARTESANO CIAMESA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(215,'SV0305029002','ARTESANO LA NACIONAL',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(216,'SV0305029101','FRUTA FRESCA CIAMESA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(217,'SV0305029102','FRUTA FRESCA MARIPOSA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(218,'SV0305029103','FRUTA FRESCA LA REYNA',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
INSERT CostCenters(Id,Code,Name,CompanyId,ParentId,Type,ResponsibleGUID) VALUES(219,'SV0305029104','FRUTA FRESCA ECUADOR',1,NULL,'C','863C267D-2EA0-4680-8EBA-F6A9C9D181E0')
GO
SET IDENTITY_INSERT CostCenters OFF
GO

SET IDENTITY_INSERT Positions ON
GO
INSERT Positions(Id,Name,CompanyId) VALUES(1,'FORMULADOR Y PASTEURIZADOR',1)
INSERT Positions(Id,Name,CompanyId) VALUES(2,'OPERADOR DE DEPALETIZADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(3,'OPERADOR DE EMPACADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(4,'OPERADOR DE ETIQUETADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(5,'OPERADOR DE LLENADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(6,'OPERADOR DE PALETIZADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(7,'OPERADOR FORMULACION JARABE',1)
INSERT Positions(Id,Name,CompanyId) VALUES(8,'OPERADOR MULTIFUNCIONAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(9,'SUPERVISOR DE PRODUCCION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(10,'OPERADOR DE CAPSULADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(11,'AUXILIAR DE FORMULACION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(12,'OPERADOR DE SELLADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(13,'OPERADOR DE ESTIBADO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(14,'OPERADOR DE TERMO EMPAJILLADOR',1)
INSERT Positions(Id,Name,CompanyId) VALUES(15,'OPERADOR DE TERMOEMPAJILLADOR',1)
INSERT Positions(Id,Name,CompanyId) VALUES(16,'OPERADOR DE ENCHAROLADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(17,'OPERADOR DE ORDENADORA DE ENVASES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(18,'OPERADOR TERMO EMPAJILLADOR Y CAPSULADOR',1)
INSERT Positions(Id,Name,CompanyId) VALUES(19,'ENCARGADO DE LIQUIDACION JARABE',1)
INSERT Positions(Id,Name,CompanyId) VALUES(20,'COORDINADOR INVESTIGACION Y DESARROLLO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(21,'ANALISTA DE SECCA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(22,'COORDINADOR TECNICO INDUSTRIAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(23,'INSPECTOR TECNICO LEGAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(24,'JEFE DE INVESTIGACION Y DESARROLLO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(25,'COORDINADOR DE INVESTIGACION Y DESARROLLO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(26,'ANALISTA TECNICO LEGAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(27,'COORDINADOR DE INFORMACION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(28,'COORDINADOR DE MEJORAS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(29,'COORDINADOR DE PLANIFICACION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(30,'GERENTE DE PRODUCCION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(31,'JEFE DE PLANIFICACION Y SUMINISTROS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(32,'JEFE DE PRODUCCION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(33,'GERENTE DE PLANTA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(34,'COORDINADOR DE SISTEMAS DE GESTION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(35,'COORDINADOR DE SEGURIDAD INDUSTRIAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(36,'TECNICO DE SEGURIDAD DE INDUSTRIAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(37,'ANALISTA AUDITOR  ASEGURAMIENTO  CALIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(38,'ANALISTA DE INOCUIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(39,'COORDINADOR DE CALIDAD DE ALMACENES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(40,'COORDINADOR DE INOCUIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(41,'INSPECTOR DE ALMACENES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(42,'JEFE ASEGURAMIENTO Y CONTROL CALIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(43,'ANALISTA DE CALIDAD DE MATERIALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(44,'COORDINADOR DE CALIDAD DE MATERIALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(45,'INSPECTOR DE CALIDAD DE MATERIALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(46,'GERENTE DE ASEGURAMIENTO DE CALIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(47,'ANALISTA DE MICROBIOLOGIA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(48,'INSPECTOR DE MICROBIOLOGIA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(49,'AUXILIAR DE SERVICIOS GENERALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(50,'COORDINADOR ASEGURAMIENTO DE CALIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(51,'COORDINADOR DE MICROBIOLOGIA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(52,'JARDINERO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(53,'COORDINADOR DE ENERGETICOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(54,'PLANIFICADOR DE MANTENIMIENTO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(55,'TECNICO ELECTROMECANICO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(56,'TECNICO ESPECIALISTA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(57,'TECNICO LIDER',1)
INSERT Positions(Id,Name,CompanyId) VALUES(58,'JEFE DE MANTENIMIENTO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(59,'OPERADOR DE FACILIDADES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(60,'COORDINADOR DE INFRAESTRUCTURA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(61,'COORDINADOR DE PROYECTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(62,'JEFE DE PROYECTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(63,'AUXILIAR DE ALMACEN DE REPUESTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(64,'COORDINADOR DE ALMACEN DE REPUESTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(65,'ENCARGADO DE INVENTARIO CICLICO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(66,'ENCARGADO DE LIQUIDACION',1)
INSERT Positions(Id,Name,CompanyId) VALUES(67,'JEFE DE ALMACEN DE MATERIALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(68,'OPERADOR DE MATERIA PRIMA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(69,'OPERADOR DE MATERIAL DE EMPAQUE',1)
INSERT Positions(Id,Name,CompanyId) VALUES(70,'OPERADOR DE RECEPCION DE MATERIALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(71,'SUPERVISOR DE MATERIA PRIMA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(72,'CONTROLADOR DE INVENTARIOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(73,'CONTROLADOR DE MUELLE',1)
INSERT Positions(Id,Name,CompanyId) VALUES(74,'CONTROLADOR DE PICKING',1)
INSERT Positions(Id,Name,CompanyId) VALUES(75,'JEFE DE LOGISTICA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(76,'OPERADOR DE DESPACHOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(77,'OPERADOR DE PRODUCTO TERMINADO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(78,'SUPERVISOR DE LOGISTICA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(79,'OPERADOR DE SOPLADORA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(80,'COORD. COMPRAS DE MATERIAS PRIMAS E IMP.',1)
INSERT Positions(Id,Name,CompanyId) VALUES(81,'COORDINADOR COMPRAS  MATERIAL  EMPAQUES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(82,'COORDINADOR DE COMPRAS Y SERVICIOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(83,'COORDINADOR DE INMPORTACIONES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(84,'COTIZADOR DE IMPORTACIONES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(85,'JEFE DE COMPRAS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(86,'GERENTE DE COMPRAS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(87,'COORDINADOR DE TRAFICO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(88,'EJECUTIVO DE FACTURACION Y EXPORTACIONES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(89,'JEFE DE FACTURACION Y EXPORTACIONES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(90,'ANALISTA DE NOMINAS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(91,'COORDINADOR DE GENTE',1)
INSERT Positions(Id,Name,CompanyId) VALUES(92,'COORDINADOR DE GESTIÓN',1)
INSERT Positions(Id,Name,CompanyId) VALUES(93,'ENFERMERA CLINICA EMPRESARIAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(94,'JEFE RECURSOS HUMANOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(95,'MEDICO CLINICA EMPRESARIAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(96,'MENSAJERO / MOTORISTA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(97,'RECEPCIONISTA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(98,'JEFE DE SEGURIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(99,'ANALISTA DE IMPUESTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(100,'ANALISTA FINANCIERO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(101,'AUXILIAR CONTABLE',1)
INSERT Positions(Id,Name,CompanyId) VALUES(102,'ENCARGADO DE ARCHIVO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(103,'JEFE DE CONTABILIDAD',1)
INSERT Positions(Id,Name,CompanyId) VALUES(104,'ANALISTA DE PRESUPUESTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(105,'CONTADOR DE COSTOS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(106,'JEFE PRESUPUESTOS Y ANALISIS FINANCIEROS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(107,'GERENTE FINANCIERO LOCAL',1)
INSERT Positions(Id,Name,CompanyId) VALUES(108,'ANALISTA FINANCIERO CONTA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(109,'JEFE DE TESORERIA/CONTROLER',1)
INSERT Positions(Id,Name,CompanyId) VALUES(110,'COORDINADOR DE INFORMACION DE INFRAESTTRUCTURA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(111,'ANALISTA SOPORTE TECNICO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(112,'COORDINADOR DE SISTEMAS',1)
INSERT Positions(Id,Name,CompanyId) VALUES(113,'COORDINADOR DE AUDITORIA INTERNA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(114,'JEFE DE AUDITORIA INTERNA',1)
INSERT Positions(Id,Name,CompanyId) VALUES(115,'COORDINADOR DE INVESTIGACION Y DESARROLLO MAQUILA (10)',1)
INSERT Positions(Id,Name,CompanyId) VALUES(116,'TECNICO DE PLANIFICACION (6)',1)
INSERT Positions(Id,Name,CompanyId) VALUES(117,'COORDINADOR DE ASEGURAMIENTO DE CALIDAD MAQUILA (10)',1)
INSERT Positions(Id,Name,CompanyId) VALUES(118,'ANALISTA DE CALIDAD DE ALMACENES (8)',1)
INSERT Positions(Id,Name,CompanyId) VALUES(119,'COORDINADOR DE MAQUILA (Costos)',1)
INSERT Positions(Id,Name,CompanyId) VALUES(120,'COORDINADOR DE COSTOS LOCALES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(121,'ASISTENTE ADMINISTRATIVO',1)
INSERT Positions(Id,Name,CompanyId) VALUES(122,'COORDINADOR DE IMPORTACIONES',1)
INSERT Positions(Id,Name,CompanyId) VALUES(123,'SUPERVISOR DE ABASTECIMIENTO',1)
GO
SET IDENTITY_INSERT Positions OFF
GO

SET IDENTITY_INSERT Employees ON
GO
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000450,1000450,'NELSON RAFAEL MARTINEZ ORTIZ',1,1,400,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000511,1000511,'JIMI OSWALDO TORRES NOLASCO',1,1,406,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000209,1000209,'MAURICIO FLORES ARDON',2,1,329.875,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000438,1000438,'FERNANDO ALBERTO HERRERA HERNANDEZ',2,1,329.875,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000439,1000439,'JOSE ANTONIO CARIAS NERIO',3,1,355.25,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000365,1000365,'JUAN CARLOS PLEITEZ HERNANDEZ',4,1,390,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000505,1000505,'ORLANDO ERNESTO ORANTES PADILLA',4,1,400.925,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000105,1000105,'JORGE ALBERTO ROSALES GUARDADO',4,1,400.925,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000435,1000435,'ALVIN ALFREDO TRAMPA CASTILLO',5,1,425,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000406,1000406,'ALEXANDER DANIEL RAMIREZ MARTINEZ',5,1,406.25,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000131,1000131,'SALVADOR ALEXANDER SANCHEZ CASTILLO',6,1,392.7035,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000134,1000134,'ABEL DE JESUS MANCIA GONZALEZ',6,1,329.875,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000544,1000544,'VALLADARES RIVERA ERICK EDUARDO',6,1,325,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000568,1000568,'GOMEZ SAMAYOA CESAR JAVIER',6,1,325,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000197,1000197,'JOSE LUIS BALMORE MELGAR CAMPOS',7,1,355.25,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000610,1000610,'GUSTAVO ADOLFO GONZALEZCARDOZA',8,1,400,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000445,1000445,'JONATHAN GEOVANNY MEJIA SANDOVAL',8,1,406,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000126,1000126,'EVER ALEXANDER SERRANO PORTILLO',9,1,772.5,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000057,1000057,'LEMUS MAJANO ORLANDO ALFREDO',9,1,1000,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000436,1000436,'GUILLERMO ALBERTO RAMOS ORELLANA',9,1,1000,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000547,1000547,'DUEÑAS SERRANO IVAN ALEXIS',7,1,329.875,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000090,1000090,'SANCHEZ CASTILLO JUAN ANTONIO',3,1,355.25,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000218,1000218,'ORTIZ HEBER JAVED',4,1,390,1)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000078,1000078,'JOSE MAURICIO JACOBO AREVALO',1,1,418.0785,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000180,1000180,'ROBOAN ELUSAI BELTRAN MEJIA',1,1,406,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000196,1000196,'WILLIAM ALEXIS HERNANDEZ',1,1,426.3,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000433,1000433,'ISMAEL ISAAC SOSA GIL',10,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000434,1000434,'RUDY ALEJANDRO LOPEZ MONTES',10,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000364,1000364,'JOSE EDINSON RAMOS NUILA',10,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000315,1000315,'OMAR ALEXANDER MENDEZ DIAZ',2,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000366,1000366,'MARIO SAUL GARCIA GONZALEZ',2,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000567,1000567,'CASTANEDA ORTIZ RENE ALFREDO',2,1,325,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000087,1000087,'MIGUEL ANGEL MARIO ALFARO',3,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000122,1000122,'JOSE LUIS SANCHEZ FLORES',3,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000537,1000537,'ORTIZ ORTIZ DANIS MAURICIO',3,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000169,1000169,'JACOBO OSWALDO GUZMAN ORTIZ',3,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000171,1000171,'HENRY RODOLFO MORALES CRUZ',4,1,400.925,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000095,1000095,'MARLON BONERGE BERRIOS MARROQUIN',4,1,405.594,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000298,1000298,'SAUL ELICEO CORETO PEREZ',4,1,406,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000440,1000440,'EDUARDO JOSUE SOTELO LOPEZ',4,1,406,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000441,1000441,'JONATHAN ENRIQUE ZETINO HERNANDEZ',4,1,406,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000367,1000367,'RICARDO ANTONIO GARCIA FLORES',4,1,406,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000205,1000205,'JAIME HUMBERTO MARTINEZ GARCIA',5,1,431.375,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000118,1000118,'FRANCISCO JAVIER ESCALANTE PINEDA',5,1,431.375,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000206,1000206,'JOSE REYNALDO SANDOVAL CHACHAGUA',5,1,431.375,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000140,1000140,'HENRY JONATHAN GIL GALDAMEZ',6,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000302,1000302,'RINA LUZ AGUILAR CAMPOS',6,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000303,1000303,'MARILU DEL CARMEN ESQUINA SEGUNDO',6,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000558,1000558,'CARRILLO RAMIREZ JAIME ERNESTO',6,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000204,1000204,'EDGAR ANTONIO ORANTES TORRES',6,1,339.0912,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000443,1000443,'CELSO ARMANDO CORTEZ FLORES',6,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000139,1000139,'LEONIDAS RIVAS MARTINEZ',7,1,355.25,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000559,1000559,'GARCIA POCASANGRE ALAN AMILCAR',7,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000437,1000437,'JOSE FABRISSIO CORTEZ PEREZ',7,1,329.875,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000599,1000599,'RICARDO ORLANDO DIAZ HERNANDEZ',9,1,800,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000187,1000187,'JOSE LUIS GALAN GARCIA',11,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000195,1000195,'MARIO GERMAN SANTOS HENRIQUEZ',11,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000381,1000381,'JOSUE DAVID MEJIA PASIN',11,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000560,1000560,'VASQUEZ CAMPOS BALMORE EDIMAR',11,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000089,1000089,'KENIS ANTONIO MONTERROSA HERNANDEZ',1,1,423.1535,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000096,1000096,'RIGOBERTO RODRIGUEZ SANCHEZ',1,1,423.1535,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000127,1000127,'BORIS GRACIANO LARIN HERRERA',1,1,406,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000269,1000269,'GABRIEL ENRIQUE PINEDA BADILLOS',1,1,406,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000590,1000590,'MIGUEL ANGEL MARROQUIN MARTINEZ',2,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000566,1000566,'ALEMAN MARTINEZ GAMALIEL ELISEO',2,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000546,1000546,'MARIO ENRIQUE BATAN GALICIA',2,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000538,1000538,'GUEVARA VILLALTA DOUGLAS ALBERTO',2,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000371,1000371,'LOPEZ DIAZ JONATHAN ALEXANDER',3,1,350,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000051,1000051,'ARTURO ALEXANDER CASTELLANOS',3,1,367.5112,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000561,1000561,'HERNANDEZ CRUZ RENE VLADIMIR',3,1,355.25,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000270,1000270,'NELSON HUMBERTO SANDOVAL ALFARO',3,1,355.25,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000562,1000562,'PADILLA OLLA MELVIN FERNANDO',3,1,355.25,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000372,1000372,'SERGIO ALEXANDER RIVERA ZEPEDA',3,1,355.25,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000271,1000271,'ALEXANDER GONZALEZ AGUILAR',3,1,355.25,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000377,1000377,'ROSALIO ANTONIO RAMOS REYES',3,1,355.25,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000023,1000023,'EDGAR ALBERTO DUARTE CALDERON',5,1,461.7235,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000083,1000083,'ADELSO DEL CARMEN ORTEGA ALBERTO',5,1,431.375,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000121,1000121,'NELSON ENRIQUE CALDERON MARTINEZ',5,1,431.375,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000376,1000376,'CRISTIAN ANTONIO SOTO CAÑAS',5,1,431.375,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000522,1000522,'ELIUD ERNESTO GONZALEZ REYES',6,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000136,1000136,'WILLIAN ANTONIO GIL MENDEZ',6,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000138,1000138,'JONY ELTON RIVERA VILLAFRANCO',6,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000368,1000368,'DORIS SARAI DIAZ VASQUEZ',6,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000600,1000600,'CARLOS ARTURO SANCHEZ RAMIREZ',12,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000186,1000186,'EDWIN ALFREDO ASCENCIO MEDINA',12,1,329.875,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000286,1000286,'VICTOR ALEXIS ANAYA SORIANO',12,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000607,1000607,'RENE ADALBERTO GIRON MONTERROSA',12,1,325,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000189,1000189,'LORENA GUADALUPE QUINTANILLA GALAN',9,1,1000,5)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000107,1000107,'VICTOR ALFONSO PAREDES AMAYA',1,1,406,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000153,1000153,'OSCAR DUEÑAS LEON',1,1,406,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000330,1000330,'FELIX ABRAHAM HURTADO HERNANDEZ',1,1,406,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000481,1000481,'JOSE JAVIER RAMIREZ PORTILLO',3,1,355.25,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000489,1000489,'JOSE RICARDO TORRES MARTINEZ',3,1,355.25,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000615,1000615,'JUAN CARLOS MARTINEZ GARCIA',13,1,265,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000279,1000279,'MIGUEL ANGEL SANDOVAL RIVAS',13,1,268.975,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000027,1000027,'JOSE ESTEBAN ALFARO',5,1,431.375,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000309,1000309,'MANUEL ANTONIO LOPEZ RAMIREZ',5,1,456.75,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000312,1000312,'DOUGLAS ALEXANDER GARCIA RAMON',5,1,431.375,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000336,1000336,'ROBERTO CARLOS AMAYA GOMEZ',14,1,329.875,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000340,1000340,'JOSE ENRIQUE PEREZ GUTIERRREZ',14,1,329.875,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000274,1000274,'CARLOS ROBERTO ANTONIO TOLEDO GIL',15,1,329.875,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000036,1000036,'ANTONIO ALFREDO DELGADO RECINOS',9,1,1000,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000256,1000256,'ALFARO CABRERA SANDRA ELIZABETH',3,1,350,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000263,1000263,'DOUGLAS JAVIER MEJIA PEREZ',1,1,406,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000265,1000265,'LUIS ANTONIO QUINTANILLA REYES',1,1,406,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000350,1000350,'MARIO ERNESTO MUNTO GOMEZ',1,1,406,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000284,1000284,'CRISTINA YESENIA AGUIRRE HENRIQUEZ',3,1,355.25,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000472,1000472,'CARLOS ANTONIO MARTINEZ BELTRAN',3,1,355.25,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000488,1000488,'MARIO ALBERTO ESCOBAR VASQUEZ',3,1,355.25,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000280,1000280,'JOSE RAUL CORNEJO AMAYA',13,1,268.975,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000291,1000291,'DELMY CHAVEZ PORTILLO',13,1,268.975,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000344,1000344,'SAUL ALFREDO ALVARENGA FLORES',13,1,268.975,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000484,1000484,'EVELIN ELIZABETH MERINO MONTES',13,1,268.975,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000478,1000478,'HERNANDEZ RIVERA ANDRES ROLANDO',5,1,425,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000260,1000260,'JULIO CESAR LOPEZ MONGE',5,1,431.375,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000281,1000281,'LUIS ANTONIO HERNANDEZ GARCIA',5,1,431.375,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000174,1000174,'LOPEZ MOLINA JUAN VICENTE',5,1,510,9)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000029,1000029,'ALEX ANIBAL RAMOS',14,1,380.625,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000326,1000326,'CRISTIAN MAURICIO BAIRES MENJIVAR',14,1,329.875,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000486,1000486,'JOSE LUIS MEDINA GUZMAN',14,1,325,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000345,1000345,'RICARDO ALONSO SHUNICO PINTIN',8,1,406,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000258,1000258,'ISRAEL ANTONIO BONILLA SALGUERO',1,1,406,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000327,1000327,'KEVIN VLADIMIR MARTINEZ MELENDEZ',3,1,355.25,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000333,1000333,'ROSA IDALIA ROSALES RAMIREZ',13,1,268.975,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000165,1000165,'WILBER ALBERTO GUTIERREZ ZALDAÑA',5,1,431.375,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000483,1000483,'CARLOS JOSE URBANO PREZA',14,1,329.875,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000348,1000348,'ABRAHAM ELENILSON ZACAPA HERNANDEZ',8,1,406,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000595,1000595,'GIL CASTRO CRUZ',9,1,800,13)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000331,1000331,'NOE EDUARDO BORJA MORALES',1,1,406,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000283,1000283,'MIRNA CECIBEL SALGUERO MENDEZ',3,1,355.25,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000476,1000476,'NAPOLEON ANTONIO RUIZ RAMIREZ',3,1,355.25,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000033,1000033,'NOEMI DEL CARMEN FUENTES',13,1,282.17,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000543,1000543,'HERNANDEZ AGUILAR CARLOS OZIEL',13,1,268.975,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000618,1000618,'CRISTIAN VLADIMIR ARIAS ROJAS',13,1,265,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000047,1000047,'GERARDO ENRIQUE FIGUEROA CHAVEZ',5,1,431.375,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000071,1000071,'GUILLERMO ANTONIO SORIANO CAÑAS',5,1,431.375,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000084,1000084,'JOAQUIN ALVARADO GARCIA',14,1,329.875,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000135,1000135,'RENE ALEXANDER RAMOS',14,1,329.875,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000133,1000133,'JOSE DAVID OTERO CAMPOS',9,1,772.5,15)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000004,1000004,'JUAN ALBERTO MARTINEZ',1,1,406,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000311,1000311,'MARIO VICTOR RAMIREZ CUADRA',1,1,406,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000318,1000318,'RICARDO ENRIQUE MORAN RAMIREZ',1,1,406,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000334,1000334,'MIGUEL DARIO MAYE SHUPAN',1,1,406,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000339,1000339,'WILBER ALEXANDER HERNANDEZ ALFARO',3,1,355.25,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000374,1000374,'MARCO ANTONIO GALDAMEZ GARCIA',3,1,355.25,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000282,1000282,'DEYSI ARELY HERNANDEZ DIAZ',13,1,268.975,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000592,1000592,'JORGE ALBERTO BARRILLAS FLORES',13,1,265,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000540,1000540,'MENJIVAR ARANA RICARDO ANTONIO',13,1,268.975,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000474,1000474,'FERMIN HERIBERTO MENDEZ QUIJANO',13,1,268.975,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000015,1000015,'MARIO ANTONIO PUYAU CHINCO',5,1,435.435,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000037,1000037,'RENE AMILCAR CHAVEZ LOPEZ',5,1,431.375,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000065,1000065,'MARVIN ARTURO ORELLANA FLORES',14,1,329.875,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000132,1000132,'RENE HUMBERTO MONTOYA QUINTANILLA',14,1,355.25,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000045,1000045,'EDWIN ANTONIO CUNZA REYES',8,1,412.09,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000241,1000241,'RAFAEL ANTONIO ALVAREZ RIVERA',9,1,840,17)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000335,1000335,'JUAN ALONSO SOLIS MUNTO',11,1,325,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000357,1000357,'ROBERTO ANTONIO PORTILLO AVILES',11,1,325,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000031,1000031,'ROSA ALVARADO ALAS',1,1,406,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000073,1000073,'MARTHA RUTH AREVALO LINARES',1,1,406.96425,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000508,1000508,'OSCAR ARMANDO RENDEROS MEJIA',3,1,406,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000352,1000352,'ABEL BENEDICTO RIOS VALENCIA',3,1,350,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000019,1000019,'ROSA EMILIA MENDOZA VASQUEZ',16,1,304.5,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000026,1000026,'GLORIA ESPERANZA MEJIA NEJAPA',16,1,304.5,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000355,1000355,'EVELIN MARISOL TORRES CORNEJO',16,1,304.5,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000524,1000524,'SIRIA ARACELY HERNANDEZ HERRERA',16,1,304.5,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000018,1000018,'FELIPA ENRIQUETA MEZQUITA',13,1,268.975,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000022,1000022,'SONIA LOPEZ CRUZ',13,1,297.38485,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000289,1000289,'MARIA KATI VASQUEZ INTERIANO',13,1,268.975,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000589,1000589,'MIGUEL ANGEL LIPE GARCIA',13,1,265,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000035,1000035,'ADONAY CALERO ARAGON',5,1,431.375,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000080,1000080,'DANIEL BRAN GARCIA',5,1,425,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000109,1000109,'JULIO CESAR POCASANGRE RODRIGUEZ',17,1,304.5,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000613,1000613,'HECTOR MISAEL SANCHEZ BRAN',17,1,300,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000044,1000044,'DOLORES VELASQUEZ HERNANDEZ',8,1,406,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000038,1000038,'LUIS ALBERTO FUENTES RODRIGUEZ',1,1,406,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000108,1000108,'JAIRO OSMIN MISMIT AREVALO',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000477,1000477,'MELENDEZ ESCALON RUDY KEVIN',3,1,355.25,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000002,1000002,'RUDY KEVIN MELENDEZ ESCALON',3,1,355.25,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000541,1000541,'TORRES JOSE MAURICIO',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000151,1000151,'CEREN MINTO ALFREDO',5,1,431.375,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000063,1000063,'MOISES ELIAS MEDINA AGUILAR',14,1,355.25,11)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000114,1000114,'MARCOS NOE ESCOBAR FUENTES',14,1,341.04,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000020,1000020,'HUGO ARLES CRUZ SANDOVAL',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000093,1000093,'HUGO ADIEL MANCIA RODRIGUEZ',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000099,1000099,'MANFREDO REINALDO ROMUALDO SANCHEZ',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000106,1000106,'VLADIMIR VASQUEZ MARTINEZ',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000223,1000223,'JOSE MIGUEL SERRANO QUINTANILLA',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000262,1000262,'JUAN JOSE BARAHONA LOVOS',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000325,1000325,'SAUL ARMANDO ALARCON TESHE',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000329,1000329,'MAURICIO ALEXANDER MATAMOROS',1,1,406,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000319,1000319,'AGUILAR GILLEN JOSE ALFREDO',3,1,355.25,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000421,1000421,'JOSE MANUEL ALVARADO HERRERA',3,1,355.25,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000470,1000470,'LUIS HAROLD SANTOS MEDRANO',3,1,355.25,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000475,1000475,'JULIO ENRIQUE ORTIZ JIMENEZ',3,1,355.25,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000277,1000277,'IRIS YESENIA VILLALTA',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000332,1000332,'MARIA ANGELA SIGUENZA MARTINEZ',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000338,1000338,'TONY ALEXANDER GUZMAN',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000619,1000619,'CARLOS ERNESTO JIMENEZ MIRON',13,1,265,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000466,1000466,'IRIS MARISSELA SICILIANO',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000467,1000467,'LUIS ERNESTO LOPEZ HERNANDEZ',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000545,1000545,'RODRIGUEZ PORTILLO NESTOR JOSUE',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000482,1000482,'PEDRO ELISEO VASQUEZ GALDAMEZ',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000593,1000593,'WILLIAM OSWALDO BONILLA MARTINEZ',13,1,265,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000043,1000043,'ALONSO ANTONIO MANGANDI CARIAS',5,1,431.375,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000088,1000088,'EULICES CONSTANZA GUDIEL',5,1,431.375,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000224,1000224,'JOSE ANIBAL ARGUETA',5,1,431.375,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000229,1000229,'IVAN JOSUE REYES',5,1,431.375,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000092,1000092,'MORIS HUMBERTO ARIAS MASAGUA',14,1,380.625,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000102,1000102,'CARLOS ALEXANDER PACHECO QUINTANILLA',14,1,377.58,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000485,1000485,'OSCAR JAVIER MUÑOZ HERNANDEZ',14,1,329.875,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000354,1000354,'AGUILAR MANCIA HERNAN URIEL',18,1,350,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000401,1000401,'OLIVARES MIRNA ELIZABETH',13,1,268.975,25)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000069,1000069,'EDINSON ANIBAL HERNANDEZ PEREZ',1,1,406,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000074,1000074,'SAMUEL GOMEZ POCASANGRE',1,1,406,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000264,1000264,'RONALD WILFREDO QUIÑONEZ DUARTE',3,1,355.25,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000100,1000100,'GLORIA EMELY PORTILLO CABRERA',13,1,274.05,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000210,1000210,'SUSY YESENIA ORTIZ CALZADILLA',13,1,274.05,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000287,1000287,'ROBERTO CARLOS RIVERA',5,1,431.375,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000398,1000398,'JAIRO ENRIQUE GARCIA GARCIA',5,1,431.375,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000471,1000471,'LUIS ERNESTO HERNANDEZ RAMIREZ',18,1,329.875,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000490,1000490,'ERICK OLDINI MARTINEZ REYES',18,1,329.875,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000034,1000034,'CARLOS DANIEL PINEDA ZAS',9,1,1000,27)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000451,1000451,'CLAUDIA TAMARA RUANO FUNES',19,1,395.85,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000011,1000011,'CARLOS ANTONIO ALVARADO PORTILLO',7,1,401.7,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000053,1000053,'EDWIN MANRIQUE RIVERA',7,1,401.7,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000128,1000128,'RAUL ANTONIO CHOTO BELTRAN',7,1,401.7,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000446,1000446,'CARLOS JAVIER CANALES TEPAS',7,1,390,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000447,1000447,'JESUS ALBERTO ESPINOZA RODRIGUEZ',7,1,390,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000591,1000591,'CARLOS GEOVANNY MUSTO PEREZ',7,1,390,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000539,1000539,'CAZUN AGUIRRE JORGE ALBERTO',7,1,390,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000208,1000208,'TOBAR GUERRERO SAMUEL ELIAS',7,1,390,29)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000199,1000199,'MONICA EMPERATRIZ RODRIGUEZ OSORIO',20,1,812.5,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000408,1000408,'HENRY ANTONIO ALAS HERNANDEZ',21,1,888.1,47)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000003,1000003,'ERMELINDA POLANCO GALVEZ',20,1,1650,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000220,1000220,'ANGELICA MARIA RODRIGUEZ PERAZA',22,1,1650,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000407,1000407,'YANCY LISBETH PINEDA RAMIREZ',23,1,525,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000240,1000240,'DALIA IRIS VILLALOBOS PORTILLO',24,1,3160,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000621,1000621,'MARIA ALEJANDRA MORENO CARRANZA',25,1,1650,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000405,1000405,'CARLOS ARAUZ CHAHIN',27,1,2000,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000056,1000056,'PEDRO ANTONIO SANCHEZ BARRERA',29,1,1030,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000142,1000142,'ERICK ALEXANDER ESPINOZA PERDOMO',30,1,3710,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000181,1000181,'MELISSA EUGENIA PARADA ZAVALA',31,1,2600,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000519,1000519,'ROBERTO HERBERT PORTILLO APARICIO',32,1,2376,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000583,1000583,'MOISES ATILIO ABREGO MARROQUIN',32,1,2200,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000427,1000427,'SANCHEZ MENJIVAR CRISTIAN DILBERTO',28,1,950,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000556,1000556,'SERGIO FILEMON MEJIA ALBUREZ',33,1,6800,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000606,1000606,'ELMER ALEXANDER GARRIDO LOPEZ',34,1,1000,54)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000394,1000394,'MEMBREÑO IRAHETA MELVIN JAVIER',35,1,1400,56)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000516,1000516,'CANJURA ALVAYEROS NELLY ARELY',36,1,600,56)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000551,1000551,'GUZMAN ZALDAÑA MARIO GUSTAVO',37,1,550,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000259,1000259,'HUGO JAVIER GARCIA VENTURA',37,1,566.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000587,1000587,'FATIMA VANESSA ORELLANA PLATERO',37,1,550,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000313,1000313,'ANA LUZ GARCIA ORTIZ',37,1,577.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000349,1000349,'EDWIN ROBERTO PORTILLO ORELLANA',37,1,588.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000390,1000390,'KRISIA LUCIA VASQUEZ PEREZ',37,1,566.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000500,1000500,'INGRID VANESSA BELTRAN HERNANDEZ',37,1,550,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000395,1000395,'NORVIS ERNESTO CRUZ CORLETO',37,1,605,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000414,1000414,'JENIFFER YASMINIA ERAZO PINEDA',37,1,577.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000557,1000557,'VELASQUEZ HERRERA JOSUE ELISEO',37,1,577.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000502,1000502,'NESTOR ANTONIO HERNANDEZ TORRES',37,1,594,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000520,1000520,'JESENIA VIOLANTES',37,1,687.5,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000176,1000176,'YANIRA LISSETTE VANEGAS LOPEZ',38,1,550,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000575,1000575,'ORTIZ RIVERA CELINA BEATRIZ',38,1,550,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000202,1000202,'BRENDA NATALI MENDEZ',39,1,900,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000005,1000005,'JESSICA BERCIAN DE MENDOZA',40,1,900,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000521,1000521,'FRANCISCO ANTONIO DUARTE FERNANDEZ',41,1,329.875,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000536,1000536,'MEDINA CUENCA CARLOS MAURICIO',42,1,2163,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000324,1000324,'SIGFRIDO EDGARDO MENDOZA OSORIO',43,1,550,61)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000222,1000222,'SARA ABIGAIL MENJIVAR MIRANDA',44,1,900,61)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000469,1000469,'YANCY LISSETH BERMUDEZ PEREZ',45,1,268.975,61)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000386,1000386,'MONICA BEATRIZ PALMA DE RAFAEL',46,1,3360,63)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000576,1000576,'MARIA JULIA HERNANDEZ HENRIQUEZ',47,1,550,65)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000627,1000627,'GREYSI EUGENIA VARGAS DE PEREZ',47,1,550,65)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000580,1000580,'JAIRO ELISEO FLORES',48,1,325,65)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000535,1000535,'ESCOBAR HENRIQUEZ SILVIA GUADALUPE',47,1,577.5,65)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000191,1000191,'MARIA ARACELI LIQUES ROSALES',49,1,246.6,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000370,1000370,'JORGE ERNESTO ALVARENGA RAMOS',49,1,325,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000030,1000030,'ANABEL RECINOS CASTRO',50,1,900,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000323,1000323,'OMAR ARTURO PINEDA ESCOBAR',51,1,900,65)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000091,1000091,'MIGUEL ANGEL LOPEZ LOPEZ',52,1,246.6,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000079,1000079,'JOVANI ALBERTO FUNES PEREZ',53,1,1399.2,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000070,1000070,'FLORES SALAZAR SANDOR ALBERTO',54,1,625,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000157,1000157,'PEREZ BRAN CARLOS ALBERTO',54,1,800,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000016,1000016,'MIGUEL ANGEL SERRANO GUILLEN',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000021,1000021,'PILAR ALBERTO CARRANZA LOPEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000024,1000024,'JORGE AQUILES LOPEZ CARIAS',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000025,1000025,'GUILLERMO ANTONIO DOMINGUEZ CORTEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000028,1000028,'JORGE ALBERTO HERNANDEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000042,1000042,'WILLIAMS ALFREDO LINARES RIVERA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000049,1000049,'DIEGO SELIM AMAYA HERNANDEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000060,1000060,'ORLANDO ENRIQUE RINCAN RIVERA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000061,1000061,'WILDER OSWALDO MARTINEZ MARTINEZ',55,1,537.1583,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000062,1000062,'JOAQUIN ENRIQUE GUTIERREZ GUIROLA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000067,1000067,'HERIS EDENILSON ALBANEZ HERNANDEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000417,1000417,'PEÑA GUEVARA LAZARO FRANCISCO',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000077,1000077,'ROBERTO BENJAMIN MARROQUIN GONZALEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000112,1000112,'JORGE ANTONIO RIVAS MONTERROSA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000115,1000115,'ALVARO MANUEL ANTONIO GUERRERO MENDOZA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000120,1000120,'RIGOBERTO ANTONIO ORANTES TEJADA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000124,1000124,'CARLOS ALBERTO TORRES HENRIQUEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000129,1000129,'RONALD ALEXIS ESCOBAR ARUCHA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000163,1000163,'FRANKLIN ELIAS ZAMORA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000172,1000172,'GERMAN SAUL ARIAS GUEVARA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000248,1000248,'BRYAN FRANCISCO JAIME PALACIOS',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000268,1000268,'WILLIAM HUMBERTO CALDERON PINEDA',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000507,1000507,'VICTOR SALVADOR TULA OBANDO',55,1,500,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000295,1000295,'MAYNOR ALEXIS MARINERO MARTINEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000320,1000320,'ORLANDO ERNESTO JOVEL MORAN',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000346,1000346,'MARIO ENRIQUE ANAYA LEONOR',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000353,1000353,'ELIUD JEHONIAS ORTIZ MENENDEZ',55,1,507.5,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000041,1000041,'MANUEL DE JESUS BURGOS CARDOZA',56,1,824,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000272,1000272,'ADOLFO ANTONIO SORIANO FUENTES',56,1,900,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000413,1000413,'ROMEO ANDRES CRUZVELA DUARTE',56,1,900,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000012,1000012,'CARLOS MANUEL QUINTANILLA ARTIGA',57,1,1000,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000017,1000017,'JULIO AMILCAR GUTIERREZ GUIROLA',57,1,824,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000082,1000082,'SALVADOR ANTONIO VASQUEZ CARBALLO',57,1,824,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000230,1000230,'JOSE RICARDO SAENZ HENRIQUEZ',57,1,824,68)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000192,1000192,'FREDIS ALONSO AGUILAR MIRA',49,1,246.6,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000194,1000194,'MIGUEL ANGEL HENRIQUEZ ABREGO',49,1,246.6,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000400,1000400,'DIEGO RICARDO SALES CORADO',58,1,2163,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000622,1000622,'EDWIN ERNESTO MEZQUITA TORRES',59,1,350,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000578,1000578,'JOSE ADALBERTO VASQUEZ MONGE',59,1,350,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000510,1000510,'JUAN JOSE FLORES HERNANDEZ',59,1,355.25,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000513,1000513,'DOUGLAS DE JESUS TINO HERNANDEZ',59,1,355.25,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000341,1000341,'RENE MAURICIO DERAS CENTENO',60,1,800,71)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000426,1000426,'BENJAMIN ALBERTO MORENO MONTERROSA',61,1,1100,73)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000048,1000048,'ROBERTO ANTONIO MORENO MIRANDA',61,1,1050,73)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000143,1000143,'CARLOS ATILIO MORAN SEGURA',62,1,2625,73)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000123,1000123,'OBDULIO AMILCAR AVILES ROSALES',63,1,304.5,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000214,1000214,'FRANCISCO LINARES RAMOS',63,1,304.5,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000219,1000219,'ANGEL ANTONIO DE PAZ GUZMAN',63,1,304.5,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000321,1000321,'JOSE ROBERTO SHENTE HERNANDEZ',63,1,304.5,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000586,1000586,'WILMER FERNANDO SANCHEZ HERNANDEZ',63,1,300,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000453,1000453,'CESAR ARMANDO PEREZ SIBRIAN',63,1,304.5,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000465,1000465,'ARNOLDO ALEJANDRO HERRERA HERNANDEZ',63,1,304.5,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000125,1000125,'MIGUEL ANGEL ERNESTO HERNANDEZ ESQUIVEL',64,1,600,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000001,1000001,'WILFREDO CUELLAR RIVERA',65,1,500,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000343,1000343,'JUAN JOSE MARROQUIN LIMA',66,1,700,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000161,1000161,'HUGO ALBERTO AMAYA',67,1,1854,75)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000347,1000347,'RAFAEL ANTONIO ALVARADO HERNANDEZ',68,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000119,1000119,'LUIS ALBERTO GOMEZ RIVAS',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000141,1000141,'ERNESTO ANTONIO MENJIVAR GALINO',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000178,1000178,'JOSE ROLANDO CARCAMO PATIÑO',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000226,1000226,'EDWIN ERNESTO RECINOS ALVARENGA',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000234,1000234,'SALVADOR HERNAN RUIZ',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000235,1000235,'ERIC ALFONSO ESPINOZA',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000249,1000249,'DAVID HUMBERTO PEREZ AGUILLON',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000316,1000316,'MAURICIO AUGUSTO JIMENEZ ROSALES',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000431,1000431,'JOSUE ALEXANDER AGUIRRE PORTILLO',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000455,1000455,'JORGE ALBERTO LINARES SEGURA',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000456,1000456,'CARLOS MANUEL MARTINEZ CALDERON',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000458,1000458,'NELSON DANILO RAMIREZ MURCIA',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000459,1000459,'OSCAR ARMANDO PERDOMO HERNANDEZ',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000462,1000462,'JOSUE ANTONIO PALMA HENRIQUEZ',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000614,1000614,'NELSON ANTONIO MARTIR GOMEZ',68,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000464,1000464,'NELSON ANTONIO VANEGAS SARMIENTO',68,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000463,1000463,'WILFREDO OMAR SANCHEZ MENDEZ',69,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000542,1000542,'AGUILAR SION ISAIAS',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000116,1000116,'WILMER ALONSO HERNANDEZ MENDEZ',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000231,1000231,'PEDRO ALFONSO GONZALEZ',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000361,1000361,'JOSE CARLOS IRAHETA CHACON',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000415,1000415,'FRANCISCO ANTONIO MAGAÑA PINTO',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000452,1000452,'VICTOR ALEXIS MUNTO NOYOLA',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000454,1000454,'RONY ANTONIO FUENTES CARCAMO',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000625,1000625,'WILLIAM ERNESTO CAÑADA CABRERA',69,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000461,1000461,'GERARDO ADONAY CARPIO GONZALEZ',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000117,1000117,'OSCAR ALFREDO ZUNIGA GARCIA',70,1,406,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000144,1000144,'CARLOS ISRAEL HERNANDEZ COLOCHO',70,1,500,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000072,1000072,'ESMERALDA ADELA RIVERA',71,1,800,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000418,1000418,'ROBERTO FERNANDO HERNANDEZ CORTEZ',72,1,456.75,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000228,1000228,'CARLOS ALBERTO RIVERA',73,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000301,1000301,'FRANCISCO ANTONIO CASTRO GARCIA',73,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000384,1000384,'LUIS ERNESTO VEGA HERNANDEZ',73,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000491,1000491,'DEVI JOANNA GONZALEZ ALVARENGA',73,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000255,1000255,'HUGO AMILCAR RIVERA',74,1,350,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000006,1000006,'GUILLERMO ARMANDO PEÑA AVILA',75,1,2000,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000076,1000076,'CARLOS ERNESTO MESTIZO HERNANDEZ',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000145,1000145,'JUAN MANUEL MELENDEZ VASQUEZ',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000159,1000159,'JESUS ALEXANDER HERNANDEZ',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000177,1000177,'VICTORINO CERROS',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000233,1000233,'CARLOS ALFREDO TURCIOS',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000373,1000373,'ISAAC CORTEZ LOPEZ',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000379,1000379,'CARLOS ALFREDO DIMAS SERMEÑO',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000382,1000382,'ALEJANDRO GABRIEL SANCHEZ RAMIREZ',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000383,1000383,'EDWARD ORLANDO PINEDA VALLE',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000351,1000351,'PINEDA PINEDA MARVIN ANTONIO',76,1,350,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000494,1000494,'MARVIN MIGUEL GALAN PEÑA',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000496,1000496,'LUIS ORLANDO CARPIO VALENCIA',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000497,1000497,'WALDO OMAR GRIJALBA VENTURA',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000499,1000499,'EDGAR ALONSO CASTRO PEÑA',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000530,1000530,'EDWIN ALEXANDER FRANCO QUINTANILLA',76,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000068,1000068,'ERIKA MILAGRO RIVERA',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000085,1000085,'WALTER ALFONSO ASCENCIO LOPEZ',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000098,1000098,'ALONSO ALVARADO',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000158,1000158,'EDWIN ALEXANDER EUCEDA',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000605,1000605,'HERBER ALEXANDER RIVERA GARCIA',77,1,350,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000188,1000188,'JOSE LUIS AQUINO',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000203,1000203,'EDWARD BRENE ALVAREZ ZEPEDA',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000212,1000212,'ELVIS ANTONIO GARCIA PEREZ',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000215,1000215,'ERIK ADONAY ESPINOZA ORELLANA',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000275,1000275,'JOSE LUIS MOJICA RODRIGUEZ',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000299,1000299,'EVER ALEJANDRO AVALOS SANABRIA',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000300,1000300,'JOSE EDUARDO ESCOBAR RODRIGUEZ',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000360,1000360,'JUAN CARLOS MEJIA CORNEJO',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000363,1000363,'ANGEL DAVID HERRERA PALACIOS',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000375,1000375,'IMMER SAMAI FLORES CHAVEZ',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000380,1000380,'EDWIN ALFREDO CEA PEÑATE',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000492,1000492,'JORGE ALBERTO PALACIOS ALVARADO',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000493,1000493,'GILMER YOBANY ABREGO',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000495,1000495,'JOSE ANTONIO ROMERO',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000498,1000498,'RAFAEL GEOVANNY CHAVEZ HENRIQUEZ',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000532,1000532,'GERMAN ERNESTO CHAVEZ GARCIA',77,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000225,1000225,'JOSE EFRAIN GARCIA CORTEZ',8,1,355.25,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000598,1000598,'JOSE DANILO HERNANDEZ ARAGON',8,1,350,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000146,1000146,'CARMELINA RIVERA CHAVEZ',78,1,947.375,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000183,1000183,'CESAR MAURICIO JULE URRUTIA',78,1,945,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000246,1000246,'DENNIS IVAN SURA CRUZ',78,1,853.125,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000292,1000292,'BLANCA MARGARITA DEL ROSARIO AGUILLON PA',78,1,843.75,38)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000103,1000103,'CARLOS ALONSO LAZO ANGEL',79,1,347.13,36)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000130,1000130,'ARTURO ANTONIO GARCIA PERAZA',79,1,376.8898,36)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000429,1000429,'DAVID ARNOLDO ROMERO RIVERA',79,1,345.1,36)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000430,1000430,'MARVIN JOVANNY ALVAREZ FLORES',79,1,345.1,36)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000227,1000227,'ILIANA ELIZABETH AGUILLON URIBE',80,1,1255,89)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000149,1000149,'JENNIFER LISSETH TORRES CASTILLO',81,1,1050,89)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000101,1000101,'JOSE ROBERTO FLORES SALAZAR',82,1,647.024,89)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000162,1000162,'GUILLERMO ANDRES CHICAS',82,1,896,88)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000403,1000403,'INGRID MARICELA VENTURA MARQUEZ',83,1,840,89)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000164,1000164,'MARTA ELIZABETH GARCIA MAGAÑA',84,1,1090,88)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000190,1000190,'RENE ALEXANDER GALDAMEZ',85,1,2200,89)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000155,1000155,'DELFINA IDALIA SOLORZANO',86,1,3000,88)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000213,1000213,'MANUEL DE JESUS ESCOBAR AVELAR',87,1,1070,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000217,1000217,'FATIMA AMALIA HERNANDEZ VELASQUEZ',87,1,1080,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000097,1000097,'CLAUDIA ESTHER RAMOS CARCAMO',88,1,824,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000160,1000160,'SILVIA EDELMIRA GARCIA RAMOS',88,1,1000,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000236,1000236,'DIANYRA ANGELICA MAZARIEGO MELENDEZ',88,1,824,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000409,1000409,'CARLOS EFRAIN GIL ORTIZ',88,1,824,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000410,1000410,'KRYSSIA IVETH RODRIGUEZ CORNEJO',88,1,800,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000428,1000428,'RENE ARTURO PORTILLO GARCIA',88,1,800,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000253,1000253,'GABRIELA DEL CARMEN TOVAR OLIVA',89,1,3250,43)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000555,1000555,'HERNANDEZ BRIZUELA RONALD ALONSO',90,1,1100,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000251,1000251,'KRISCIA IVETTE CASTRO BRUNO',91,1,1200,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000358,1000358,'DIANA CINDY LARA ESCOBAR',91,1,1200,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000032,1000032,'MARTA ALICIA GRANADILLO CATACHO',92,1,1200,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000604,1000604,'ERIKA EVELYN MONGE DE VASQUEZ',93,1,500,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000588,1000588,'MARIO OSWALDO GUERRA GANUZA',94,1,2000,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000506,1000506,'ABREGO FLORES ELVIA MARILETH',95,1,1600,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000052,1000052,'CARLOS ENRIQUE SARMIENTO IRAHETA',96,1,507.5,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000579,1000579,'RAMOS DE GONZALEZ INGRID BEATRIZ',97,1,500,44)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000245,1000245,'MAURICIO ROBERTO GALVEZ PONCE',98,1,2000,46)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000531,1000531,'DAVID ALEJANDRO MELARA PEÑA',99,1,1064,78)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000050,1000050,'HECTOR ANTONIO GONZALEZ MUNGUIA',100,1,1364.75,78)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000533,1000533,'HENRY ALBERTO MARROQUIN QUINTANILLA',101,1,592.25,78)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000007,1000007,'ERNESTO FERNANDEZ',102,1,507.5,78)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000238,1000238,'LISSETTE CAROLINA GUZMAN CALDERON',103,1,2756,78)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000529,1000529,'CRISTINA MARIA MOLINA GABRIEL',105,1,1854,79)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000147,1000147,'ELMER ARNOLDO MOLINA RIVERA',106,1,2530,79)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000577,1000577,'HELIOS TONATIUH MUÑOZ ULLOA',107,1,5000,80)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000603,1000603,'SOFIA OLIVO RUBIO',109,1,2000,47)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000173,1000173,'RODEZNO ALVARADO CESAR GUSTAVO',110,1,1133,48)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000416,1000416,'RODOLFO ANTONIO SERRANO SALAZAR',111,1,721,48)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000305,1000305,'BRENDA JULISSA ALBANEZ VANEGAS',112,1,1500,48)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000563,1000563,'ASCENCIO BERNAL ANA ISABEL',113,1,975,49)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000573,1000573,'SARAVIA FUENTES FATIMA MARIA',113,1,975,49)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000623,1000623,'ANA CATALINA LINARES GUEVARA',114,1,1900,49)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000040,1000040,'HECTOR ARTURO FLORES CALDERON',115,1,1250,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000597,1000597,'MARVIN ERNESTO CALDERON GARCIA',116,1,700,52)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000166,1000166,'JULIO ERNESTO SOLORZANO BAILON',117,1,1500,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000185,1000185,'ALVARADO FUENTES PATRICIA LISSETH',118,1,700,59)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000552,1000552,'MENDEZ CONTRERAS JOSE ANIBAL',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000548,1000548,'SIBRIAN CALDERON ANGEL DE JESUS',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000549,1000549,'HERNANDEZ LAINEZ MARCO TULIO',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000550,1000550,'BARAHONA SALDAÑA JOSE EDUARDO',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000553,1000553,'ALDANA PEÑA HERMAN RENATO',69,1,355.25,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000624,1000624,'NESTOR LISANDRO ORELLANA',69,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000565,1000565,'LEON PUQUIR JOSE FERNANDO',69,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000564,1000564,'MENDEZ HERNANDEZ FRANCISCO JAVIER',69,1,350,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000569,1000569,'HERNANDEZ SARAVIA TANIA MARIBEL',71,1,900,34)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000297,1000297,'RAFAEL ANTONIO VELASCO MORALES',1,1,400,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000480,1000480,'JUAN ALBERTO CHAVEZ IRAHETA',11,1,325,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000611,1000611,'SERGIO ILDER SANCHEZ ROMERO',3,1,350,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000014,1000014,'MARTA JULIA MEJIA SANCHEZ',16,1,277.4,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000612,1000612,'DEYSI ABIGAIL HERNANDEZ GRANADOS',16,1,300,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000609,1000609,'OSCAR ARMANDO RUIZ MAZARIEGO',13,1,265,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000616,1000616,'HECTOR JEREMIAS HERRERA FLORES',13,1,300,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000094,1000094,'MISAEL AZARIAS CORTEZ ZUNIGA',5,1,425,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000617,1000617,'JOSE ERNESTO SICILIANO TORRES',17,1,300,21)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000572,1000572,'VILLEDA CEA WALTER IVAN',111,1,700,48)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000584,1000584,'OSCAR ALEXANDER GUILLEN CORTEZ',120,1,1500,79)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000528,1000528,'KATHERINE SARAI ROSALES HERNANDEZ',26,1,650,31)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000055,1000055,'CERRATO RUDDY EDWIN',9,1,800,3)
INSERT Employees(Id,Code,Name,PositionId,Active,Salary,CostCenterId) VALUES(1000075,1000075,'LEDIS YESENIA MENJIVAR GUARDADO',121,1,650,52)
GO
SET IDENTITY_INSERT Employees OFF
GO

UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000450
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000511
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000209
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000438
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000439
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000170
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000505
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000105
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000507
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000442
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000131
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000134
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000365
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000568
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000197
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000435
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000445
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000126
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000057
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000436
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000547
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000090
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000218
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000078
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000180
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000196
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000433
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000434
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000364
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000315
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000366
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000567
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000087
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000122
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000537
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000169
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000171
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000095
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000298
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000440
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000441
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000367
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000205
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000118
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000206
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000140
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000302
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000303
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000558
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000204
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000443
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000139
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000559
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000437
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000599

UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000187
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000195
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000381
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000560
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000089
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000096
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000127
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000269
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000590
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000566
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000546
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000538
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000371
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000051
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000561
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000270
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000562
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000372
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000271
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000377
UPDATE Employees SET LifeInsurance=14000 WHERE ID=1000023
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000083
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000121
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000376
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000522
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000136
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000138
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000368
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000600
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000186
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000286
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000406

UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000189
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000107
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000153
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000330
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000481
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000489
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000014
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000279

UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000027
UPDATE Employees SET LifeInsurance=14000 WHERE ID=1000309
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000312
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000336
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000340
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000274
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000036
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000256
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000263
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000265
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000350
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000284

UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000472
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000488
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000280
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000291
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000344
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000484
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000478
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000260
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000281
UPDATE Employees SET LifeInsurance=16000 WHERE ID=1000174
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000029
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000326
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000352
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000345
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000258
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000327
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000333
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000165
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000483
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000348
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000595
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000331
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000283
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000476
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000033
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000543
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000480
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000047
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000071
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000084
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000135
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000133
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000004
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000311
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000318
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000334
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000339
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000374
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000282
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000342
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000540
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000474
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000015
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000037
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000065
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000132
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000045
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000241
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000297
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000357
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000031
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000073
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000508
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000094
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000019
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000026
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000355
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000524
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000018
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000022
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000289
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000589
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000035
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000080
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000109
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000335
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000044
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000038
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000108
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000477
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000477

UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000541
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000151
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000063
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000114
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000020
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000093
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000099
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000106
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000223
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000262
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000325
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000329
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000319
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000421
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000470
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000475
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000277
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000332
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000338
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000544
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000466
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000467
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000545
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000482
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000593
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000043
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000088
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000224
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000229
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000092
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000102
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000485
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000354
UPDATE Employees SET LifeInsurance=8000 WHERE ID=1000401
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000069
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000074
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000264
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000100
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000210
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000287
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000398
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000471
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000490
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000034
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000451
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000011
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000053
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000128
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000446
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000447
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000449
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000539
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000208
UPDATE Employees SET LifeInsurance=19500 WHERE ID=1000199
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000408

UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000003
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000220
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000407
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000240


UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000405

UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000056
UPDATE Employees SET LifeInsurance=45000 WHERE ID=1000142
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000181
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000519
UPDATE Employees SET LifeInsurance=23000 WHERE ID=6
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000427
UPDATE Employees SET LifeInsurance=75000 WHERE ID=1000556
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000394
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000606
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000516
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000551
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000259
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000306
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000313
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000349
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000390
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000391
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000395
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000414
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000557
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000502
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000520
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000176
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000575
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000202
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000520
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000521
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000536
UPDATE Employees SET LifeInsurance=17000 WHERE ID=1000324
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000222
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000515
UPDATE Employees SET LifeInsurance=45000 WHERE ID=1000386
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000576
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000500
UPDATE Employees SET LifeInsurance=11000 WHERE ID=7
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000535
UPDATE Employees SET LifeInsurance=7110 WHERE ID=1000191
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000370
UPDATE Employees SET LifeInsurance=21000 WHERE ID=1000030
UPDATE Employees SET LifeInsurance=20625 WHERE ID=1000323
UPDATE Employees SET LifeInsurance=7110 WHERE ID=1000091
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000079
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000070
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000157
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000016
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000021
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000024
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000025
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000028
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000042
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000049
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000060
UPDATE Employees SET LifeInsurance=16000 WHERE ID=1000061
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000062
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000067
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000417
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000077
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000112
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000115
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000120
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000124
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000129

UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000163
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000172
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000248
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000268
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000293
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000295

UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000320
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000346
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000353
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000041
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000272
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000413
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000012
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000017
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000082
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000230
UPDATE Employees SET LifeInsurance=7110 WHERE ID=1000192
UPDATE Employees SET LifeInsurance=7110 WHERE ID=1000194
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000400
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000378
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000578
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000510
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000513
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000341
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000010
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000048
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000143
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000123
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000214
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000219
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000321
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000322
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000453
UPDATE Employees SET LifeInsurance=9000 WHERE ID=1000465
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000125
UPDATE Employees SET LifeInsurance=15000 WHERE ID=1000001
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000343
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000161
UPDATE Employees SET LifeInsurance=10000 WHERE ID=1000347
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000119
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000141
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000178
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000226
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000234
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000235
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000249
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000316
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000431
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000455
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000456
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000458
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000459
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000462
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000463
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000464
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000059
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000542
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000116
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000231
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000361
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000415
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000452
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000454
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000457
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000461
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000117
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000144
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000072
UPDATE Employees SET LifeInsurance=13500 WHERE ID=1000418
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000228
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000301
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000384
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000491
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000255
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000405
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000076
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000145
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000159
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000177
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000233
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000373
UPDATE Employees SET LifeInsurance=10500 WHERE ID=1000379
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000382
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000383
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000351
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000494
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000496
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000497
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000499
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000530
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000068
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000085
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000098
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000158
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000168
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000188
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000203
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000212
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000215
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000275
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000299
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000300
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000360
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000363
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000375
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000380
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000492
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000493
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000495
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000498
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000532
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000225
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000598
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000146
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000183
UPDATE Employees SET LifeInsurance=19500 WHERE ID=1000246
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000292

UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000103
UPDATE Employees SET LifeInsurance=12000 WHERE ID=1000130
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000429
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000430
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000227
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000149
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000101
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000162
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000403
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000164
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000190
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000155
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000213
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000217
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000097
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000160
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000236
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000409
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000410
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000428
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000253
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000555
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000251
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000358
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000032
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000244
UPDATE Employees SET LifeInsurance=23000 WHERE ID=11
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000506
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000052
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000579
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000245
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000531
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000050
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000533
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000007
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000238

UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000529
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000147
UPDATE Employees SET LifeInsurance=75000 WHERE ID=1000577

UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000603
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000173
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000416
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000305
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000563
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000573
UPDATE Employees SET LifeInsurance=23000 WHERE ID=1000252

UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000040
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000570
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000166
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000185
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000552
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000548
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000549
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000550
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000553
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000554
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000565
UPDATE Employees SET LifeInsurance=11000 WHERE ID=1000564
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000569
UPDATE Employees SET LifeInsurance=12000 WHERE ID=14
UPDATE Employees SET LifeInsurance=10000 WHERE ID=15
UPDATE Employees SET LifeInsurance=11000 WHERE ID=16
UPDATE Employees SET LifeInsurance=9000 WHERE ID=17
UPDATE Employees SET LifeInsurance=9000 WHERE ID=18
UPDATE Employees SET LifeInsurance=9000 WHERE ID=19
UPDATE Employees SET LifeInsurance=9000 WHERE ID=20
UPDATE Employees SET LifeInsurance=12000 WHERE ID=21
UPDATE Employees SET LifeInsurance=9000 WHERE ID=22
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000572

UPDATE Employees SET LifeInsurance=18000 WHERE ID=24
UPDATE Employees SET LifeInsurance=18000 WHERE ID=1000528
UPDATE Employees SET LifeInsurance=18750 WHERE ID=1000055
UPDATE Employees SET LifeInsurance=13000 WHERE ID=1000075
GO

UPDATE Employees SET Variable=40 WHERE ID=1000450
UPDATE Employees SET Variable=40 WHERE ID=1000511
UPDATE Employees SET Variable=40 WHERE ID=1000209
UPDATE Employees SET Variable=40 WHERE ID=1000438
UPDATE Employees SET Variable=40 WHERE ID=1000439
UPDATE Employees SET Variable=40 WHERE ID=1000365
UPDATE Employees SET Variable=40 WHERE ID=1000505
UPDATE Employees SET Variable=40 WHERE ID=1000105
UPDATE Employees SET Variable=40 WHERE ID=1000435
UPDATE Employees SET Variable=40 WHERE ID=1000406
UPDATE Employees SET Variable=40 WHERE ID=1000131
UPDATE Employees SET Variable=40 WHERE ID=1000134
UPDATE Employees SET Variable=40 WHERE ID=1000544
UPDATE Employees SET Variable=40 WHERE ID=1000568
UPDATE Employees SET Variable=40 WHERE ID=1000197
UPDATE Employees SET Variable=40 WHERE ID=1000610
UPDATE Employees SET Variable=40 WHERE ID=1000445
UPDATE Employees SET Variable=150 WHERE ID=1000126
UPDATE Employees SET Variable=150 WHERE ID=1000057
UPDATE Employees SET Variable=150 WHERE ID=1000436
UPDATE Employees SET Variable=40 WHERE ID=1000547
UPDATE Employees SET Variable=40 WHERE ID=1000090
UPDATE Employees SET Variable=40 WHERE ID=1000218
UPDATE Employees SET Variable=40 WHERE ID=1000078
UPDATE Employees SET Variable=40 WHERE ID=1000180
UPDATE Employees SET Variable=40 WHERE ID=1000196
UPDATE Employees SET Variable=40 WHERE ID=1000433
UPDATE Employees SET Variable=40 WHERE ID=1000434
UPDATE Employees SET Variable=40 WHERE ID=1000364
UPDATE Employees SET Variable=40 WHERE ID=1000315
UPDATE Employees SET Variable=40 WHERE ID=1000366
UPDATE Employees SET Variable=40 WHERE ID=1000567
UPDATE Employees SET Variable=40 WHERE ID=1000087
UPDATE Employees SET Variable=40 WHERE ID=1000122
UPDATE Employees SET Variable=40 WHERE ID=1000537
UPDATE Employees SET Variable=40 WHERE ID=1000169
UPDATE Employees SET Variable=40 WHERE ID=1000171
UPDATE Employees SET Variable=40 WHERE ID=1000095
UPDATE Employees SET Variable=40 WHERE ID=1000298
UPDATE Employees SET Variable=40 WHERE ID=1000440
UPDATE Employees SET Variable=40 WHERE ID=1000441
UPDATE Employees SET Variable=40 WHERE ID=1000367
UPDATE Employees SET Variable=40 WHERE ID=1000205
UPDATE Employees SET Variable=40 WHERE ID=1000118
UPDATE Employees SET Variable=40 WHERE ID=1000206
UPDATE Employees SET Variable=40 WHERE ID=1000140
UPDATE Employees SET Variable=40 WHERE ID=1000302
UPDATE Employees SET Variable=40 WHERE ID=1000303
UPDATE Employees SET Variable=40 WHERE ID=1000558
UPDATE Employees SET Variable=40 WHERE ID=1000204
UPDATE Employees SET Variable=40 WHERE ID=1000443
UPDATE Employees SET Variable=40 WHERE ID=1000139
UPDATE Employees SET Variable=40 WHERE ID=1000559
UPDATE Employees SET Variable=40 WHERE ID=1000437
UPDATE Employees SET Variable=150 WHERE ID=1000599
UPDATE Employees SET Variable=40 WHERE ID=1000187
UPDATE Employees SET Variable=40 WHERE ID=1000195
UPDATE Employees SET Variable=40 WHERE ID=1000381
UPDATE Employees SET Variable=40 WHERE ID=1000560
UPDATE Employees SET Variable=40 WHERE ID=1000089
UPDATE Employees SET Variable=40 WHERE ID=1000096
UPDATE Employees SET Variable=40 WHERE ID=1000127
UPDATE Employees SET Variable=40 WHERE ID=1000269
UPDATE Employees SET Variable=40 WHERE ID=1000590
UPDATE Employees SET Variable=40 WHERE ID=1000566
UPDATE Employees SET Variable=40 WHERE ID=1000546
UPDATE Employees SET Variable=40 WHERE ID=1000538
UPDATE Employees SET Variable=40 WHERE ID=1000371
UPDATE Employees SET Variable=40 WHERE ID=1000051
UPDATE Employees SET Variable=40 WHERE ID=1000561
UPDATE Employees SET Variable=40 WHERE ID=1000270
UPDATE Employees SET Variable=40 WHERE ID=1000562
UPDATE Employees SET Variable=40 WHERE ID=1000372
UPDATE Employees SET Variable=40 WHERE ID=1000271
UPDATE Employees SET Variable=40 WHERE ID=1000377
UPDATE Employees SET Variable=40 WHERE ID=1000023
UPDATE Employees SET Variable=40 WHERE ID=1000083
UPDATE Employees SET Variable=40 WHERE ID=1000121
UPDATE Employees SET Variable=40 WHERE ID=1000376
UPDATE Employees SET Variable=40 WHERE ID=1000522
UPDATE Employees SET Variable=40 WHERE ID=1000136
UPDATE Employees SET Variable=40 WHERE ID=1000138
UPDATE Employees SET Variable=40 WHERE ID=1000368
UPDATE Employees SET Variable=40 WHERE ID=1000600
UPDATE Employees SET Variable=40 WHERE ID=1000186
UPDATE Employees SET Variable=40 WHERE ID=1000286
UPDATE Employees SET Variable=40 WHERE ID=1000607
UPDATE Employees SET Variable=150 WHERE ID=1000189
UPDATE Employees SET Variable=40 WHERE ID=1000107
UPDATE Employees SET Variable=40 WHERE ID=1000153
UPDATE Employees SET Variable=40 WHERE ID=1000330
UPDATE Employees SET Variable=40 WHERE ID=1000481
UPDATE Employees SET Variable=40 WHERE ID=1000489
UPDATE Employees SET Variable=40 WHERE ID=1000615
UPDATE Employees SET Variable=40 WHERE ID=1000279
UPDATE Employees SET Variable=40 WHERE ID=1000027
UPDATE Employees SET Variable=40 WHERE ID=1000309
UPDATE Employees SET Variable=40 WHERE ID=1000312
UPDATE Employees SET Variable=40 WHERE ID=1000336
UPDATE Employees SET Variable=40 WHERE ID=1000340
UPDATE Employees SET Variable=40 WHERE ID=1000274
UPDATE Employees SET Variable=150 WHERE ID=1000036
UPDATE Employees SET Variable=40 WHERE ID=1000256
UPDATE Employees SET Variable=40 WHERE ID=1000263
UPDATE Employees SET Variable=40 WHERE ID=1000265
UPDATE Employees SET Variable=40 WHERE ID=1000350
UPDATE Employees SET Variable=40 WHERE ID=1000284
UPDATE Employees SET Variable=40 WHERE ID=1000472
UPDATE Employees SET Variable=40 WHERE ID=1000488
UPDATE Employees SET Variable=40 WHERE ID=1000280
UPDATE Employees SET Variable=40 WHERE ID=1000291
UPDATE Employees SET Variable=40 WHERE ID=1000344
UPDATE Employees SET Variable=40 WHERE ID=1000484
UPDATE Employees SET Variable=40 WHERE ID=1000478
UPDATE Employees SET Variable=40 WHERE ID=1000260
UPDATE Employees SET Variable=40 WHERE ID=1000281
UPDATE Employees SET Variable=40 WHERE ID=1000174
UPDATE Employees SET Variable=40 WHERE ID=1000029
UPDATE Employees SET Variable=40 WHERE ID=1000326
UPDATE Employees SET Variable=40 WHERE ID=1000486
UPDATE Employees SET Variable=40 WHERE ID=1000345
UPDATE Employees SET Variable=40 WHERE ID=1000258
UPDATE Employees SET Variable=40 WHERE ID=1000327
UPDATE Employees SET Variable=40 WHERE ID=1000333
UPDATE Employees SET Variable=40 WHERE ID=1000165
UPDATE Employees SET Variable=40 WHERE ID=1000483
UPDATE Employees SET Variable=40 WHERE ID=1000348
UPDATE Employees SET Variable=150 WHERE ID=1000595
UPDATE Employees SET Variable=40 WHERE ID=1000331
UPDATE Employees SET Variable=40 WHERE ID=1000283
UPDATE Employees SET Variable=40 WHERE ID=1000476
UPDATE Employees SET Variable=40 WHERE ID=1000033
UPDATE Employees SET Variable=40 WHERE ID=1000543
UPDATE Employees SET Variable=40 WHERE ID=1000618
UPDATE Employees SET Variable=40 WHERE ID=1000047
UPDATE Employees SET Variable=40 WHERE ID=1000071
UPDATE Employees SET Variable=40 WHERE ID=1000084
UPDATE Employees SET Variable=40 WHERE ID=1000135
UPDATE Employees SET Variable=150 WHERE ID=1000133
UPDATE Employees SET Variable=40 WHERE ID=1000004
UPDATE Employees SET Variable=40 WHERE ID=1000311
UPDATE Employees SET Variable=40 WHERE ID=1000318
UPDATE Employees SET Variable=40 WHERE ID=1000334
UPDATE Employees SET Variable=40 WHERE ID=1000339
UPDATE Employees SET Variable=40 WHERE ID=1000374
UPDATE Employees SET Variable=40 WHERE ID=1000282
UPDATE Employees SET Variable=40 WHERE ID=1000592
UPDATE Employees SET Variable=40 WHERE ID=1000540
UPDATE Employees SET Variable=40 WHERE ID=1000474
UPDATE Employees SET Variable=40 WHERE ID=1000015
UPDATE Employees SET Variable=40 WHERE ID=1000037
UPDATE Employees SET Variable=40 WHERE ID=1000065
UPDATE Employees SET Variable=40 WHERE ID=1000132
UPDATE Employees SET Variable=40 WHERE ID=1000045
UPDATE Employees SET Variable=150 WHERE ID=1000241
UPDATE Employees SET Variable=40 WHERE ID=1000335
UPDATE Employees SET Variable=40 WHERE ID=1000357
UPDATE Employees SET Variable=40 WHERE ID=1000031
UPDATE Employees SET Variable=40 WHERE ID=1000073
UPDATE Employees SET Variable=40 WHERE ID=1000508
UPDATE Employees SET Variable=40 WHERE ID=1000352
UPDATE Employees SET Variable=40 WHERE ID=1000019
UPDATE Employees SET Variable=40 WHERE ID=1000026
UPDATE Employees SET Variable=40 WHERE ID=1000355
UPDATE Employees SET Variable=40 WHERE ID=1000524
UPDATE Employees SET Variable=40 WHERE ID=1000018
UPDATE Employees SET Variable=40 WHERE ID=1000022
UPDATE Employees SET Variable=40 WHERE ID=1000289
UPDATE Employees SET Variable=40 WHERE ID=1000589
UPDATE Employees SET Variable=40 WHERE ID=1000035
UPDATE Employees SET Variable=40 WHERE ID=1000080
UPDATE Employees SET Variable=40 WHERE ID=1000109
UPDATE Employees SET Variable=40 WHERE ID=1000613
UPDATE Employees SET Variable=40 WHERE ID=1000044
UPDATE Employees SET Variable=40 WHERE ID=1000038
UPDATE Employees SET Variable=40 WHERE ID=1000108
UPDATE Employees SET Variable=40 WHERE ID=1000477
UPDATE Employees SET Variable=40 WHERE ID=1000477
UPDATE Employees SET Variable=40 WHERE ID=1000541
UPDATE Employees SET Variable=40 WHERE ID=1000151
UPDATE Employees SET Variable=40 WHERE ID=1000063
UPDATE Employees SET Variable=40 WHERE ID=1000114
UPDATE Employees SET Variable=40 WHERE ID=1000020
UPDATE Employees SET Variable=40 WHERE ID=1000093
UPDATE Employees SET Variable=40 WHERE ID=1000099
UPDATE Employees SET Variable=40 WHERE ID=1000106
UPDATE Employees SET Variable=40 WHERE ID=1000223
UPDATE Employees SET Variable=40 WHERE ID=1000262
UPDATE Employees SET Variable=40 WHERE ID=1000325
UPDATE Employees SET Variable=40 WHERE ID=1000329
UPDATE Employees SET Variable=40 WHERE ID=1000319
UPDATE Employees SET Variable=40 WHERE ID=1000421
UPDATE Employees SET Variable=40 WHERE ID=1000470
UPDATE Employees SET Variable=40 WHERE ID=1000475
UPDATE Employees SET Variable=40 WHERE ID=1000277
UPDATE Employees SET Variable=40 WHERE ID=1000332
UPDATE Employees SET Variable=40 WHERE ID=1000338
UPDATE Employees SET Variable=40 WHERE ID=1000619
UPDATE Employees SET Variable=40 WHERE ID=1000466
UPDATE Employees SET Variable=40 WHERE ID=1000467
UPDATE Employees SET Variable=40 WHERE ID=1000545
UPDATE Employees SET Variable=40 WHERE ID=1000482
UPDATE Employees SET Variable=40 WHERE ID=1000593
UPDATE Employees SET Variable=40 WHERE ID=1000043
UPDATE Employees SET Variable=40 WHERE ID=1000088
UPDATE Employees SET Variable=40 WHERE ID=1000224
UPDATE Employees SET Variable=40 WHERE ID=1000229
UPDATE Employees SET Variable=40 WHERE ID=1000092
UPDATE Employees SET Variable=40 WHERE ID=1000102
UPDATE Employees SET Variable=40 WHERE ID=1000485
UPDATE Employees SET Variable=40 WHERE ID=1000354
UPDATE Employees SET Variable=40 WHERE ID=1000401
UPDATE Employees SET Variable=40 WHERE ID=1000069
UPDATE Employees SET Variable=40 WHERE ID=1000074
UPDATE Employees SET Variable=40 WHERE ID=1000264
UPDATE Employees SET Variable=40 WHERE ID=1000100
UPDATE Employees SET Variable=40 WHERE ID=1000210
UPDATE Employees SET Variable=40 WHERE ID=1000287
UPDATE Employees SET Variable=40 WHERE ID=1000398
UPDATE Employees SET Variable=40 WHERE ID=1000471
UPDATE Employees SET Variable=40 WHERE ID=1000490
UPDATE Employees SET Variable=150 WHERE ID=1000034
UPDATE Employees SET Variable=40 WHERE ID=1000451
UPDATE Employees SET Variable=40 WHERE ID=1000011
UPDATE Employees SET Variable=40 WHERE ID=1000053
UPDATE Employees SET Variable=40 WHERE ID=1000128
UPDATE Employees SET Variable=40 WHERE ID=1000446
UPDATE Employees SET Variable=40 WHERE ID=1000447
UPDATE Employees SET Variable=40 WHERE ID=1000591
UPDATE Employees SET Variable=40 WHERE ID=1000539
UPDATE Employees SET Variable=40 WHERE ID=1000208
UPDATE Employees SET Variable=40 WHERE ID=1000199
UPDATE Employees SET Variable=0 WHERE ID=1000408
UPDATE Employees SET Variable=40 WHERE ID=1000003
UPDATE Employees SET Variable=40 WHERE ID=1000220
UPDATE Employees SET Variable=40 WHERE ID=1000407
UPDATE Employees SET Variable=0 WHERE ID=1000240
UPDATE Employees SET Variable=40 WHERE ID=1000621
UPDATE Employees SET Variable=40 WHERE ID=1000405
UPDATE Employees SET Variable=40 WHERE ID=1000056
UPDATE Employees SET Variable=0 WHERE ID=1000142
UPDATE Employees SET Variable=0 WHERE ID=1000181
UPDATE Employees SET Variable=0 WHERE ID=1000519
UPDATE Employees SET Variable=40 WHERE ID=1000583
UPDATE Employees SET Variable=40 WHERE ID=1000427
UPDATE Employees SET Variable=40 WHERE ID=1000556
UPDATE Employees SET Variable=40 WHERE ID=1000606
UPDATE Employees SET Variable=40 WHERE ID=1000394
UPDATE Employees SET Variable=40 WHERE ID=1000516
UPDATE Employees SET Variable=40 WHERE ID=1000551
UPDATE Employees SET Variable=40 WHERE ID=1000259
UPDATE Employees SET Variable=40 WHERE ID=1000587
UPDATE Employees SET Variable=40 WHERE ID=1000313
UPDATE Employees SET Variable=40 WHERE ID=1000349
UPDATE Employees SET Variable=40 WHERE ID=1000390
UPDATE Employees SET Variable=40 WHERE ID=1000500
UPDATE Employees SET Variable=40 WHERE ID=1000395
UPDATE Employees SET Variable=40 WHERE ID=1000414
UPDATE Employees SET Variable=40 WHERE ID=1000557
UPDATE Employees SET Variable=40 WHERE ID=1000502
UPDATE Employees SET Variable=40 WHERE ID=1000520
UPDATE Employees SET Variable=40 WHERE ID=1000176
UPDATE Employees SET Variable=40 WHERE ID=1000575
UPDATE Employees SET Variable=40 WHERE ID=1000202
UPDATE Employees SET Variable=40 WHERE ID=1000520
UPDATE Employees SET Variable=40 WHERE ID=1000521
UPDATE Employees SET Variable=40 WHERE ID=1000536
UPDATE Employees SET Variable=40 WHERE ID=1000324
UPDATE Employees SET Variable=40 WHERE ID=1000222
UPDATE Employees SET Variable=40 WHERE ID=1000469
UPDATE Employees SET Variable=40 WHERE ID=1000386
UPDATE Employees SET Variable=40 WHERE ID=1000576
UPDATE Employees SET Variable=40 WHERE ID=1000627
UPDATE Employees SET Variable=40 WHERE ID=1000580
UPDATE Employees SET Variable=40 WHERE ID=1000535
UPDATE Employees SET Variable=0 WHERE ID=1000191
UPDATE Employees SET Variable=40 WHERE ID=1000370
UPDATE Employees SET Variable=40 WHERE ID=1000030
UPDATE Employees SET Variable=40 WHERE ID=1000323
UPDATE Employees SET Variable=40 WHERE ID=1000091
UPDATE Employees SET Variable=40 WHERE ID=1000079
UPDATE Employees SET Variable=40 WHERE ID=1000070
UPDATE Employees SET Variable=40 WHERE ID=1000157
UPDATE Employees SET Variable=40 WHERE ID=1000016
UPDATE Employees SET Variable=40 WHERE ID=1000021
UPDATE Employees SET Variable=40 WHERE ID=1000024
UPDATE Employees SET Variable=40 WHERE ID=1000025
UPDATE Employees SET Variable=40 WHERE ID=1000028
UPDATE Employees SET Variable=40 WHERE ID=1000042
UPDATE Employees SET Variable=40 WHERE ID=1000049
UPDATE Employees SET Variable=40 WHERE ID=1000060
UPDATE Employees SET Variable=40 WHERE ID=1000061
UPDATE Employees SET Variable=40 WHERE ID=1000062
UPDATE Employees SET Variable=40 WHERE ID=1000067
UPDATE Employees SET Variable=40 WHERE ID=1000417
UPDATE Employees SET Variable=40 WHERE ID=1000077
UPDATE Employees SET Variable=40 WHERE ID=1000112
UPDATE Employees SET Variable=40 WHERE ID=1000115
UPDATE Employees SET Variable=40 WHERE ID=1000120
UPDATE Employees SET Variable=40 WHERE ID=1000124
UPDATE Employees SET Variable=40 WHERE ID=1000129
UPDATE Employees SET Variable=40 WHERE ID=1000163
UPDATE Employees SET Variable=40 WHERE ID=1000172
UPDATE Employees SET Variable=40 WHERE ID=1000248
UPDATE Employees SET Variable=40 WHERE ID=1000268
UPDATE Employees SET Variable=40 WHERE ID=1000507
UPDATE Employees SET Variable=40 WHERE ID=1000295
UPDATE Employees SET Variable=40 WHERE ID=1000320
UPDATE Employees SET Variable=40 WHERE ID=1000346
UPDATE Employees SET Variable=40 WHERE ID=1000353
UPDATE Employees SET Variable=40 WHERE ID=1000041
UPDATE Employees SET Variable=40 WHERE ID=1000272
UPDATE Employees SET Variable=40 WHERE ID=1000413
UPDATE Employees SET Variable=40 WHERE ID=1000012
UPDATE Employees SET Variable=40 WHERE ID=1000017
UPDATE Employees SET Variable=40 WHERE ID=1000082
UPDATE Employees SET Variable=40 WHERE ID=1000230
UPDATE Employees SET Variable=0 WHERE ID=1000192
UPDATE Employees SET Variable=0 WHERE ID=1000194
UPDATE Employees SET Variable=40 WHERE ID=1000400
UPDATE Employees SET Variable=40 WHERE ID=1000622
UPDATE Employees SET Variable=40 WHERE ID=1000578
UPDATE Employees SET Variable=40 WHERE ID=1000510
UPDATE Employees SET Variable=40 WHERE ID=1000513
UPDATE Employees SET Variable=40 WHERE ID=1000341
UPDATE Employees SET Variable=40 WHERE ID=1000426
UPDATE Employees SET Variable=0 WHERE ID=1000048
UPDATE Employees SET Variable=40 WHERE ID=1000143
UPDATE Employees SET Variable=40 WHERE ID=1000123
UPDATE Employees SET Variable=40 WHERE ID=1000214
UPDATE Employees SET Variable=40 WHERE ID=1000219
UPDATE Employees SET Variable=40 WHERE ID=1000321
UPDATE Employees SET Variable=40 WHERE ID=1000586
UPDATE Employees SET Variable=40 WHERE ID=1000453
UPDATE Employees SET Variable=40 WHERE ID=1000465
UPDATE Employees SET Variable=40 WHERE ID=1000125
UPDATE Employees SET Variable=40 WHERE ID=1000001
UPDATE Employees SET Variable=40 WHERE ID=1000343
UPDATE Employees SET Variable=40 WHERE ID=1000161
UPDATE Employees SET Variable=40 WHERE ID=1000347
UPDATE Employees SET Variable=40 WHERE ID=1000119
UPDATE Employees SET Variable=40 WHERE ID=1000141
UPDATE Employees SET Variable=40 WHERE ID=1000178
UPDATE Employees SET Variable=40 WHERE ID=1000226
UPDATE Employees SET Variable=40 WHERE ID=1000234
UPDATE Employees SET Variable=40 WHERE ID=1000235
UPDATE Employees SET Variable=40 WHERE ID=1000249
UPDATE Employees SET Variable=40 WHERE ID=1000316
UPDATE Employees SET Variable=40 WHERE ID=1000431
UPDATE Employees SET Variable=40 WHERE ID=1000455
UPDATE Employees SET Variable=40 WHERE ID=1000456
UPDATE Employees SET Variable=40 WHERE ID=1000458
UPDATE Employees SET Variable=40 WHERE ID=1000459
UPDATE Employees SET Variable=40 WHERE ID=1000462
UPDATE Employees SET Variable=40 WHERE ID=1000614
UPDATE Employees SET Variable=40 WHERE ID=1000464
UPDATE Employees SET Variable=40 WHERE ID=1000463
UPDATE Employees SET Variable=40 WHERE ID=1000542
UPDATE Employees SET Variable=40 WHERE ID=1000116
UPDATE Employees SET Variable=40 WHERE ID=1000231
UPDATE Employees SET Variable=40 WHERE ID=1000361
UPDATE Employees SET Variable=40 WHERE ID=1000415
UPDATE Employees SET Variable=40 WHERE ID=1000452
UPDATE Employees SET Variable=40 WHERE ID=1000454
UPDATE Employees SET Variable=40 WHERE ID=1000625
UPDATE Employees SET Variable=40 WHERE ID=1000461
UPDATE Employees SET Variable=40 WHERE ID=1000117
UPDATE Employees SET Variable=80 WHERE ID=1000144
UPDATE Employees SET Variable=60 WHERE ID=1000072
UPDATE Employees SET Variable=40 WHERE ID=1000418
UPDATE Employees SET Variable=40 WHERE ID=1000228
UPDATE Employees SET Variable=40 WHERE ID=1000301
UPDATE Employees SET Variable=40 WHERE ID=1000384
UPDATE Employees SET Variable=40 WHERE ID=1000491
UPDATE Employees SET Variable=40 WHERE ID=1000255
UPDATE Employees SET Variable=40 WHERE ID=1000405
UPDATE Employees SET Variable=40 WHERE ID=1000076
UPDATE Employees SET Variable=90 WHERE ID=1000145
UPDATE Employees SET Variable=40 WHERE ID=1000159
UPDATE Employees SET Variable=75 WHERE ID=1000177
UPDATE Employees SET Variable=40 WHERE ID=1000233
UPDATE Employees SET Variable=40 WHERE ID=1000373
UPDATE Employees SET Variable=40 WHERE ID=1000379
UPDATE Employees SET Variable=40 WHERE ID=1000382
UPDATE Employees SET Variable=40 WHERE ID=1000383
UPDATE Employees SET Variable=40 WHERE ID=1000351
UPDATE Employees SET Variable=40 WHERE ID=1000494
UPDATE Employees SET Variable=40 WHERE ID=1000496
UPDATE Employees SET Variable=40 WHERE ID=1000497
UPDATE Employees SET Variable=40 WHERE ID=1000499
UPDATE Employees SET Variable=40 WHERE ID=1000530
UPDATE Employees SET Variable=75 WHERE ID=1000068
UPDATE Employees SET Variable=40 WHERE ID=1000085
UPDATE Employees SET Variable=40 WHERE ID=1000098
UPDATE Employees SET Variable=40 WHERE ID=1000158
UPDATE Employees SET Variable=40 WHERE ID=1000605
UPDATE Employees SET Variable=40 WHERE ID=1000188
UPDATE Employees SET Variable=40 WHERE ID=1000203
UPDATE Employees SET Variable=40 WHERE ID=1000212
UPDATE Employees SET Variable=75 WHERE ID=1000215
UPDATE Employees SET Variable=40 WHERE ID=1000275
UPDATE Employees SET Variable=40 WHERE ID=1000299
UPDATE Employees SET Variable=40 WHERE ID=1000300
UPDATE Employees SET Variable=40 WHERE ID=1000360
UPDATE Employees SET Variable=40 WHERE ID=1000363
UPDATE Employees SET Variable=40 WHERE ID=1000375
UPDATE Employees SET Variable=40 WHERE ID=1000380
UPDATE Employees SET Variable=40 WHERE ID=1000492
UPDATE Employees SET Variable=40 WHERE ID=1000493
UPDATE Employees SET Variable=40 WHERE ID=1000495
UPDATE Employees SET Variable=40 WHERE ID=1000498
UPDATE Employees SET Variable=75 WHERE ID=1000532
UPDATE Employees SET Variable=40 WHERE ID=1000225
UPDATE Employees SET Variable=80 WHERE ID=1000598
UPDATE Employees SET Variable=80 WHERE ID=1000146
UPDATE Employees SET Variable=80 WHERE ID=1000183
UPDATE Employees SET Variable=80 WHERE ID=1000246
UPDATE Employees SET Variable=40 WHERE ID=1000292
UPDATE Employees SET Variable=40 WHERE ID=1000103
UPDATE Employees SET Variable=40 WHERE ID=1000130
UPDATE Employees SET Variable=40 WHERE ID=1000429
UPDATE Employees SET Variable=40 WHERE ID=1000430
UPDATE Employees SET Variable=40 WHERE ID=1000227
UPDATE Employees SET Variable=40 WHERE ID=1000149
UPDATE Employees SET Variable=40 WHERE ID=1000101
UPDATE Employees SET Variable=40 WHERE ID=1000162
UPDATE Employees SET Variable=40 WHERE ID=1000403
UPDATE Employees SET Variable=0 WHERE ID=1000164
UPDATE Employees SET Variable=0 WHERE ID=1000190
UPDATE Employees SET Variable=150 WHERE ID=1000155
UPDATE Employees SET Variable=150 WHERE ID=1000213
UPDATE Employees SET Variable=150 WHERE ID=1000217
UPDATE Employees SET Variable=150 WHERE ID=1000097
UPDATE Employees SET Variable=150 WHERE ID=1000160
UPDATE Employees SET Variable=150 WHERE ID=1000236
UPDATE Employees SET Variable=150 WHERE ID=1000409
UPDATE Employees SET Variable=150 WHERE ID=1000410
UPDATE Employees SET Variable=0 WHERE ID=1000428
UPDATE Employees SET Variable=0 WHERE ID=1000253
UPDATE Employees SET Variable=0 WHERE ID=1000555
UPDATE Employees SET Variable=0 WHERE ID=1000251
UPDATE Employees SET Variable=0 WHERE ID=1000358
UPDATE Employees SET Variable=0 WHERE ID=1000032
UPDATE Employees SET Variable=0 WHERE ID=1000604
UPDATE Employees SET Variable=0 WHERE ID=1000588
UPDATE Employees SET Variable=0 WHERE ID=1000506
UPDATE Employees SET Variable=0 WHERE ID=1000052
UPDATE Employees SET Variable=0 WHERE ID=1000579
UPDATE Employees SET Variable=0 WHERE ID=1000245
UPDATE Employees SET Variable=0 WHERE ID=1000531
UPDATE Employees SET Variable=0 WHERE ID=1000050
UPDATE Employees SET Variable=0 WHERE ID=1000533
UPDATE Employees SET Variable=0 WHERE ID=1000007
UPDATE Employees SET Variable=0 WHERE ID=1000238
UPDATE Employees SET Variable=0 WHERE ID=1000529
UPDATE Employees SET Variable=0 WHERE ID=1000147
UPDATE Employees SET Variable=0 WHERE ID=1000577
UPDATE Employees SET Variable=0 WHERE ID=1000603
UPDATE Employees SET Variable=0 WHERE ID=1000173
UPDATE Employees SET Variable=0 WHERE ID=1000416
UPDATE Employees SET Variable=0 WHERE ID=1000305
UPDATE Employees SET Variable=0 WHERE ID=1000563
UPDATE Employees SET Variable=0 WHERE ID=1000573
UPDATE Employees SET Variable=0 WHERE ID=1000623
UPDATE Employees SET Variable=40 WHERE ID=1000040
UPDATE Employees SET Variable=40 WHERE ID=1000597
UPDATE Employees SET Variable=40 WHERE ID=1000166
UPDATE Employees SET Variable=40 WHERE ID=1000185
UPDATE Employees SET Variable=40 WHERE ID=1000552
UPDATE Employees SET Variable=40 WHERE ID=1000548
UPDATE Employees SET Variable=40 WHERE ID=1000549
UPDATE Employees SET Variable=40 WHERE ID=1000550
UPDATE Employees SET Variable=40 WHERE ID=1000553
UPDATE Employees SET Variable=40 WHERE ID=1000624
UPDATE Employees SET Variable=40 WHERE ID=1000565
UPDATE Employees SET Variable=40 WHERE ID=1000564
UPDATE Employees SET Variable=40 WHERE ID=1000569
UPDATE Employees SET Variable=40 WHERE ID=1000297
UPDATE Employees SET Variable=40 WHERE ID=1000480
UPDATE Employees SET Variable=40 WHERE ID=1000611
UPDATE Employees SET Variable=40 WHERE ID=1000014
UPDATE Employees SET Variable=40 WHERE ID=1000612
UPDATE Employees SET Variable=40 WHERE ID=1000609
UPDATE Employees SET Variable=40 WHERE ID=1000616
UPDATE Employees SET Variable=40 WHERE ID=1000094
UPDATE Employees SET Variable=40 WHERE ID=1000617
UPDATE Employees SET Variable=40 WHERE ID=1000572
UPDATE Employees SET Variable=40 WHERE ID=1000584
UPDATE Employees SET Variable=40 WHERE ID=1000528
UPDATE Employees SET Variable=40 WHERE ID=1000055
UPDATE Employees SET Variable=40 WHERE ID=1000075
GO

DELETE Equipments
GO
SET IDENTITY_INSERT Equipments ON
GO
INSERT INTO Equipments(Id,Name) VALUES(1,'Botas de Seguridad (area Seca)')
INSERT INTO Equipments(Id,Name) VALUES(2,'Botas de Seguridad (area humeda)')
INSERT INTO Equipments(Id,Name) VALUES(3,'Botas de Seguridad (Dielectricas)')
INSERT INTO Equipments(Id,Name) VALUES(4,'Protección Auditiva')
INSERT INTO Equipments(Id,Name) VALUES(5,'Redecilla')
INSERT INTO Equipments(Id,Name) VALUES(6,'Chaleco Reflectivo')
INSERT INTO Equipments(Id,Name) VALUES(7,'Guantes Anticorte')
INSERT INTO Equipments(Id,Name) VALUES(8,'Guantes para Quimicos')
INSERT INTO Equipments(Id,Name) VALUES(9,'Gafas Interior/Exterior')
INSERT INTO Equipments(Id,Name) VALUES(10,'Traje para Abejas')
INSERT INTO Equipments(Id,Name) VALUES(11,'Casco/ Gorra contra impactos')
INSERT INTO Equipments(Id,Name) VALUES(12,'Barbiquejo')
INSERT INTO Equipments(Id,Name) VALUES(13,'Cinturon lumbar')
INSERT INTO Equipments(Id,Name) VALUES(14,'Mascarilla')
INSERT INTO Equipments(Id,Name) VALUES(15,'Guantes de cuero Largos')
INSERT INTO Equipments(Id,Name) VALUES(16,'Mandil')
INSERT INTO Equipments(Id,Name) VALUES(17,'Cuchillas de seguridad para corte ')
INSERT INTO Equipments(Id,Name) VALUES(18,'Conos de Seguridad')
INSERT INTO Equipments(Id,Name) VALUES(19,'Cinta para delimitar area')
INSERT INTO Equipments(Id,Name) VALUES(20,'Careta para esmerilar')
INSERT INTO Equipments(Id,Name) VALUES(21,'Careta para soldar')
INSERT INTO Equipments(Id,Name) VALUES(22,'Protector facial')
INSERT INTO Equipments(Id,Name) VALUES(23,'(Caja de 50 pares) Guantes Clinicos')
INSERT INTO Equipments(Id,Name) VALUES(24,'Gafas para quimicos')
INSERT INTO Equipments(Id,Name) VALUES(25,'Traje completo para quimicos')
INSERT INTO Equipments(Id,Name) VALUES(26,'Chumpa para cuarto frio')
INSERT INTO Equipments(Id,Name) VALUES(27,'Gorro Navarone')
INSERT INTO Equipments(Id,Name) VALUES(28,'Guantes para alta temperatura')
INSERT INTO Equipments(Id,Name) VALUES(29,'Guante para cuarto frio')
GO
SET IDENTITY_INSERT Equipments OFF
GO

DELETE Premises
GO
SET IDENTITY_INSERT Premises ON
GO

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(1,'Botas de Seguridad (area Seca)',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">1</Variable>
      <Variable Name="Expense">50</Variable>
      <Variable Name="Provider">1</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(2,'Botas de Seguridad (area humeda)',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">2</Variable>
      <Variable Name="Expense">40</Variable>
      <Variable Name="Provider">2</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(3,'Botas de Seguridad (Dielectricas)',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">3</Variable>
      <Variable Name="Expense">55</Variable>
      <Variable Name="Provider">1</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(4,'Protección Auditiva',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">4</Variable>
      <Variable Name="Expense">0.65</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Apr</Month>
        <Month>Mar</Month>
        <Month>Dec</Month>
        <Month>Nov</Month>
        <Month>Oct</Month>
        <Month>Sep</Month>
        <Month>Aug</Month>
        <Month>Jul</Month>
        <Month>Jun</Month>
        <Month>May</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(5,'Redecilla',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">5</Variable>
      <Variable Name="Expense">0.05</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Sep</Month>
        <Month>Aug</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(6,'Chaleco Reflectivo',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">6</Variable>
      <Variable Name="Expense">6.99</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Sep</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(7,'Guantes Anticorte',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">7</Variable>
      <Variable Name="Expense">6.8</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Bimonthly">
        <Month>Feb</Month>
        <Month>Apr</Month>
        <Month>Jun</Month>
        <Month>Aug</Month>
        <Month>Oct</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(8,'Guantes para Quimicos',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">8</Variable>
      <Variable Name="Expense">7</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Bimonthly">
        <Month>Feb</Month>
        <Month>Apr</Month>
        <Month>Jun</Month>
        <Month>Aug</Month>
        <Month>Oct</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(9,'Gafas Interior/Exterior',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">9</Variable>
      <Variable Name="Expense">3.65</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Quaterly">
        <Month>Feb</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(10,'Traje para Abejas',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">10</Variable>
      <Variable Name="Expense">90</Variable>
      <Variable Name="Provider">2</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(11,'Casco/ Gorra contra impactos',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">11</Variable>
      <Variable Name="Expense">19.15</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(12,'Barbiquejo',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">12</Variable>
      <Variable Name="Expense">1.75</Variable>
      <Variable Name="Provider">2</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(13,'Cinturon lumbar',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">13</Variable>
      <Variable Name="Expense">17</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(14,'Mascarilla',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">14</Variable>
      <Variable Name="Expense">2.15</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(15,'Guantes de cuero Largos',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">15</Variable>
      <Variable Name="Expense">5.9</Variable>
      <Variable Name="Provider">4</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Quaterly">
        <Month>Feb</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(16,'Mandil',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">16</Variable>
      <Variable Name="Expense">12.06</Variable>
      <Variable Name="Provider">7</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(17,'Cuchillas de seguridad para corte',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">17</Variable>
      <Variable Name="Expense">22.6</Variable>
      <Variable Name="Provider">4</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Quaterly">
        <Month>Feb</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(18,'Conos de Seguridad',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">18</Variable>
      <Variable Name="Expense">38</Variable>
      <Variable Name="Provider">1</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(19,'Cinta para delimitar area',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">19</Variable>
      <Variable Name="Expense">7.5</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Quaterly">
        <Month>Feb</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(20,'Careta para esmerilar',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">20</Variable>
      <Variable Name="Expense">18</Variable>
      <Variable Name="Provider">4</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(21,'Careta para soldar',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">21</Variable>
      <Variable Name="Expense">30.02</Variable>
      <Variable Name="Provider">7</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(22,'Protector facial',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">22</Variable>
      <Variable Name="Expense">18</Variable>
      <Variable Name="Provider">4</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(23,'(Caja de 50 pares) Guantes Clinicos',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">23</Variable>
      <Variable Name="Expense">6</Variable>
      <Variable Name="Provider">3</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(24,'Gafas para quimicos',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">24</Variable>
      <Variable Name="Expense">6</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Quaterly">
        <Month>Feb</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(25,'Traje completo para quimicos',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">25</Variable>
      <Variable Name="Expense">12</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(26,'Chumpa para cuarto frio',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">26</Variable>
      <Variable Name="Expense">90</Variable>
      <Variable Name="Provider">6</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Annual">
        <Month>Feb</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(27,'Gorro Navarone',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">27</Variable>
      <Variable Name="Expense">12</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(28,'Guantes para alta temperatura',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">28</Variable>
      <Variable Name="Expense">7.25</Variable>
      <Variable Name="Provider">1</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Quaterly">
        <Month>Feb</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

INSERT INTO Premises(Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(29,'Guante para cuarto frio',2016,1,9,
'<Premise>
  <Expense>
    <Variables>
      <Variable Name="Equipment">29</Variable>
      <Variable Name="Expense">21</Variable>
      <Variable Name="Provider">5</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Feb</Month>
        <Month>Jul</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(30,'Laptop',2016,1,5,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">8</Variable>
      <Variable Name="Cost">10</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Jun</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(31,'Desktop',2016,1,5,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">8</Variable>
      <Variable Name="Cost">10</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Jun</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(32,'Impresor Matricial',2016,1,5,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">8</Variable>
      <Variable Name="Cost">15</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Jun</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(33,'Impresor Tinta',2016,1,5,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">9</Variable>
      <Variable Name="Cost">15</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Jul</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(34,'Impresor Stickers',2016,1,5,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">10</Variable>
      <Variable Name="Cost">25</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Jun</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(35,'Impresor Matricial',2016,1,7,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">9</Variable>
      <Variable Name="MeasurementType">Cartucho</Variable>
      <Variable Name="Cost">14</Variable>
      <Variable Name="ImprintType">Matricial</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Apr</Month>
        <Month>Mar</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Sep</Month>
        <Month>Aug</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(36,'Impresor Tinta',2016,1,7,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">9</Variable>
      <Variable Name="MeasurementType">Cartucho</Variable>
      <Variable Name="Cost">35</Variable>
      <Variable Name="ImprintType">Tinta</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(37,'Impresor Sticker Robin',2016,1,7,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">11</Variable>
      <Variable Name="MeasurementType">Robin</Variable>
      <Variable Name="Cost">12</Variable>
      <Variable Name="ImprintType">Robin</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(38,'Impresor Ticket Cafetería',2016,1,7,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">9</Variable>
      <Variable Name="MeasurementType">Cartucho</Variable>
      <Variable Name="Cost">15</Variable>
      <Variable Name="ImprintType">Ticket Cafetería</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(39,'Impresor Color Administración',2016,1,7,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">12</Variable>
      <Variable Name="MeasurementType">Pagina Impresión</Variable>
      <Variable Name="Cost">0.05</Variable>
      <Variable Name="ImprintType">Color Administración</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Biannual">
        <Month>Jun</Month>
        <Month>Nov</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(40,'Costo por impresión',2016,1,6,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">12</Variable>
      <Variable Name="CopyType">Impresión</Variable>
      <Variable Name="Cost">0.02</Variable>
      <Variable Name="Location" />
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Aug</Month>
        <Month>Jul</Month>
        <Month>Jun</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(41,'Costo por copia',2016,1,6,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Provider">12</Variable>
      <Variable Name="CopyType">Copia</Variable>
      <Variable Name="Cost">0.02</Variable>
      <Variable Name="Location" />
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Nov</Month>
        <Month>Oct</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(42,'Papel de Impresión',2016,1,2,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Name">Papel de Impresión</Variable>
      <Variable Name="Unit">Resma</Variable>
      <Variable Name="Cost">3.05</Variable>
      <Variable Name="Provider">13</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(43,'Cuota Mensual Planta telefonica',2016,1,10,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Expense">625</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

  INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(44,'Enlace de Datos Guatemala - El Salvador',2016,1,11,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Expense">750</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

    INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(45,'Enlace de Internet Claro El Salvador aumento a 20 MB desde Mayo 2014',2016,1,11,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Expense">1260</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')

    INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(46,'Internet Backup Telefonica El Salvador 2MB',2016,1,11,
  '<Premise>
  <Expense>
    <Variables>
      <Variable Name="Expense">250</Variable>
    </Variables>
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')


INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (47,'AMPO CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">AMPO CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.81125</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (48,'ARCHIVADORES DE COMPROBANTES DIARIO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ARCHIVADORES DE COMPROBANTES DIARIO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.414</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (49,'ARCHIVADOR DE ACORDEON 26 x 15 cm plastificado MEDIA CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ARCHIVADOR DE ACORDEON 26 x 15 cm plastificado MEDIA CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.16315</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (50,'BOLIGRAFO BIC AZUL',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOLIGRAFO BIC AZUL</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.1242</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (51,'BOLIGRAFO BIC NEGRO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOLIGRAFO BIC NEGRO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.1242</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (52,'BOLIGRAFO BIC ROJO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOLIGRAFO BIC ROJO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.1242</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (53,'BOLIGRAFOS RETRATIL (AZULES)',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOLIGRAFOS RETRATIL (AZULES)</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.7452</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (54,'BOLIGRAFOS RETRATIL (NEGROS)',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOLIGRAFOS RETRATIL (NEGROS)</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.7452</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (55,'BORRADOR DE CAÑUELA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BORRADOR DE CAÑUELA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.6624</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (56,'BORRADOR DE GOMA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BORRADOR DE GOMA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.15525</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (57,'BORRADOR DE PIZARRA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BORRADOR DE PIZARRA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.67275</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (58,'BOTE DE TINTA AZUL PARA ALMOHADILLA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOTE DE TINTA AZUL PARA ALMOHADILLA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.035</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (59,'CAJA CLIP GRANDE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA CLIP GRANDE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.5382</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (60,'CAJA CLIP PEQUEÑOS ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA CLIP PEQUEÑOS </Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.2277</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (61,' BINDER CLIP GRANDE 2" UND',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name"> BINDER CLIP GRANDE 2" UND</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.2277</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (62,'BINDER CLIP MEDIANO 1 1/2" UND',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BINDER CLIP MEDIANO 1 1/2" UND</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.17595</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (63,'BINDER CLIP PEQUEÑO 1/2" UND',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BINDER CLIP PEQUEÑO 1/2" UND</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.0621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (64,'CAJA DE FASTENER  BACO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA DE FASTENER  BACO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.05965</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (65,'CAJA DE FASTENER ESTANDAR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA DE FASTENER ESTANDAR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.8487</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (66,'CAJA DE GRAPAS BOSTICH',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA DE GRAPAS BOSTICH</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.242</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (67,'CALCULADORA DE BOLSILLO (8 DIGITOS)',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CALCULADORA DE BOLSILLO (8 DIGITOS)</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">3.26025</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (68,'CARTAPACIO 1" CON PRESENTACION BLANCO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CARTAPACIO 1" CON PRESENTACION BLANCO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.6496</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (69,'CARTAPACIO 2" CON PRESENTACION BLANCO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CARTAPACIO 2" CON PRESENTACION BLANCO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">3.69495</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (70,'CARTAPACIO 3" CON PRESENTACION BLANCO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CARTAPACIO 3" CON PRESENTACION BLANCO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">5.5683</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (71,'CINTA 2¨ TRANSPARENTE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CINTA 2¨ TRANSPARENTE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.32085</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (72,'CINTA SCOTCH 600 CAJA ROJA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CINTA SCOTCH 600 CAJA ROJA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.0764</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (73,'CINTA SCOTH MAGICA 810',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CINTA SCOTH MAGICA 810</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.242</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (74,'CORRECTOR TIPO LAPIZ PAPER MATE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CORRECTOR TIPO LAPIZ PAPER MATE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.035</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (75,'CUADERNO # 1 RAYADO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CUADERNO # 1 RAYADO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.7245</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (76,'CUADERNO # 3 RAYADO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CUADERNO # 3 RAYADO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.71415</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (77,'CUADERNO MULTIMATERIA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CUADERNO MULTIMATERIA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">3.3327</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (78,'CUCHILLA GRUESA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CUCHILLA GRUESA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.85905</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (79,'DISPENSADOR DE SCOTH',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">DISPENSADOR DE SCOTH</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.484</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (80,'ENGRAPADORA B515',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ENGRAPADORA B515</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">7.44165</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (81,'FASTENER DE GUSANO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">FASTENER DE GUSANO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.3105</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (82,'FECHADOR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">FECHADOR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.89405</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (83,'FOLDER DE COLORES CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">FOLDER DE COLORES CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.099567</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (84,'FOLDER TAMANO CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">FOLDER TAMANO CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.0439875</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (85,'FOLDERES TAMAÑO OFICIO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">FOLDERES TAMAÑO OFICIO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.0543375</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (86,'HOJAS PROTECTORAS PLASTICAS TAMAÑO CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">HOJAS PROTECTORAS PLASTICAS TAMAÑO CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.05175</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (87,'JUEGOS DE SEPARADORES DE COLORES',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">JUEGOS DE SEPARADORES DE COLORES</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.46575</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (88,'LAPICES MONGOL',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">LAPICES MONGOL</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.17595</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (89,'LAPICEZ BICOLOR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">LAPICEZ BICOLOR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.15525</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (90,'LIBRETA EJECUTIVA TAMAÑO CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">LIBRETA EJECUTIVA TAMAÑO CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.828</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (91,'LIBRETA TAQUIGRAFIA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">LIBRETA TAQUIGRAFIA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.414</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (92,'LIBRO ORDER BOOK',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">LIBRO ORDER BOOK</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.8487</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (93,'PAPELERA ACRILICA DE 3 NIVELES ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PAPELERA ACRILICA DE 3 NIVELES </Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">16.59105</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (94,'PEGAMENTO BARRA 40 GR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PEGAMENTO BARRA 40 GR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.19025</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (95,'PEGAMENTO DE 8 ONZ. LIQUIDO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PEGAMENTO DE 8 ONZ. LIQUIDO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.19025</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (96,'PLUMON ARTLINE 500 AZUL  ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 500 AZUL  </Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.828</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (97,'PLUMON ARTLINE 500 NEGRO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 500 NEGRO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.828</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (98,'PLUMON ARTLINE 500 ROJO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 500 ROJO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.828</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (99,'PLUMON ARTLINE 500 VERDE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 500 VERDE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.828</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (100,'PLUMON ARTLINE 660 AMARILLO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 660 AMARILLO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (101,'PLUMON ARTLINE 660 CELESTE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 660 CELESTE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (102,'PLUMON ARTLINE 660 NARANJA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 660 NARANJA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (103,'PLUMON ARTLINE 660 ROSADO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 660 ROSADO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (104,'PLUMON ARTLINE 660 VERDE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 660 VERDE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (105,'PLUMON ARTLINE 90 AZUL',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 90 AZUL</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (106,'PLUMON ARTLINE 90 NEGRO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 90 NEGRO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (107,'PLUMON ARTLINE 90 ROJO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 90 ROJO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (108,'PLUMON ARTLINE 90 VERDE',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 90 VERDE</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (109,'PLUMON SHARPIE NEGRO ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON SHARPIE NEGRO </Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.21095</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (110,'PLUMON ARTLINE 70',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON ARTLINE 70</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.828</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (111,'PORTAMINAS 0.05',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PORTAMINAS 0.05</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.85905</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (112,'POSTIT 3X3 DE COLORES MARCA STICK',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">POSTIT 3X3 DE COLORES MARCA STICK</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.621</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (113,'POSTIT BANDERITA 680 ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">POSTIT BANDERITA 680 </Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.2977</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (114,'RESMA PAPEL BON CARTA DE COLOR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">RESMA PAPEL BON CARTA DE COLOR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">11.178</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (115,'RESMA PAPEL BOND OFICIO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">RESMA PAPEL BOND OFICIO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">4.91625</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (116,'ROLLO DE ETIQUETAS PARA FOLDER',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ROLLO DE ETIQUETAS PARA FOLDER</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.5175</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (117,'REGLA DE 20 CM',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">REGLA DE 20 CM</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.1242</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (118,'REGLA DE 30 CM',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">REGLA DE 30 CM</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.13455</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (119,'SOBRES MANILA T/CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">SOBRES MANILA T/CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.0439875</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (120,'SOBRES MANILLA T/ OFICIO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">SOBRES MANILLA T/ OFICIO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.056925</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (121,'TACHUELAS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TACHUELAS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.5175</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (122,'TARJETERO 72 UND',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TARJETERO 72 UND</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.53575</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (123,'TIJERA DE 8" ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TIJERA DE 8" </Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.7038</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (124,'TINTA AZUL PARA ALMOHADILLA 2 ONZ',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TINTA AZUL PARA ALMOHADILLA 2 ONZ</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.37655</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (125,'TUBO MINA 0.5',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TUBO MINA 0.5</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.2484</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (126,'YARDAS PLASTICO PARA FORRAR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">YARDAS PLASTICO PARA FORRAR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.3312</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (127,'paquete de hojas para laminar T/C',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">paquete de hojas para laminar T/C</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">30.9258</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (128,'Regla Metalica de 30 CMS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">Regla Metalica de 30 CMS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.6624</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (129,'TABLAS ACRILICAS T/C',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TABLAS ACRILICAS T/C</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">3.4155</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (130,'PLUMON PARA DETECTAR BILLETES FALSOS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PLUMON PARA DETECTAR BILLETES FALSOS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">1.08675</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (131,'CAJA DE CLIPS PEQUEÑOS PLASTIFICADOS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA DE CLIPS PEQUEÑOS PLASTIFICADOS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.3519</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (132,'DISCOS REGRABABLES',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">DISCOS REGRABABLES</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.67275</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (133,'SACAPUNTAS METALICA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">SACAPUNTAS METALICA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.15525</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (134,'TINTA CANON 211 COLOR',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TINTA CANON 211 COLOR</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">22.2525</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (135,'TINTA CANON 210 NEGRA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TINTA CANON 210 NEGRA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">17.33625</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (136,'CARPETAS COLGANTES T/CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CARPETAS COLGANTES T/CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.32085</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (137,'PERFORADOR 3 AGUJEROS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PERFORADOR 3 AGUJEROS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">5.97195</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (138,'CAJA DE GRAPAS BOSTICH DE 3/8',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA DE GRAPAS BOSTICH DE 3/8</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">8.28</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (139,'CAJA DE GRAPAS BOSTITCH DE 1/2',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CAJA DE GRAPAS BOSTITCH DE 1/2</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">9.26325</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (140,'CINTA PARA IMPRESOR MATRICIAL EPSON 590',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CINTA PARA IMPRESOR MATRICIAL EPSON 590</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">12.16125</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (141,'BOLSA MANILA TAMAÑO CARTA',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">BOLSA MANILA TAMAÑO CARTA</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.044505</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (142,'ENGRAPADORA INDUSTRIAL BOSTICH B310',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ENGRAPADORA INDUSTRIAL BOSTICH B310</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">22.77</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (143,'MEMORIA USB DE 8 GB',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">MEMORIA USB DE 8 GB</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">8.0523</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (144,'TECLADO CONEXIÓN USB',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TECLADO CONEXIÓN USB</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">8.53875</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (145,'MONITOR LCD HP 18.5"',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">MONITOR LCD HP 18.5"</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">139.725</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (146,'ALMOHADILLA No.1 AUZL',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ALMOHADILLA No.1 AUZL</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">2.20455</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (147,'POSTIT 1 1/2 X 2 NEON',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">POSTIT 1 1/2 X 2 NEON</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.3933</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (148,'PERFORADOR SEMIINDUSTRIAL MARCA MAE 40 HOJAS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">PERFORADOR SEMIINDUSTRIAL MARCA MAE 40 HOJAS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">8.22825</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (149,'REVISTEROS PLASTICOS',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">REVISTEROS PLASTICOS</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">6.6033</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (150,'TONER 49A P/IMPRESORA HP1320',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TONER 49A P/IMPRESORA HP1320</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">82.2825</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (151,'SOBRE DE MANILA TAMAÑA 10X15',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">SOBRE DE MANILA TAMAÑA 10X15</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.067275</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (152,'TAQUI FINGER CUANTA FACIL',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TAQUI FINGER CUANTA FACIL</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.50715</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (153,'LIBRO DE ACTAS 400 PAG',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">LIBRO DE ACTAS 400 PAG</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">11.7162</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (154,'TELEFONO DE ESCRITORIO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">TELEFONO DE ESCRITORIO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">16.56</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (155,'FUNDAS PARA CARNET',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">FUNDAS PARA CARNET</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.19665</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (156,'SOBRES BLANCOS /OFICIO',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">SOBRES BLANCOS /OFICIO</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">0.016767</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (157,'ORGANIZADOR DE ESCRITORIO 3 DIVISIONES',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">ORGANIZADOR DE ESCRITORIO 3 DIVISIONES</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">26.05095</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (158,'CINTA P/IMPRESOR EPSON FX890',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CINTA P/IMPRESOR EPSON FX890</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">7.73145</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES (159,'CINTAS PARA IMPRESOR MATRICIAL EPSON 590',2016,1,2, '<Premise><Expense><Variables><Variable Name="Name">CINTAS PARA IMPRESOR MATRICIAL EPSON 590</Variable ><Variable Name="Unit">Unidad</Variable ><Variable Name="Cost">12.16125</Variable ><Variable Name="Provider">14</Variable ></Variables ><Constraints ><Constraint Type="Frecuency" Periodicity="Monthly"><Month>Jan</Month><Month>Feb</Month><Month>Mar</Month><Month>Apr</Month><Month>May</Month><Month>Jun</Month><Month>Jul</Month><Month>Aug</Month><Month>Sep</Month><Month>Oct</Month><Month>Nov</Month ><Month>Dec</Month ></Constraint ></Constraints ></Expense></Premise>')
GO

INSERT INTO Premises (Id,Name,FiscalYear,CompanyId,PremiseTypeId,Expenses) VALUES(160,'Horas extras',2016,1,12,
  '<Premise>
  <Expense>    
    <Constraints>
      <Constraint Type="Frecuency" Periodicity="Monthly">
        <Month>Jan</Month>
        <Month>Feb</Month>
        <Month>Mar</Month>
        <Month>Apr</Month>
        <Month>May</Month>
        <Month>Jun</Month>
        <Month>Jul</Month>
        <Month>Aug</Month>
        <Month>Sep</Month>
        <Month>Oct</Month>
        <Month>Nov</Month>
        <Month>Dec</Month>
      </Constraint>
    </Constraints>
  </Expense>
</Premise>')
GO

SET IDENTITY_INSERT Premises OFF
GO

UPDATE Accounts
SET [Type]=case when Code like '5%' then 'P'
	when Code like '6%' then 'M,A'
	else 'F' end
GO
UPDATE CostCenters
SET [Type]=case when Code like 'SV0301%' then 'P'
	when Code like 'SV0302%' then 'M'
	when Code like 'SV0305%' then 'C'
	else 'A' end	
GO

DELETE EmployeeBenefits
GO

DELETE Benefits
GO

SET IDENTITY_INSERT Benefits ON
GO

INSERT Benefits(Id,Name,Code,Target)
VALUES(1,'Bono por resultados 25%','BONO25',2),
	(2,'Bono por resultados 30%','BONO30',2),
	(3,'Bono nocturno','BONONI',2),
	(4,'Consumo cafetería','CCAFET',2)
GO

SET IDENTITY_INSERT Benefits OFF
GO

DELETE AccountBudgetSources
GO

INSERT INTO AccountBudgetSources(Name,Source,Formule,AccountId,ExpenseType,PremiseTypeId)
VALUES('Salarios Planta','Employees','dbo.fn_employeeSalary',2,1,null),
    ('Salarios Manufactura','Employees','dbo.fn_employeeSalary',221,1,null),
	('Salarios Variables Planta','Employees','dbo.fn_employeeVariableSalary',4,1,null),
    ('Salarios Variables Manufactura','Employees','dbo.fn_employeeVariableSalary',223,1,null),
	('Vacaciones Planta','Employees','dbo.fn_employeeHolidays',29,1,null),
	('Vacaciones Manufactura','Employees','dbo.fn_employeeHolidays',248,1,null),
	('Provisiones Planta','Employees','dbo.fn_employeeIndemnityProvision',31,1,null),
	('Provisiones Manufactura','Employees','dbo.fn_employeeIndemnityProvision',250,1,null),
	('Aguinaldo Planta','Employees','dbo.fn_employeeChristmasBonus',27,1,null),
	('Aguinaldo Manufactura','Employees','dbo.fn_employeeChristmasBonus',246,1,null),
	('Bono nocturno Planta','Employees','dbo.fn_employeeNightlyBonus',14,1,null),
	('Bono nocturno Manufactura','Employees','dbo.fn_employeeNightlyBonus',233,1,null),
	('Contribución para el retiro Planta','Employees','dbo.fn_employeeRetirementPlan',24,1,null),
	('Contribución para el retiro Manufactura','Employees','dbo.fn_employeeRetirementPlan',243,1,null),
	('Consumo cafetería Planta','Employees','dbo.fn_employeeMeals',48,1,null),
	('Consumo cafetería Manufactura','Employees','dbo.fn_employeeMeals',267,1,null),
	('Seguro Social Planta','Employees','dbo.fn_employeeSocialSecurity',21,1,null),
	('Seguro Social Manufactura','Employees','dbo.fn_employeeSocialSecurity',240,1,null),
	('Seguro Vida Planta','Employees','dbo.fn_employeeLifeInsurance',74,1,null),
	('Seguro Vida Manufactura','Employees','dbo.fn_employeeLifeInsurance',293,1,null),	
	('Viajes','Employees',null,262,2,1),
	('Equipos de protección','Employees',null,275,2,9),
	('Mantenimiento de Equipo Cómputo','Employees',null,308,2,5),
	('Cintas, Toner o Cartucho para Fotoimpresion','Employees',null,422,2,7),
	('Costo de fotoimpresión',null,null,420,2,6),
	('Papel de impresión',null,null,421,2,2),
	('Telefonía Fija', 'Employees', null, 426, 2, 3),
	('Telefonía Móvil','Employees',null,427,2,4),
	('Reparación y Mantenimiento de Plantas Telefonicas y Telefonos',null,null,428,2,10),
	('Enlaces de Datos',null,null,429,2,11),
	('Horas extras','Employees',null,6,2,12),
	('Horas extras','Employees',null,7,2,12),
	('Horas extras','Employees',null,226,2,12),
	('Horas extras','Employees',null,227,2,12)
GO

if exists(select * from sys.objects where name=N'fn_employeeSalary' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeSalary
go

CREATE function [dbo].[fn_employeeSalary](
 @period datetime,
 @target_id int 
) returns money
as
begin

 declare @salary money, @factor money

 if (select Type from CostCenters c inner join Employees e on c.Id=e.CostCenterId where e.Id=@target_id) = 'P'
  set @factor = 5
 else
  set @factor = 0

 select @salary=Salary + (Salary / 30 * @factor / 12)
 from Employees
 where id=@target_id

 return @salary

end
go

if exists(select * from sys.objects where name=N'fn_employeeVariableSalary' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeVariableSalary
go

create function dbo.fn_employeeVariableSalary(
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	select @salary=isnull(Variable * 1,0)
	from Employees
	where id=@target_id

	return @salary

end
go

if exists(select * from sys.objects where name=N'fn_employeeLifeInsurance' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeLifeInsurance
go

create function dbo.fn_employeeLifeInsurance(
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
go


if exists(select * from sys.objects where name=N'fn_employeeHolidays' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeHolidays
go

create function dbo.fn_employeeHolidays(
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	select @salary=dbo.fn_employeeSalary(@period,@target_id) / 30 * 15 * 0.3 / 12	

	return @salary

end
go

if exists(select * from sys.objects where name=N'fn_employeeIndemnityProvision' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeIndemnityProvision
go

create function dbo.fn_employeeIndemnityProvision(
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
go

if exists(select * from sys.objects where name=N'fn_employeeChristmasBonus' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeChristmasBonus
go

create function dbo.fn_employeeChristmasBonus(
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money

	set @salary=dbo.fn_employeeSalary(@period,@target_id) / 12	

	return @salary

end
go

if exists(select * from sys.objects where name=N'fn_employeeTargetBonus' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeTargetBonus
go

create function dbo.fn_employeeTargetBonus(
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
go

if exists(select * from sys.objects where name=N'fn_employeeNightlyBonus' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeNightlyBonus
go

create function dbo.fn_employeeNightlyBonus(
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
go

if exists(select * from sys.objects where name=N'fn_employeeMeals' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeMeals
go

create function dbo.fn_employeeMeals(
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
go

if exists(select * from sys.objects where name=N'fn_employeeRetirementPlan' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeRetirementPlan
go

create function dbo.fn_employeeRetirementPlan(
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
		set @salary *= 0.0675
	else
		set @salary = 6377.15 * 0.0675

	return @salary

end
go

if exists(select * from sys.objects where name=N'fn_employeeSocialSecurity' and schema_id=SCHEMA_ID(N'dbo') and type=N'FN')
	drop function dbo.fn_employeeSocialSecurity
go

create function dbo.fn_employeeSocialSecurity(
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
	where l.AccountId in (2,222,3,223,4,224,6,7,226,227,14,234,29,249)
		and l.Tag = @target_id
		and d.Month = month(@period)
		and b.FiscalYear = year(@period)
	
	if @salary <= 685.71
		set @salary *= 0.085
	else
		set @salary = 685.71 * 0.085

	return @salary

end
go

if exists(select * from sys.objects where name=N'PeriodsBudgetCalculation' and schema_id=SCHEMA_ID(N'dbo') and type=N'P')
	drop procedure dbo.PeriodsBudgetCalculation
go

if exists(select * from sys.objects where name=N'getConsolidatedBudget' and schema_id=SCHEMA_ID(N'dbo') and type=N'P')
	drop procedure dbo.getConsolidatedBudget
go

create procedure dbo.PeriodsBudgetCalculation
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
go

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
go

if exists(select * from sys.procedures where name='PeopleAllCostCentersCalculation')
	drop procedure dbo.PeopleAllCostCentersCalculation
go

create procedure dbo.PeopleAllCostCentersCalculation
	@companyid int,
	@fiscalyear int,
	@packageid int,
	@accountid int
as
begin
begin try

 set nocount on

 begin tran

	declare @principalaccount int, @accounttype nvarchar(10)

	declare @budgetcostcenter table(
		costcenter int,
		budget int,
		budgetsheet int,
		budgetparent int,
		budgetline int		
	)

	declare @peoplelines table(
		budgetline int,
		employee int
	)

	declare @budgetmonths table(
		budgetmonth int,
		cost money)

	select @principalaccount=ParentId, @accounttype=Type
	from Accounts where id=@accountid

	insert @budgetcostcenter(costcenter)
	select CostCenterId from Employees 
	where Active = 1 and exists(
		select 1 from CostCenters where CostCenterId=Id and CompanyId=@companyid
		 and CHARINDEX(Type,@accounttype) > 0 )
	group by CostCenterId

	insert Budgets(FiscalYear,CostCenterId,CompanyId)
	select @fiscalyear,costcenter,@companyid
	from @budgetcostcenter
	where not exists(
		select 1 from Budgets where FiscalYear=@fiscalyear and CostCenterId=costcenter
	 and CompanyId=@companyid)

	update @budgetcostcenter
	set budget=(select id from Budgets where FiscalYear=@fiscalyear and CostCenterId=costcenter
	 and CompanyId=@companyid)

	insert BudgetSheets(PackageId,BudgetId)
	select @packageid,budget
	from @budgetcostcenter
	where not exists(
		select 1 from BudgetSheets where budgetid=budget and PackageId=@packageid)

	update @budgetcostcenter
	set budgetsheet=(select id from BudgetSheets where BudgetId=budget and PackageId=@packageid)	

	declare @emptysheet int
	while exists(select 1 from @budgetcostcenter where not exists(select 1 from BudgetLines where SheetId=budgetsheet))
	begin

		select top(1) @emptysheet=budgetsheet from @budgetcostcenter
		where not exists(select 1 from BudgetLines where SheetId=budgetsheet)				
		
		insert BudgetLines(SheetId,Description,AccountId)
		select @emptysheet,Name,Id
		from Accounts a inner join PackageAccounts pa
		on a.Id=pa.Account_Id
		where pa.Package_Id=@packageid and a.ParentId is null

		insert BudgetLines(SheetId,Description,AccountId,ParentId)
		select @emptysheet,Name,Id,
			(select Id from BudgetLines where SheetId=@emptysheet and AccountId=a.ParentId)
		from Accounts a inner join PackageAccounts pa
		on a.Id=pa.Account_Id
		where pa.Package_Id=@packageid and a.ParentId is not null

		insert BudgetMonthDetails(LineId,Quantity,UnitCost,Target,Forecast,Real,Month)
		select Id,0,0,0,0,0,Month
		from BudgetLines cross join (
			select 1 Month union select 2 Month union select 3 Month union select 4 Month union
			select 5 Month union select 6 Month union select 7 Month union select 8 Month union
			select 9 Month union select 10 Month union select 11 Month union select 12 Month) t
		where SheetId=@emptysheet

	end	
	
	update @budgetcostcenter
	set budgetline=(select id from BudgetLines where SheetId=budgetsheet and AccountId=@accountid and tag is null),
		budgetparent=(select ParentId from BudgetLines where SheetId=budgetsheet and AccountId=@accountid and tag is null)
	
	delete BudgetLines
	where exists(
		select 1 from @budgetcostcenter
		where SheetId=budgetsheet and AccountId=@accountid and Tag is not null
	)

	insert BudgetLines(SheetId,Description,AccountId,ParentId,Tag)
	select budgetsheet,e.Name,@accountid,t.budgetline,e.Id
	from @budgetcostcenter t inner join Employees e
	on t.costcenter=e.CostCenterId
	where e.Active = 1

	insert @peoplelines
	select Id,Tag
	from BudgetLines
	where exists(
		select 1 from @budgetcostcenter
		where SheetId=budgetsheet and AccountId=@accountid)
	 and Tag is not null

	declare @line int, @id int
	while exists(select 1 from @peoplelines)
	begin

		select top(1) @line=pl.budgetline,@id=pl.employee from @peoplelines pl

		insert @budgetmonths
		exec dbo.PeriodsBudgetCalculation @line, @id

		insert BudgetMonthDetails(LineId,Quantity,UnitCost,Target,Forecast,Real,Month)
		select @line,1,cost,cost,0,0,budgetmonth
		from @budgetmonths

		delete @budgetmonths

		delete @peoplelines where budgetline=@line and employee=@id
	end			

	update BudgetMonthDetails
	set Target=t.target
	from BudgetMonthDetails d inner join (
		select ParentId accountlineid,sum(d.Target) target,Month period
		from BudgetMonthDetails d inner join BudgetLines l
		on d.LineId=l.Id
		where exists(
			select 1 from @budgetcostcenter
			where SheetId=budgetsheet and AccountId=@accountid)
		 and tag is not null
		group by ParentId,Month
	) t
	on d.LineId=t.accountlineid and d.Month=t.period

	update BudgetMonthDetails
	set Target=t.target
	from BudgetMonthDetails d inner join (
		select ParentId accountlineid,sum(d.Target) target,Month period
		from BudgetMonthDetails d inner join BudgetLines l
		on d.LineId=l.Id
		where exists(
			select 1 from @budgetcostcenter where budgetparent=l.ParentId)
		group by ParentId,Month
	) t
	on d.LineId=t.accountlineid and d.Month=t.period

 commit tran
end try
begin catch

	IF @@TRANCOUNT > 0
		ROLLBACK TRAN

	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);


	SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

	RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );
end catch
end
go


if exists(select * from sys.objects where name=N'AOPCalculation' and schema_id=SCHEMA_ID(N'dbo') and type=N'P')
	drop procedure dbo.AOPCalculation
go

create procedure dbo.AOPCalculation
	@fiscalYear int,
	@companyId int,
	@accountId int
as
begin
	set language Spanish
	declare @result table (
			[Type] nvarchar(100),
			[CECO] nvarchar(100),
			[EmployeeId] nvarchar(100),
			[AccountCode] nvarchar(100),
			[Description] nvarchar(200),
			[Position] nvarchar(100),
			[Salary] money,
			[January] money,
			[February] money,
			[March] money,
			[April] money,
			[May] money,
			[June] money,
			[July] money,
			[August] money,
			[September] money,
			[October] money,
			[November] money,
			[December] money,
			[TotalTarget] money,
			[PreviousTarget] money,
			[Dif] money,
			[DifPercentage] money
	)

	declare @accountCode nvarchar(20) = (select code from accounts where Id = @accountId)
	declare @accountIdRoot5 int = '5' + substring(@accountCode, 2, len(@accountCode) - 1)
	declare @accountIdRoot6 int = '6' + substring(@accountCode, 2, len(@accountCode) - 1)

	insert into @result(
			[Type],
			[CECO],
			[EmployeeId],
			[AccountCode],
			[Description],
			[Position],
			[Salary],
			[January],
			[February],
			[March],
			[April],
			[May],
			[June],
			[July],
			[August],
			[September],
			[October],
			[November],
			[December]
	)
	(
	select * from (
		select
			cc.Type [Type],
			cc.Code [CECO],
			bl.Tag [EmployeeId],
			a.Code [Cuenta],
			bl.Description [Description],
			p.Name,
			e.Salary,
			DateName( month , DateAdd( month , bmd.Month , -1 ) ) [Mes],
			bmd.Target [Target]
		from
			CostCenters cc
			inner join Budgets b on b.CostCenterId = cc.Id
			inner join BudgetSheets bs on bs.BudgetId = b.Id
			inner join BudgetLines bl on bl.SheetId = bs.Id
			inner join BudgetMonthDetails bmd on bmd.LineId = bl.Id
			inner join Accounts a on a.Id = bl.AccountId
			inner join Employees e on e.Id = bl.Tag
			inner join Positions p on p.Id = e.PositionId
		where
			b.FiscalYear = @fiscalYear
			and b.CompanyId = @companyId
			and (a.Code = @accountIdRoot5 or a.Code = @accountIdRoot6)
			and bl.Tag is not null
		)
	as Model pivot (Sum(Target) for Mes IN 
		([Enero], [Febrero], [Marzo], [Abril], [Mayo], [Junio], [Julio],
		[Agosto], [Septiembre], [Octubre], [Noviembre], [Diciembre] )) AS Fila
	)
	update
		@result
	set
		TotalTarget = January + February + March + April + May + June + July + August + September + October + November + December,
		PreviousTarget = 0,
		Dif = 0,
		DifPercentage = 0
	select * from @result as [Fila]	for xml auto, root('Filas')
end
go

IF EXISTS(select 1 from sys.procedures where name='StandardLineMigration')
	drop procedure dbo.StandardLineMigration
GO

CREATE PROCEDURE [dbo].[StandardLineMigration]
	@companyid int,
	@fiscalyear int,
	@packageid int,
	@costcentercode nvarchar(20),	
	@accountcode nvarchar(20),
	@description nvarchar(200),
	@qtyjan int,@costjan money,@trgjan money,
	@qtyfeb int,@costfeb money,@trgfeb money,
	@qtymar int,@costmar money,@trgmar money,
	@qtyapr int,@costapr money,@trgapr money,
	@qtymay int,@costmay money,@trgmay money,
	@qtyjun int,@costjun money,@trgjun money,
	@qtyjul int,@costjul money,@trgjul money,
	@qtyaug int,@costaug money,@trgaug money,
	@qtysep int,@costsep money,@trgsep money,
	@qtyoct int,@costoct money,@trgoct money,
	@qtynov int,@costnov money,@trgnov money,
	@qtydec int,@costdec money,@trgdec money
as
begin

BEGIN TRY

 SET NOCOUNT ON

 BEGIN TRAN

	SET NOCOUNT ON

	declare @budget int, @budgetsheet int, @budgetparentline int, 
		@costcenterid int, @accountid int, @budgetline int

	select @costcenterid=id from CostCenters where Code=@costcentercode

	select @accountid=id from Accounts where Code=@accountcode

	select @budget=Id from Budgets 
	where CompanyId=@companyid and FiscalYear=@fiscalyear and CostCenterId=@costcenterid
	
	select @budgetsheet=Id from BudgetSheets
	where BudgetId=@budget and PackageId=@packageid

	select @budgetparentline=Id from BudgetLines
	where SheetId=@budgetsheet and AccountId=@accountid and Tag is null

	insert BudgetLines(SheetId,Description,ParentId,AccountId,Tag)
	values(@budgetsheet,@description,@budgetparentline,@accountid,0)

	set @budgetline=@@IDENTITY

	insert BudgetMonthDetails(LineId,Month,Quantity,UnitCost,Target,Real,Forecast)
	values(@budgetline,1,@qtyjan,@costjan,@trgjan,0,0),
		(@budgetline,2,@qtyfeb,@costfeb,@trgfeb,0,0),
		(@budgetline,3,@qtymar,@costmar,@trgmar,0,0),
		(@budgetline,4,@qtyapr,@costapr,@trgapr,0,0),
		(@budgetline,5,@qtymay,@costmay,@trgmay,0,0),
		(@budgetline,6,@qtyjun,@costjun,@trgjun,0,0),
		(@budgetline,7,@qtyjul,@costjul,@trgjul,0,0),
		(@budgetline,8,@qtyaug,@costaug,@trgaug,0,0),
		(@budgetline,9,@qtysep,@costsep,@trgsep,0,0),
		(@budgetline,10,@qtyoct,@costoct,@trgoct,0,0),
		(@budgetline,11,@qtynov,@costnov,@trgnov,0,0),
		(@budgetline,12,@qtydec,@costdec,@trgdec,0,0)

 COMMIT TRAN
END TRY
BEGIN CATCH

	IF @@TRANCOUNT > 0
		ROLLBACK TRAN

	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);


	SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

	RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );

END CATCH		
end
go

IF EXISTS(select 1 from sys.procedures where name='StandardAccountMigration')
	drop procedure dbo.StandardAccountMigration
GO

CREATE PROCEDURE dbo.StandardAccountMigration
	@companyid int,
	@fiscalyear int,	
	@costcentercode nvarchar(20),	
	@accountcode nvarchar(20),	
	@trgjan money,
	@trgfeb money,
	@trgmar money,
	@trgapr money,
	@trgmay money,
	@trgjun money,
	@trgjul money,
	@trgaug money,
	@trgsep money,
	@trgoct money,
	@trgnov money,
	@trgdec money
as
begin

BEGIN TRY

 SET NOCOUNT ON

 BEGIN TRAN

	SET NOCOUNT ON

	declare @budget int, @budgetsheet int, @budgetparentline int, 
		@costcenterid int, @accountid int, @budgetline int, @packageid int

	select @costcenterid=id from CostCenters where Code=@costcentercode

	select @accountid=id from Accounts where Code=@accountcode

	if @accountid is null
		raiserror('El código %s no coincide con ninguna cuenta contable',16,1, @accountcode)

	select @budget=Id from Budgets 
	where CompanyId=@companyid and FiscalYear=@fiscalyear and CostCenterId=@costcenterid

	declare @appearances int

	select @appearances=count(1) from PackageAccounts pa 
	where exists(
		select 1 from Accounts a
		where a.Code=@accountcode and a.Id=pa.Account_Id)

	if isnull(@appearances,0) = 0
		raiserror('La cuenta contable %s no esta asociada a ningún paquete', 16, 1, @accountcode)

	if @appearances > 1
		raiserror('La cuenta contable %s esta asociada a más de un paquete', 16, 1, @accountcode)
	
	select @packageid=pa.Package_Id from PackageAccounts pa
	where exists(
		select 1 from Accounts a
		where a.Code=@accountcode and a.Id=pa.Account_Id)

	select @budgetsheet=Id from BudgetSheets
	where BudgetId=@budget and PackageId=@packageid

	select @budgetline=Id from BudgetLines
	where SheetId=@budgetsheet and AccountId=@accountid and Tag is null	

	update BudgetMonthDetails
	SET Target=CASE Month
		WHEN 1 THEN @trgjan
		WHEN 2 THEN @trgfeb
		WHEN 3 THEN @trgmar
		WHEN 4 THEN @trgapr
		WHEN 5 THEN @trgmay
		WHEN 6 THEN @trgjun
		WHEN 7 THEN @trgjul
		WHEN 8 THEN @trgaug
		WHEN 9 THEN @trgsep
		WHEN 10 THEN @trgoct
		WHEN 11 THEN @trgnov
		WHEN 12 THEN @trgdec
	END	
	WHERE LineId=@budgetline

 COMMIT TRAN
END TRY
BEGIN CATCH

	IF @@TRANCOUNT > 0
		ROLLBACK TRAN

	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);


	SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

	RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );

END CATCH		
end
go


IF EXISTS(select 1 from sys.procedures where name='StandardParentLineCalculation')
	drop procedure dbo.StandardParentLineCalculation
GO

CREATE PROCEDURE dbo.StandardParentLineCalculation
	@companyid int,
	@fiscalyear int,
	@costcentercode nvarchar(20),
	@packageid int = 0,
	@includechildrenaccounts bit = 0
AS
BEGIN

BEGIN TRY

 SET NOCOUNT ON

 BEGIN TRAN

	DECLARE @budget int, @costcenterid int, @sheetid int

	DECLARE @sheets TABLE (
		sheet int)

	DECLARE @summary TABLE(
		line int,
		parentid int
	)

	IF @packageid is null
		SET @packageid = 0

	SELECT @costcenterid=Id FROM CostCenters
	WHERE Code=@costcentercode

	SELECT @budget=Id FROM Budgets 
	WHERE CompanyId=@companyid and FiscalYear=@fiscalyear and CostCenterId=@costcenterid
	
	INSERT @sheets
	SELECT Id FROM BudgetSheets
	WHERE BudgetId=@budget and (PackageId=@packageid or @packageid=0)	
		
	WHILE exists(select * from @sheets)
	BEGIN

		SELECT top(1) @sheetid=sheet FROM @sheets

		INSERT @summary(line,parentid)
		SELECT Id,ParentId FROM BudgetLines
		WHERE SheetId = @sheetid and ParentId is not null and Tag is null

		IF @includechildrenaccounts = 1
			UPDATE BudgetMonthDetails
			SET Target=(
				SELECT SUM(Target) FROM BudgetMonthDetails d2 inner join BudgetLines l
				ON d2.LineId=l.Id WHERE l.ParentId=d.LineId and d2.Month=d.Month)
			FROM BudgetMonthDetails d
			WHERE exists(
				SELECT 1 FROM @summary
				WHERE line=LineId)		
		
		UPDATE BudgetMonthDetails
		SET Target=(
			SELECT SUM(Target) FROM BudgetMonthDetails d2 inner join BudgetLines l
			ON d2.LineId=l.Id WHERE l.ParentId=d.LineId and d2.Month=d.Month)
		FROM BudgetMonthDetails d
		WHERE exists(
			SELECT 1 FROM @summary
			WHERE parentid=LineId)		

		DELETE @summary		

		DELETE @sheets where sheet=@sheetid
	END

 COMMIT TRAN
END TRY
BEGIN CATCH

	IF @@TRANCOUNT > 0
		ROLLBACK TRAN

	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);


	SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

	RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );

END CATCH
	
END
GO

if exists(select * from sys.objects where name=N'GenerateBudgetSheets' and schema_id=SCHEMA_ID(N'dbo') and type=N'P')
	drop procedure dbo.GenerateBudgetSheets
go

create procedure [dbo].[GenerateBudgetSheets]
	@fiscalYear int,
	@companyId int,
	@costCenterCode varchar(20)
as
begin

	BEGIN TRY
		BEGIN TRAN

			SET NOCOUNT ON

			declare @costCenterId int = (select Id from CostCenters where Code = @costCenterCode)

			if @costCenterId is null begin
				RAISERROR ('El centro de costo %s no existe', 1, 16, @costCenterCode);
			end
			else begin

				declare @budgetId int = (select Id from Budgets b where b.FiscalYear = @fiscalYear and b.CompanyId = @companyId and b.CostCenterId = @costCenterId)

				if @budgetId is null begin
					insert Budgets(CompanyId,FiscalYear,CostCenterId) values(@companyId,@fiscalYear,@costCenterId)
					set @budgetId = SCOPE_IDENTITY()
				end

				declare @packages table (Id int, Name varchar(50))
				insert @packages select p.Id, p.Name from Packages p
				declare @packagesCount int = (select count(*) from @packages)

				declare @packageId int
				declare @packageName varchar(50)
				declare @budgetSheetId int
	
				declare @parentAccounts table (Id int, Code varchar(50), Name varchar(100))
				declare @parentAccountsCount int

				declare @childAccounts table (Id int, Code varchar(50), Name varchar(100))
				declare @childAccountsCount int

				declare @parentAccountId int
				declare @parentAccountCode varchar(50)
				declare @parentAccountName varchar(100)

				declare @childAccountId int
				declare @childAccountCode varchar(50)
				declare @childAccountName varchar(100)

				declare @parentLineId int
				declare @childLineId int
				declare @monthDetailsCounter int

				while @packagesCount > 0 begin
		
					set @packageId = (select top(1) Id from @packages)
					set @packageName = (select top(1) Name from @packages)
					set @budgetSheetId = null
					set @budgetSheetId = (select Id from BudgetSheets bs where bs.BudgetId = @budgetId and bs.PackageId = @packageId)
		
					if @budgetSheetId is null begin

						insert BudgetSheets(BudgetId,PackageId) values (@budgetId,@packageId)
						set @budgetSheetId = SCOPE_IDENTITY()

						insert @parentAccounts (Id,Code,Name)
							select pa.Account_Id, a.Code, a.Name
							from PackageAccounts pa inner join Accounts a on a.Id = pa.Account_Id
							where a.ParentId is null and pa.Package_Id = @packageId

						set @parentAccountsCount = (select count(*) from @parentAccounts)

						while @parentAccountsCount > 0 begin
				
							set @parentAccountId = (select top(1) Id from @parentAccounts)
							set @parentAccountCode = (select top(1) Code from @parentAccounts)
							set @parentAccountName = (select top(1) Name from @parentAccounts)

							insert BudgetLines (AccountId,ParentId,PremiseId,SheetId,Tag,[Description])
							values (@parentAccountId,null,null,@budgetSheetId,null,@parentAccountCode + ' - ' + @parentAccountName)
				
							set @parentLineId = SCOPE_IDENTITY()
							set @monthDetailsCounter = 1

							while @monthDetailsCounter < 13 begin
					
								insert BudgetMonthDetails([LineId],[Month],[Quantity],[Real],[Target],[UnitCost],[Forecast])
								values (@parentLineId,@monthDetailsCounter,0,0,0,0,0)
								set @monthDetailsCounter += 1
							end

							insert @childAccounts (Id,Code,Name) select Id,Code,Name from Accounts where ParentId = @parentAccountId
							set @childAccountsCount = (select count(*) from @childAccounts)

							while @childAccountsCount > 0 begin
					
								set @childAccountId = (select top(1) Id from @childAccounts)
								set @childAccountCode = (select top(1) Code from @childAccounts)
								set @childAccountName = (select top(1) Name from @childAccounts)

								insert BudgetLines (AccountId,ParentId,PremiseId,SheetId,Tag,[Description])
								values (@childAccountId,@parentLineId,null,@budgetSheetId,null,@childAccountCode + ' - ' + @childAccountName)
				
								set @childLineId = SCOPE_IDENTITY()
								set @monthDetailsCounter = 1

								while @monthDetailsCounter < 13 begin
					
									insert BudgetMonthDetails([LineId],[Month],[Quantity],[Real],[Target],[UnitCost],[Forecast])
									values (@childLineId,@monthDetailsCounter,0,0,0,0,0)
									set @monthDetailsCounter += 1
								end

								set @childAccountsCount -= 1
								delete from @childAccounts where Id = @childAccountId
							end

							set @parentAccountsCount -= 1
							delete from @parentAccounts where Id = @parentAccountId
						end
					end

					set @packagesCount -= 1
					delete from @packages where Id = @packageId
				end
			end
		COMMIT TRAN
	END TRY

	BEGIN CATCH

		IF @@TRANCOUNT > 0
			ROLLBACK TRAN

		DECLARE 
			@ErrorMessage    NVARCHAR(4000),
			@ErrorNumber     INT,
			@ErrorSeverity   INT,
			@ErrorState      INT,
			@ErrorLine       INT,
			@ErrorProcedure  NVARCHAR(200);


		SELECT 
			@ErrorNumber = ERROR_NUMBER(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@ErrorLine = ERROR_LINE(),
			@ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');
			SELECT @ErrorMessage = N'Error %d, Level %d, State %d, Procedure %s, Line %d, Message: '+ ERROR_MESSAGE();

		RAISERROR 
			(
			@ErrorMessage, 
			@ErrorSeverity, 
			1,               
			@ErrorNumber,    -- parameter: original error number.
			@ErrorSeverity,  -- parameter: original error severity.
			@ErrorState,     -- parameter: original error state.
			@ErrorProcedure, -- parameter: original error procedure name.
			@ErrorLine       -- parameter: original error line number.
			);

	END CATCH
end
GO

SET IDENTITY_INSERT Benefits ON
GO
INSERT Benefits(Id,Name,Target,Code,Value) VALUES(5,'Presupuesta 7mo',2,'SAL7M',1)
INSERT Benefits(Id,Name,Target,Code,Value) VALUES(4,'Seguro médico 1',2,'BNOCT',1)
INSERT Benefits(Id,Name,Target,Code,Value) VALUES(1,'Seguro médico 1',2,'SMED1',10.68)
INSERT Benefits(Id,Name,Target,Code,Value) VALUES(2,'Seguro médico 2',2,'SMED2',49.43)
INSERT Benefits(Id,Name,Target,Code,Value) VALUES(3,'Seguro médico 3',2,'SMED3',106.81)
GO
SET IDENTITY_INSERT Benefits OFF
GO


CREATE function [dbo].[fn_employeeMedicalSecurity](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money	

	select @salary = Value from Benefits b inner join EmployeeBenefits eb 
	on b.Id = eb.Benefit_Id where Employee_Id=@target_id and Code in ('SMED1','SMED2','SMED3')				

	return isnull(@salary,0)

end
GO

INSERT AccountBudgetSources(Name,Source,Formule,AccountId,ExpenseType)
VALUES ('Seguro médico planta','Employee','dbo.fn_employeeMedicalSecurity',75,1),
 ('Seguro médico manufactura','Employee','dbo.fn_employeeMedicalSecurity',294,1)
GO

/****** Object:  UserDefinedFunction [dbo].[fn_employeeNightlyBonus]    Script Date: 8/2/2016 11:29:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[fn_employeeNightlyBonus](
	@period datetime,
	@target_id int	
) returns money
as
begin

	declare @salary money
	
	if exists(select 1 from Benefits b inner join EmployeeBenefits eb on b.Id = eb.Benefit_Id where Employee_Id=@target_id and Code='BNOCT')
		set @salary= dbo.fn_employeeSalary(@period,@target_id) / 30 / 7 * 11 * 0.25 * 15 / 2
	else
		set @salary = 0
	
	return @salary

end
GO

--exec GenerateBudgetSheets 2016, 1, 'SV03010101'
--exec GenerateBudgetSheets 2016, 1, 'SV03010102'
--exec GenerateBudgetSheets 2016, 1, 'SV03010103'
--exec GenerateBudgetSheets 2016, 1, 'SV03010104'
--exec GenerateBudgetSheets 2016, 1, 'SV03010105'
--exec GenerateBudgetSheets 2016, 1, 'SV03010106'
--exec GenerateBudgetSheets 2016, 1, 'SV03010107'
--exec GenerateBudgetSheets 2016, 1, 'SV03010108'
--exec GenerateBudgetSheets 2016, 1, 'SV03010109'
--exec GenerateBudgetSheets 2016, 1, 'SV03010110'
--exec GenerateBudgetSheets 2016, 1, 'SV03010111'
--exec GenerateBudgetSheets 2016, 1, 'SV03010112'
--exec GenerateBudgetSheets 2016, 1, 'SV03010113'
--exec GenerateBudgetSheets 2016, 1, 'SV03010115'
--exec GenerateBudgetSheets 2016, 1, 'SV03010152'
--exec GenerateBudgetSheets 2016, 1, 'SV03010153'
--exec GenerateBudgetSheets 2016, 1, 'SV03010154'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015403'
--exec GenerateBudgetSheets 2016, 1, 'SV03010155'
--exec GenerateBudgetSheets 2016, 1, 'SV03010156'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015604'
--exec GenerateBudgetSheets 2016, 1, 'SV03010157'
--exec GenerateBudgetSheets 2016, 1, 'SV03010160'
--exec GenerateBudgetSheets 2016, 1, 'SV03010161'
--exec GenerateBudgetSheets 2016, 1, 'SV03011101'
--exec GenerateBudgetSheets 2016, 1, 'SV03020101'
--exec GenerateBudgetSheets 2016, 1, 'SV03020102'
--exec GenerateBudgetSheets 2016, 1, 'SV03020103'
--exec GenerateBudgetSheets 2016, 1, 'SV03020105'
--exec GenerateBudgetSheets 2016, 1, 'SV03020106'
--exec GenerateBudgetSheets 2016, 1, 'SV03020107'
--exec GenerateBudgetSheets 2016, 1, 'SV03020108'
--exec GenerateBudgetSheets 2016, 1, 'SV03020109'
--exec GenerateBudgetSheets 2016, 1, 'SV03020111'
--exec GenerateBudgetSheets 2016, 1, 'SV03020113'
--exec GenerateBudgetSheets 2016, 1, 'SV03020115'
--exec GenerateBudgetSheets 2016, 1, 'SV03020152'
--exec GenerateBudgetSheets 2016, 1, 'SV03020153'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015403'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015604'
--exec GenerateBudgetSheets 2016, 1, 'SV03020159'
--exec GenerateBudgetSheets 2016, 1, 'SV03020160'
--exec GenerateBudgetSheets 2016, 1, 'SV03020161'
--exec GenerateBudgetSheets 2016, 1, 'SV03021101'
--exec GenerateBudgetSheets 2016, 1, 'SV03023103'
--exec GenerateBudgetSheets 2016, 1, 'SV03030101'
--exec GenerateBudgetSheets 2016, 1, 'SV03030104'
--exec GenerateBudgetSheets 2016, 1, 'SV03040304'
--exec GenerateBudgetSheets 2016, 1, 'SV03050301'
--exec GenerateBudgetSheets 2016, 1, 'SV03060101'
--exec GenerateBudgetSheets 2016, 1, 'SV03060102'
--exec GenerateBudgetSheets 2016, 1, 'SV03060103'
--exec GenerateBudgetSheets 2016, 1, 'SV03060104'
--exec GenerateBudgetSheets 2016, 1, 'SV03060105'
--exec GenerateBudgetSheets 2016, 1, 'SV03060106'
--exec GenerateBudgetSheets 2016, 1, 'SV03070103'
--exec GenerateBudgetSheets 2016, 1, 'SV03100101'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015401'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015402'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015501'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015502'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015503'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015504'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015601'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015602'
--exec GenerateBudgetSheets 2016, 1, 'SV0301015603'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015401'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015402'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015501'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015502'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015503'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015504'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015601'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015602'
--exec GenerateBudgetSheets 2016, 1, 'SV0302015603'
--exec GenerateBudgetSheets 2016, 1, 'SV0305020919'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010201'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010202'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010101'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010102'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010103'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010104'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010105'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010106'
--exec GenerateBudgetSheets 2016, 1, 'SV0306010203'
--exec GenerateBudgetSheets 2016, 1, 'SV0306011401'
--exec GenerateBudgetSheets 2016, 1, 'SV0306011402'





---- PARENT LINE CALCULATION

--exec StandardParentLineCalculation 2016, 1, 'SV03010101'
--exec StandardParentLineCalculation 2016, 1, 'SV03010102'
--exec StandardParentLineCalculation 2016, 1, 'SV03010103'
--exec StandardParentLineCalculation 2016, 1, 'SV03010104'
--exec StandardParentLineCalculation 2016, 1, 'SV03010105'
--exec StandardParentLineCalculation 2016, 1, 'SV03010106'
--exec StandardParentLineCalculation 2016, 1, 'SV03010107'
--exec StandardParentLineCalculation 2016, 1, 'SV03010108'
--exec StandardParentLineCalculation 2016, 1, 'SV03010109'
--exec StandardParentLineCalculation 2016, 1, 'SV03010110'
--exec StandardParentLineCalculation 2016, 1, 'SV03010111'
--exec StandardParentLineCalculation 2016, 1, 'SV03010112'
--exec StandardParentLineCalculation 2016, 1, 'SV03010113'
--exec StandardParentLineCalculation 2016, 1, 'SV03010114'
--exec StandardParentLineCalculation 2016, 1, 'SV03010115'
--exec StandardParentLineCalculation 2016, 1, 'SV03010152'
--exec StandardParentLineCalculation 2016, 1, 'SV03010153'
--exec StandardParentLineCalculation 2016, 1, 'SV03010154'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015403'
--exec StandardParentLineCalculation 2016, 1, 'SV03010155'
--exec StandardParentLineCalculation 2016, 1, 'SV03010156'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015604'
--exec StandardParentLineCalculation 2016, 1, 'SV03010157'
--exec StandardParentLineCalculation 2016, 1, 'SV03010160'
--exec StandardParentLineCalculation 2016, 1, 'SV03010161'
--exec StandardParentLineCalculation 2016, 1, 'SV03011101'
--exec StandardParentLineCalculation 2016, 1, 'SV03020101'
--exec StandardParentLineCalculation 2016, 1, 'SV03020102'
--exec StandardParentLineCalculation 2016, 1, 'SV03020103'
--exec StandardParentLineCalculation 2016, 1, 'SV03020105'
--exec StandardParentLineCalculation 2016, 1, 'SV03020106'
--exec StandardParentLineCalculation 2016, 1, 'SV03020107'
--exec StandardParentLineCalculation 2016, 1, 'SV03020108'
--exec StandardParentLineCalculation 2016, 1, 'SV03020109'
--exec StandardParentLineCalculation 2016, 1, 'SV03020111'
--exec StandardParentLineCalculation 2016, 1, 'SV03020113'
--exec StandardParentLineCalculation 2016, 1, 'SV03020115'
--exec StandardParentLineCalculation 2016, 1, 'SV03020152'
--exec StandardParentLineCalculation 2016, 1, 'SV03020153'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015403'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015604'
--exec StandardParentLineCalculation 2016, 1, 'SV03020159'
--exec StandardParentLineCalculation 2016, 1, 'SV03020160'
--exec StandardParentLineCalculation 2016, 1, 'SV03020161'
--exec StandardParentLineCalculation 2016, 1, 'SV03021101'
--exec StandardParentLineCalculation 2016, 1, 'SV03023102'
--exec StandardParentLineCalculation 2016, 1, 'SV03023103'
--exec StandardParentLineCalculation 2016, 1, 'SV03030101'
--exec StandardParentLineCalculation 2016, 1, 'SV03030104'
--exec StandardParentLineCalculation 2016, 1, 'SV03040304'
--exec StandardParentLineCalculation 2016, 1, 'SV03050301'
--exec StandardParentLineCalculation 2016, 1, 'SV03060101'
--exec StandardParentLineCalculation 2016, 1, 'SV03060102'
--exec StandardParentLineCalculation 2016, 1, 'SV03060103'
--exec StandardParentLineCalculation 2016, 1, 'SV03060104'
--exec StandardParentLineCalculation 2016, 1, 'SV03060105'
--exec StandardParentLineCalculation 2016, 1, 'SV03060106'
--exec StandardParentLineCalculation 2016, 1, 'SV03070103'
--exec StandardParentLineCalculation 2016, 1, 'SV03100101'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015401'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015402'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015501'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015502'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015503'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015504'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015601'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015602'
--exec StandardParentLineCalculation 2016, 1, 'SV0301015603'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015401'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015402'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015501'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015502'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015503'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015504'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015601'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015602'
--exec StandardParentLineCalculation 2016, 1, 'SV0302015603'
--exec StandardParentLineCalculation 2016, 1, 'SV0305020919'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010201'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010202'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010101'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010102'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010103'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010104'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010105'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010106'
--exec StandardParentLineCalculation 2016, 1, 'SV0306010203'
--exec StandardParentLineCalculation 2016, 1, 'SV0306011401'
--exec StandardParentLineCalculation 2016, 1, 'SV0306011402'
