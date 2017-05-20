USE Spres
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
	('Seguro Vida Manufactura','Employees','dbo.fn_employeeLifeInsurance',293,1,null)
GO

INSERT INTO AccountBudgetSources(Name,Source,Formule,AccountId,ExpenseType,PremiseTypeId)	
VALUES('Viajes','Employees',null,261,2,1),
	('Equipos de protección','Employees',null,274,2,9),
	('Mantenimiento de Equipo Cómputo','Employees',null,307,2,5),
	('Cintas, Toner o Cartucho para Fotoimpresion','Employees',null,420,2,7),
	('Costo de fotoimpresión',null,null,418,2,6),
	('Papel de impresión',null,null,419,2,2),
	('Telefonía Fija', 'Employees', null, 424, 2, 3),
	('Telefonía Móvil','Employees',null,425,2,4),
	('Reparación y Mantenimiento de Plantas Telefonicas y Telefonos',null,null,426,2,10),
	('Enlaces de Datos',null,null,427,2,11),
	('Horas extras','Employees',null,6,2,12),
	('Horas extras','Employees',null,7,2,12),
	('Horas extras','Employees',null,225,2,12),
	('Horas extras','Employees',null,226,2,12)
GO