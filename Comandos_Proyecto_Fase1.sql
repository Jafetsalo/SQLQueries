Declare @palabra varchar (70)
Set @palabra = 'Entschuldigung'
Print @palabra 

-- #FASE UNO PROYECTO

/*Autor: Jafet Salom�n Valencia Ospina*/

/*Turnos en una sala de computadoras*/

/*Crear Base de datos que permita registrar el acceso f�sico a una sala de computadoras 
con racks de servidores por los usuarios de acuerdo a su rol y su nivel de acceso. Entonces, se debe poder 
averiguar qui�n ingresa, cu�ndo lo hace, a qu� tiene acceso. As�mismo, clasificar grupos de servidores de acuerdo a su funci�n
y poder registrar quien les hace mantenimiento e informaci�n sobre estos registros hasta el nivel de m�dulos en una torre*/

/*
1. Cu�l es el nivel de acceso de cada miembro
2. Cu�ndo ingres� por �ltima vez un usuario 
3. A qu� �rea o grupo de trabajo pertenece un m�dulo  (Finanzas, N�mina, Clientes externos, Sistemas y soporte, ingenier�as)
4. Cu�ndo y qui�n realiza el �ltimo mantenimiento de un m�dulo
5. Cu�l es la funci�n de un m�dulo en particular, y si est� en l�nea o desconectado
6. Conocer la ubicaci�n de un m�dulo
7. Cu�l es el rol y en cu�l �rea est� inscrito un usuario
*/

/*

Entidades:
RackServidor (Grupos de M�dulos que representan un solo sistema en funcionamiento para una tarea)
Modulo (Una unidad individual de procesamiento, almacenamiento, computaci�n, y/o telecomunicaci�n dentro de un rack)
AreaEmpresa (Secci�n funcional de una compa��a encargada de un grupo de actividades especializadas)
Usuario (Persona registrada con capacidades y asignaciones dentro del sistema)
AreaDeUsuario (Tabla intermedia entre Area y Usuario por relaci�n muchos a muchos. Un usuario pertenece a veces muchas �reas)
RolDeUsuario (Tabla intermedia para cargo o rol del usuario. Una entidad d�bil porque un usuario puede tener varios cargos en la misma compa��a)
Rol (Descripci�n del cargo o rol contratado)
AccesoUsuarioRack (Tabla intermedia entre Usuario y Rack para describir a qu� unidades tiene acceso qu� usuario)
TipoModulo (Entidad fuerte que representa la funci�n o funciones de un m�dulo)
AsignacionMantenimiento (Describe cu�les unidades de un rack ser�n mantenidas por cu�l usuario bajo qu� orden)
Mantenimiento (Actividad programada para extender, mejorar, reparar, inspeccionar o reemplazar)

Propiedades de estas entidades
.RackServidor (PK Cod_Server, Marca, Funcion, Ano_Instalacion, Fecha_Mantenimiento, FK Cod_AreaEmp, Peso)
.Modulo (PK Cod_System, Fabricante, Estado, Consumo_KW, A�o_fabricaci�n, SistemaOperativo, FK Cod_Server, IP_System, FK Cod_TipoModulo, FK Cod_Server)
.AreaEmpresa (PK Cod_AreaEmp, Nombre, Presupuesto, Direcci�n)
.Usuario (PK Id_Usuario, Nombre, Tel�fono, Direcci�n, Correo_Electr�nico)
.RolEnAreaDeUsuario (PK(Id_Usuario, Cod_AreaEmp, Cod_Rol), A�o_Vinculaci�n, Estado, FK ID_Usuario, FK Cor_AreaEmp, FK Cod_Rol)
.Rol (PK Cod_Rol, Titulo, Salario, Descripci�n)
.AccesoUsuarioRack (PK (ID_Usuario, Cod_Server, FechaInicio, FechaFin), FK ID_AdministradorACargo, FK Cod_Server, FK ID_Usuario)
.TipoModulo (PK Cod_TipoModulo, Denominaci�n, Capacidad_Almacenamiento, Capacidad_Procesamiento, Capacidad_Transferencia_Red)
.AsignacionMantenimiento (PK(Cod_Mantenimiento, Cod_Server, Cod_Usuario), FechaInicio, FechaFin, Tarea, FK Cod_Mantenimiento, FK Cod_Server, FK Cod_Usuario)
.Mantenimiento (PK Cod_Mantenimiento, Tipo, Presupuesto, Descripci�n, FK ID_AdministradorACargo)

Listo vamos a escribir L�neas create Table
*/

Create DATABASE DBServidor
GO
USE DBServidor

Create Table AreaEmpresa
(
Cod_AreaEmp int identity (1,1), 
Nombre Varchar (90), 
Presupuesto float, 
Direcci�n Varchar (50)
Primary Key (Cod_AreaEmp)
)

Insert into AreaEmpresa Values
('Log�stica y transporte',950000,'2502 Harvey St
La Crosse, Wisconsin(WI), 54603'),
('Ingenier�a y desarrollo',1500000,'9285 Windmill Pt
Frisco, Texas(TX), 75034'),
('Ejecutiva y direcci�n',350000,'3845 Plank St 536
Euless, Texas(TX), 76040'),
('Dise�o y producci�n',670000,'808 Carol
Bellaire, Texas(TX), 77401'),
('Salud y bienestar',78000,'4900 Holt St
Bellaire, Texas(TX), 77401'),
('Legal',101700,'4424 Darsey St
Bellaire, Texas(TX), 77401'),
('Comercio y relaciones', 100000, '16400 Nikki Ln
Odessa, Florida(FL), 33556'),
('Marketing',200000, '26660 Tungsten Rd APT 105
Euclid, Ohio(OH), 44132'),
('Finanzas y contable',15000,'9299 S 490th Rd
Miami, Oklahoma(OK), 74354'),
('Recursos Humanos',70000,'13240 Sanford Ave
Flushing, New York(NY), 11355')



Create Table TipoModulo 
(Cod_TipoModulo Int identity (10,1000), 
Denominaci�n Varchar(50),
Capacidad_Almacenamiento Int, 
Capacidad_Procesamiento Int, 
Capacidad_Transferencia_Red Int, 
Primary Key (Cod_TipoModulo)
)

Insert into TipoModulo Values
('Switch Red',0.3,2,200),
('Modem Red',0.5,2,500),
('Procesador Gr�fico',1,1500,10),
('Almacenamiento',25000,10,10),
('C�lculo y simulaci�n',2,3800,10),
('El�ctrico',0,0,0),
('Procesador General',40,910,20),
('Procesador IA',500,4500,20),
('Procesador de Datos',1800,800,150),
('Entrada y Salida I/O',0.9,20,300)


Create Table Rol 
(
Cod_Rol Int identity (5,11), 
Titulo Varchar (45), 
SalarioHora float, 
Descripci�n Text,
Primary Key (Cod_Rol)
)

Insert into Rol Values 
('CNC Programmer',2521,''),
('Data Analyst',4520,''),
('Digital Marketing Analyst',1800,''),
('MARKETING TECHNOLOGIST',2100,''),
('Payroll Coordinator',1900,''),
('Human Resource Information Specialist',1400,''),
('Human Resource Officer',1250,''),
('C# Sr Developer',6000,''),
('Blockchain Developer',8500,''),
('Cloud engineer',7000,''),
('Facilities Engineer',3950,''),
('Logistics Engineer',4200,''),
('Paralegal Analyst',1820,''),
('Specialist Tech Sales Executive',4500,''),
('Database Administrator',3900,''),
('Network CyberSecurity Engineer',11000,'')


Create Table Usuario 
(
Id_Usuario Int identity (10,101), 
Nombre Varchar (50), 
Tel�fono Varchar (30), 
Direcci�n Varchar (60),
Correo_Electr�nico Varchar (50),
Primary Key (Id_Usuario)
)

Insert Into Usuario Values 
('Sharon T Drew','(903) 935-1670','405 Shelton St
Longview, Texas(TX), 75601','collin_beck@hotmail.com'),
('Billy M Echevarria','404-420-8601','29932 J Rd
Hotchkiss, Colorado(CO), 81419','ashly1978@yahoo.com'),
('Rodney K Spooner','(513) 726-6943','3077 Frazee Rd
Somerville, Ohio(OH), 45064','meggie2002@gmail.com'),
('Joe L Raymond','(276) 679-5140','Po Box 507
Wise, Virginia(VA), 24293','bethel1985@yahoo.com'),
('Shirley L Flynn','(903) 935-1670','405 Shelton St
Longview, Texas(TX), 75601','zena.kerluk5@yahoo.com'),
('Eleanor V Bell','(352) 597-3588','8207 Highpoint Blvd
Brooksville, Florida(FL), 34613','lynn_bartolet@hotmail.com'),
('Valerie N Davis','(909) 624-0432','9620 Fremont Ave
Montclair, California(CA), 91763','bridie1976@hotmail.com'),
('James B Willard','(231) 335-2212','52 W Elm St
Fremont, Michigan(MI), 49412','leone.krajc@hotmail.com'),
('Robert T Shirley','(760) 343-1955','33521 Les Rd
Thousand Palms, California(CA), 92276','maureen1984@hotmail.com'),
('Carrie J Peterson','(630) 289-3477','335 Cedar Cir
Streamwood, Illinois(IL), 60107','milford.dubuq@yahoo.com'),
('Frank S Herb','(515) 428-8250','305 Water St
West Union, Iowa(IA), 52175','miracle.gleas@yahoo.com'),
('Angelica B Neal','(732) 937-5797','32 Cedar Ave
Highland Park, New Jersey(NJ), 08904','sabryna.rosenba@hotmail.com')

Create Table RackServidor
(
Cod_Server int identity (1,1001),
Marca Varchar(25), 
Funcion Varchar(40), 
Ano_Instalacion int, check (Ano_Instalacion between 2000 and 2099), 
Fecha_Mantenimiento date, 
PesoKG int,
Cod_AreaEmp int
foreign key (Cod_AreaEmp) references AreaEmpresa(Cod_AreaEmp) ,
Primary Key (Cod_Server)
)
Select * from AreaEmpresa

Insert Into RackServidor Values
('Sligro','Almacenamiento',2016,'02/15/2020',5750,3),
('Dell','Bases de datos',2017,'03/24/2020',980,4),
('HP','Hosting Web',2016,'02/15/2020',750,4),
('Cisco','C�lculo y simulaci�n',2016,'05/11/2020',1750,3),
('Segate','Desarrollo y pruebas',2019,'11/23/2019',750,3),
('Trend Micro','Transcacciones',2016,'08/02/2021',2800,5),
('Sligro','Backup en procesamiento',2016,'09/08/2023',750,3),
('Dell','Inteligencia Artificial',2020,'05/11/2020',3750,7),
('MSI','Sistema interno',2016,'07/12/2018',750,8),
('Infosys','Almacenamiento',2016,'08/07/2019',750,5),
('HP','Almacenamiento',2016,'09/14/2018',750,4),
('Cisco','Almacenamiento',2016,'08/27/2021',750,8)


Create Table Mantenimiento 
(
Cod_Mantenimiento int Identity (2,200), 
Tipo Varchar (40), check (Tipo IN ('Extender', 'Mejorar', 'Reparar', 'Inspeccionar', 'Reemplazar')), 
Presupuesto Float, 
Descripcion TEXT,
ID_AdministradorACargo int
Primary Key (Cod_Mantenimiento), 
Foreign Key (ID_AdministradorACargo) references Usuario(ID_Usuario)
)


Insert into Mantenimiento Values
('Extender',1200,'',10),
('Mejorar',1200,'',10),
('Extender',1200,'',10),
('Reparar',4500,'',10),
('Inspeccionar',1000,'',10),
('Inspeccionar',1200,'',111),
('Extender',5300,'',10),
('Inspeccionar',1200,'',111),
('Extender',1200,'',10),
('Extender',1200,'',10)

Create Table AsignacionMantenimiento 
(
Cod_Mantenimiento Int, 
Cod_Server Int, 
Cod_Usuario Int, 
FechaInicio Date, 
FechaFin Date, 
Tarea Text, 
Primary Key (Cod_Mantenimiento, Cod_Server, Cod_Usuario),
Foreign Key (Cod_Mantenimiento) references Mantenimiento(Cod_Mantenimiento),
Foreign Key (Cod_Server) references RackServidor(Cod_Server),
Foreign Key (Cod_Usuario) references Usuario(ID_Usuario)
)



Insert into AsignacionMantenimiento Values
(2,1002,10,'12/01/2023','12/04/2023',''),
(202,2003,111,'01/04/2023','01/09/2023',''),
(402,3004,212,'02/14/2023','02/18/2023',''),
(802,4005,111,'02/14/2023','02/18/2023',''),
(1002,5006,717,'02/08/2023','02/08/2023',''),
(1402,3004,616,'03/05/2023','03/10/2023','')

Create Table RolEnAreaDeUsuario 
(
Id_Usuario int, 
Cod_AreaEmp Int, 
Cod_Rol int, 
A�o_Vinculacion int, 
Estado Varchar(25), Check (Estado IN ('Vinculado','Vacaciones','No Activo','Licencia','Retirado', 'Desvinculado')),
Primary Key (Id_Usuario, Cod_AreaEmp, Cod_Rol), 
Foreign Key (Id_Usuario) references Usuario(Id_Usuario), 
Foreign Key (Cod_AreaEmp) references AreaEmpresa(Cod_AreaEmp),
Foreign Key (Cod_Rol) references Rol(Cod_Rol)
)

Insert into RolEnAreaDeUsuario Values 
(10,7,16,2017,'Vinculado'),
(616,5,27,2020,'Vacaciones'),
(313,3,82,2018,'No Activo'),
(111,7,170,2019,'Vinculado')



Create Table Modulo
(
Cod_System int identity (1,10000),
Fabricante Varchar (40), 
Estado Varchar (20), Check (Estado IN ('Encendido', 'Inactivo', 'Apagado', 'Conectado', 'Desconectado', 'En Prueba')),
Consumo_KW int, 
A�o_fabricacion Int, check (A�o_fabricacion between 2000 and 2099),
SistemaOperativo Varchar (20), 
Cod_Server int,
Cod_TipoModulo Int,
IP_System Varchar(30), 
Primary Key (Cod_System), 
Foreign Key (Cod_Server) references RackServidor(Cod_Server), 
Foreign Key (Cod_TipoModulo) references TipoModulo(Cod_TipoModulo), 
)


Insert into Modulo Values 
('Telus','Encendido',1000,2019,'',1002,10,'104.35.202.208'),
('Trimergo','Encendido',1000,2019,'',2003,2010,'10.202.17.157'),
('Infosys Technologies','En Prueba',900,2019,'',3004,1010,'10.249.231.166'),
('Alcatel-Lucent','Desconectado',0,2019,'',4005,5010,'61.170.122.162'),
('PLDT','Inactivo',750,2019,'',2003,3010,'233.59.162.127'),
('Dell','En Prueba',1500,2019,'',4005,3010,'235.34.237.229'),
('D-Link','Apagado',0,2019,'',8009,1010,'224.63.86.112'),
('D-Link','Encendido',600,2019,'',9010,3010,'43.153.198.217'),
('Dell','Desconectado',0,2019,'',2003,4010,'46.66.118.113'),
('Dell','Encendido',980,2019,'Linux',1002,6010,'242.205.104.130'),
('Intel','Encendido',3000,2019,'Windows Server',3004,8010,'190.100.188.165'),
('Nvidia','Encendido',300,2019,'',1002,2010,'75.118.105.189'),
('Nvidia','Inactivo',1500,2019,'Windows Server',1002,2010,'104.104.121.112')

Create Table AccesoUsuarioRack 
(
ID_Usuario int, 
Cod_Server int, 
FechaInicio date, 
FechaFin date,
ID_AdministradorACargo int,
Primary Key (ID_Usuario, Cod_Server, FechaInicio, FechaFin), 
Foreign Key (ID_AdministradorACargo) references Usuario(ID_Usuario), 
Foreign Key (Cod_Server) references RackServidor(Cod_Server), 
Foreign Key (ID_Usuario) references Usuario(ID_Usuario)
)



Insert into AccesoUsuarioRack Values 
(111,1002,'02/27/2023','03/06/2023',10),
(111,2003,'03/04/2023','03/04/2023',717),
(212,1002,'01/01/2023','01/10/2023',10),
(414,4005,'01/10/2023','01/16/2023',10),
(616,6007,'02/16/2023','02/26/2023',717),
(818,1002,'03/03/2023','03/11/2023',10),
(111,2003,'01/17/2023','01/19/2023',10),
(212,9010,'01/07/2023','01/07/2023',10),
(818,3004,'03/13/2023','03/16/2023',717),
(1020,2003,'02/22/2023','02/23/2023',10),
(818,4005,'02/28/2023','03/05/2023',10)


/*
Create Table Mantenimiento 
(
Cod_Mantenimiento Int identity (1,101), 
Tipo Varchar(30), Check (Tipo IN ('extender', 'mejorar', 'reparar', 'inspeccionar',  'reemplazar')),
Presupuesto Float, 
Descripci�n TEXT, 
ID_AdministradorACargo Int,
Primary Key (Cod_Mantenimiento),
Foreign Key (ID_AdministradorACargo) References Usuario (ID_Usuario) 
)
*/

Use DBServidor
Select * from Usuario
Select * from RackServidor
Select * from AreaEmpresa
Select * from AccesoUsuarioRack
Select * from AsignacionMantenimiento
Select * from Rol
Select * from RolEnAreaDeUsuario
Select * from Mantenimiento
Select * from Modulo
Select * from TipoModulo


-- Consultas!! 

-- �Cu�l RackServer tiene m�dulo con Windows Server?

Select * from RackServidor 
inner join Modulo on RackServidor.Cod_Server = Modulo.Cod_Server
Where Modulo.SistemaOperativo = 'Windows Server'

-- �Qui�n realiz� mantenimientos en Enero 2023?
Select * from Usuario
Inner Join AsignacionMantenimiento 
on Usuario.Id_Usuario = AsignacionMantenimiento.Cod_Usuario 
Where AsignacionMantenimiento.FechaInicio Between '2023-01-01' AND '2023-02-01'













-- #FASE DOS PROYECTO

/*ADMINISTRACI�N  DE UNA BASE DE DATOS  Realizar:
Dos  trigger
Dos vistas
Los procedimientos requeridos para gestionar las tablas
Dos funciones lineales
Una funci�n escalar
Crear un usuario para la base de datos donde solo pueda consultar las tablas
Generar la documentaci�n de la base de datos utilizando un programa compatible con el SQL server (DESC_DB)
*/


--1 Trigger: Al cambiar el estado de un m�dulo a Apagado cambiar el consumo a 0kw
Go
CREATE TRIGGER CambiarConsumoModuloApagado
on Modulo
for update 
as update Modulo
set Modulo.Consumo_KW = 0 from inserted
Where EXISTS(Select * from Modulo where Estado ='Apagado')
go

Insert into Modulo Values ('AMD', 'Apagado', 2000,2021, 'Windows Server', 4005, 2010, '217.39.198.42')
Select * from Modulo
update Modulo Set Estado = 'Apagado' Where Fabricante = 'AMD'


--2 Trigger: Al eliminar un usuario eliminar todas sus asignaciones de mantenimiento y su acceso a rack tambi�n
Go
CREATE TRIGGER EliminarAccesoUsuarioEliminado
on usuario
for delete
as 
begin
Delete from AccesoUsuarioRack where ID_Usuario IN(Select accesoUsuarioRack.ID_Usuario from AccesoUsuarioRack inner join deleted on deleted.Id_Usuario = AccesoUsuarioRack.ID_Usuario)
Delete from AsignacionMantenimiento where Cod_Usuario IN(Select Cod_Usuario from AsignacionMantenimiento inner join deleted on deleted.Id_Usuario = AsignacionMantenimiento.Cod_Usuario)
end
Go
Select * from AsignacionMantenimiento


--3 Trigger: Al insertar o actualizar una asignaci�n de mantenimiento insertar un acceso (AccesoUsuarioRack) a los usuarios autorizados por el tiempo de mantenimiento
Go
CREATE TRIGGER CrearAccesoAUsuarioAsignadoMantenimiento
on AsignacionMantenimiento
after insert
as 
begin
DECLARE @FechaInicio DATE; Set @FechaInicio = (Select FechaInicio from inserted)
DECLARE @FechaFin DATE; Set @FechaFin = (Select FechaFin from inserted)
DECLARE @Cod_Server int; Set @Cod_Server = (Select Cod_Server from inserted)
DECLARE @Cod_Usuario int; Set @Cod_Usuario = (Select Cod_Usuario from inserted)
Insert into AccesoUsuarioRack values (@Cod_Usuario,@Cod_Server,@FechaInicio,@FechaFin,@Cod_Usuario)
end
Go

Select * from AccesoUsuarioRack
Select * from AsignacionMantenimiento


--4 Procedimiento: Mostrar los m�dulos que pertenecen a un servidor espec�fico
Go
Create Procedure ConsultarModulosDelServidorNumero
@ServidorNumero int
as
Select * from Modulo where Cod_Server = @ServidorNumero
Go

ConsultarModulosDelServidorNumero @ServidorNumero = 1002

--5 Vista: Mostrar los usuarios administradores
go
Create view MostrarUsuariosAdministradores
as 
Select Usuario.Id_Usuario, Nombre, Tel�fono,Direcci�n,Correo_Electr�nico  from Usuario inner join AccesoUsuarioRack on Usuario.Id_Usuario = ID_AdministradorACargo

go

Select *From MostrarUsuariosAdministradores


--6 Vista: Mostrar los servidores con mantenimientos programados 
Go
Create view MostrarServidoresMantenimientosActivos
as
Select RackServidor.Cod_Server, Marca, Funcion, Fecha_Mantenimiento,PesoKG,Cod_Mantenimiento,Cod_Usuario,FechaInicio,FechaFin from RackServidor inner join AsignacionMantenimiento on RackServidor.Cod_Server = AsignacionMantenimiento.Cod_Server
where FechaInicio<GETDATE() AND FechaFin>GETDATE()
Go

Select * from MostrarServidoresMantenimientosActivos



--7 Funci�n lineal:Consultar los mantenimientos autorizados por un administrador especificado
Go
Create Function MostrarMantenimientosDelAdministrador
(
@Codigo_Administrador int
)
returns table 
as 
return(
Select * from Mantenimiento where ID_AdministradorACargo = @Codigo_Administrador
)
Go

Select * from MostrarMantenimientosDelAdministrador(10)

--8 Funci�n lineal:Consultar los servidores que no han recibido mantenimiento en un n�mero de meses especificado
Go
Create Function MostrarServidoresNoMantenidosEnMeses(
@Meses int
)
Returns table
return(
Select * from RackServidor where NOT DATEDIFF(MONTH,Fecha_Mantenimiento, GETDATE())<@Meses
)
Go

Select * from MostrarServidoresNoMantenidosEnMeses(48)
Select DATEDIFF(MONTH,Fecha_Mantenimiento, GETDATE()) As p from RackServidor
Select * from RackServidor


--9 Funci�n escalar:Consultar el n�mero de racks que posee un servidor Cod_Server especificado
Go
Create Function NumeroDeModulosDelServidorNumero(
@Cod_Servidor int
)
Returns int
as
--S� que puedo facultativamente esribir otro c�digo aqu� si es necesario
Begin
Declare @Result int
Select @Result = Count(*) from Modulo group by Modulo.Cod_Server having Cod_Server = @Cod_Servidor
Return(@Result)
END
go



Select dbo.NumeroDeModulosDelServidorNumero(1002) AS NumeroModulos;
go


Select * from modulo

--10 Vista: Ver n�mero de m�dulos separados por cada Servidor
GO
Create view MostrarNumeroModulosDeCadaServidor 
AS
Select DISTINCT modulo.Cod_Server, COUNT(*) OVER (Partition by Modulo.Cod_Server ) AS NumeroModulos FROM Modulo
GO

Select * From MostrarNumeroModulosDeCadaServidor
--11 Procedimiento: Extender la fecha de asignaci�n de mantenimiento un n�mero de d�as



