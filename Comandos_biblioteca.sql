/*Creacion Base de Datos*/
create database DBBiblioteca2016
go
use  DBBiblioteca2016

/*Crear tabla Tipo_usuario*/
create table tblTipo_Usuario
(
 Cod_tipo int identity (1,1),
 Nom_Tipo varchar(30) not null,
 Primary Key (Cod_tipo)
)
/*Datos Para Tipo de usuario*/

Insert into tblTipo_Usuario values('Estudiante')
Insert into tblTipo_Usuario values('Profesor')
Insert into tblTipo_Usuario values('Directivo')
Insert into tblTipo_Usuario values('Empleado')
Select * from tblTipo_Usuario
/*Crear tabla usuario*/
create table tblusuario
(
 Cedula int,
 Nombre varchar(30)not null,
 telefono int not null,
 Direccion varchar(30) not null,
 Cod_Tipo int not null,
 Estado_usuario varchar(30) not null,
 Primary Key (Cedula),
 Foreign key (Cod_Tipo)references 
 tblTipo_Usuario (Cod_Tipo) on delete cascade on update cascade
)
/*Datos para tabla usuario*/
Insert into tblusuario values(123,'Daniela','9541','751',1,'Vigente')
Insert into tblusuario values(124,'Camilo','9542','752',2,'Betado')
Insert into tblusuario values(125,'Ramon','9543','753',3,'Vigente')
Insert into tblusuario values(126,'Daniel','9541','751',1,'Vigente')
Insert into tblusuario values(127,'Camila','9542','752',2,'Betado')
Insert into tblusuario values(128,'Clara','9543','753',3,'Vigente')
Insert into tblusuario values(129,'Daniel','9541','751',1,'Vigente')
Insert into tblusuario values(130,'Camila','9542','752',2,'Betado')
Insert into tblusuario values(131,'Ramiro','9543','753',3,'Vigente')
Select * from tblTipo_Usuario

/*Crear Tabla dependencia*/
Create table tbldependencia
(
 Cod_Dependencia int identity (1,1),
 Nombre_Dependencia varchar(30)not null,
 Ubicacion  varchar(30)not null,
 Primary key (Cod_Dependencia)
)
/*Datos para Dependencia*/
Insert into tbldependencia values('Judicial','B1_103')
Insert into tbldependencia values('Sistemas','B5_203')
Insert into tbldependencia values('Administraci�n','B3_106')
Insert into tbldependencia values('Educaci�n','B3_107')
Insert into tbldependencia values('Agroambiental','B5_101')
Insert into tbldependencia values('electronica','B1_101')

/*Crear tabla Pertenece*/
create table tblPertenece
(
 Cedula int,
 Cod_Dependencia int not null,
 Primary key (Cedula,Cod_Dependencia),
 Foreign Key (Cedula) references
 tblusuario (Cedula) on delete cascade on update cascade,
 Foreign Key (Cod_Dependencia) references
 tblDependencia (Cod_Dependencia)on delete cascade on update cascade
)
/*Datos para Pertenece*/
Insert into tblPertenece values(123,1)
Insert into tblPertenece values(124,2)
Insert into tblPertenece values(125,3)
Insert into tblPertenece values(126,1)
Insert into tblPertenece values(127,2)
Insert into tblPertenece values(128,3)

/*crear tabla Tipo Material*/
create table tblTipo_Material
(
 CodTipo_Material int identity (1,1),
 NombreTipo_Material varchar(30)not null,
 CantidadTipo_Material int not null,
 Primary key(CodTipo_Material),
)
Insert into tblTipo_Material values('Libro',5000)
Insert into tblTipo_Material values('Revistas',4000)
Insert into tblTipo_Material values('Periodico',3000)
Insert into tblTipo_Material values('Audiovisual',3000)
/*Crear tabla Material*/

create table tblMaterial
(
 Cod_material int identity (1,1),
 Nombre_material varchar (30) not null,
 Valor int not null,
 a�o int  not null,
 CodTipo_Material int not null,
 check (Valor between 1000 and 200000),
 check (a�o between 1930 and 2013),
 cantidad int check (cantidad between 1 and 20),
 Primary Key (Cod_material),
 foreign key (CodTipo_Material) references
 tblTipo_Material (CodTipo_Material) on delete cascade on update cascade
)

ALTER TABLE tblMaterial 
DROP CONSTRAINT CK__tblMaterial__a�o__1352D76D

ALTER TABLE tblMaterial 
ADD CONSTRAINT CK__tblMaterial__a�o__1352D76D CHECK (a�o between 1930 and 2013)

/*Crear Index Unico para Nombre del material */
create unique index Nombre_material on tblMaterial (Nombre_material)

/*Datos para Material*/
Insert into tblMaterial values('Fundamentos de Bases de datos',50000,1989,1,4)
Insert into tblMaterial values('Modelos de bases de datos',50000,1990,1,2)
Insert into tblMaterial values('Nueva tecnolog�a',70000,1990,2,2)
Insert into tblMaterial values('colombiano',90000,2012,3,5)
Insert into tblMaterial values('Sql 2008',50000,1999,1,2)
Insert into tblMaterial values('Al d�a',70000,1990,2,2)
Insert into tblMaterial values('Matem�ticas operativas',90000,1991,1,2)
/*Crear tabla Ejemplar*/
create table tblEjemplar
(
 Num_Ejemplar int identity (1,1),
 Cod_Material int,
 estado varchar (30) not null,
 check (estado ='Prestado'OR estado ='Disponible'OR estado ='En reparacion'OR estado ='Reservado'),
 Primary key(Num_Ejemplar,Cod_Material),
 Foreign key (Cod_Material) references
 tblMaterial (Cod_Material)on delete cascade on update cascade
)
/*Datos para Ejemplar*/
Insert into tblEjemplar values(1,'disponible')
Insert into tblEjemplar values(2,'disponible')
Insert into tblEjemplar values(3,'disponible')
Insert into tblEjemplar values(1,'disponible')
Insert into tblEjemplar values(2,'disponible')
Insert into tblEjemplar values(3,'disponible')


/*Crear Tabla Prestamo*/
create table tblPrestamo
(
 Cod_Prestamo int identity (1,1),
 Fecha_Entrega datetime not null default getdate(),
 Fecha_Devolucion datetime not null,
 Cod_Material int not null,
 Num_Ejemplar int not null,
 Cedula int not null,
 Primary Key(Cod_Prestamo),
 Foreign Key (Num_Ejemplar,Cod_Material) references
 tblEjemplar (Num_Ejemplar,Cod_Material) on delete cascade on update cascade,
 Foreign Key (Cedula) references
 tblUsuario (Cedula) on delete cascade on update cascade
)
/*Datos para Prestamo*/
Insert into tblPrestamo values(getdate(),'03/10/2011',1,1,123)
Insert into tblPrestamo values(getdate(),'05/10/2011',2,2,124)
Insert into tblPrestamo values(getdate(),'06/10/2010',3,3,125)
Insert into tblPrestamo values(getdate(),'03/10/2011',1,1,123)
Insert into tblPrestamo values(getdate(),'05/10/2010',2,2,124)
Insert into tblPrestamo values(getdate(),'06/10/2011',3,3,125)
Insert into tblPrestamo values(getdate(),'03/10/2011',1,1,123)
Insert into tblPrestamo values(getdate(),'05/10/2011',2,2,124)
Insert into tblPrestamo values(getdate(),'06/10/2010',3,3,125)
Insert into tblPrestamo values(getdate(),'03/10/2011',1,1,123)
Insert into tblPrestamo values(getdate(),'05/10/2010',2,2,124)
Insert into tblPrestamo values(getdate(),'06/10/2011',3,3,125)
Insert into tblPrestamo values(getdate(),'03/10/2011',1,1,123)
Insert into tblPrestamo values(getdate(),'05/10/2011',2,2,124)
Insert into tblPrestamo values(getdate(),'06/10/2010',3,3,125)
Insert into tblPrestamo values(getdate(),'03/10/2011',1,1,123)
Insert into tblPrestamo values(getdate(),'05/10/2010',2,2,124)
Insert into tblPrestamo values(getdate(),'06/10/2011',3,3,125)

/*Crear tabla Reserva*/
create table tblReserva
(
 Cod_reserva int identity (1,1),
 Fecha datetime default getdate() not null,
 Cedula int not null,
 Cod_Material int not null,
 Primary key (Cod_reserva),
 Foreign Key (Cedula) references
 tblUsuario (Cedula) on delete cascade on update cascade,
 Foreign Key (Cod_Material) references
 tblMaterial (Cod_Material) on delete cascade on update cascade
)
/*Datos para Reserva*/

Insert into tblReserva values(getdate(),123,1)
Insert into tblReserva values(getdate(),124,2)
Insert into tblReserva values(getdate(),125,3)
Insert into tblReserva values(getdate(),123,1)
Insert into tblReserva values(getdate(),124,2)
Insert into tblReserva values(getdate(),125,3)
Insert into tblReserva values(getdate(),123,1)
Insert into tblReserva values(getdate(),124,2)
Insert into tblReserva values(getdate(),125,3)

/*Crear Tabla Devolucion*/
create table tblDevolucion
(
 Cod_Devolucion int identity (1,1),
 Fecha_Devolucion datetime default getdate() not null,
 Num_Prestamo int not null,
 Primary key (Cod_Devolucion),
 Foreign Key (Num_Prestamo) references
 tblPrestamo (Cod_Prestamo) on delete cascade on update cascade 
)
/*Datos para Devolucion*/

Insert into tblDevolucion values(getdate(),1)
Insert into tblDevolucion values(getdate(),2)
Insert into tblDevolucion values(getdate(),3)

select * from tblTipo_Usuario
select * from tblusuario
select * from tbldependencia
select * from tblpertenece
select * from tblmaterial
select * from tblejemplar
select * from tblusuario
select * from tblreserva
select * from tblprestamo
select * from tbldevolucion
select * from tblTipo_Material


-----------------------------------------------
--Actividad Triggers


--1. Crear un trigger que cambie el estado del ejemplar cuando se inserta un pr�stamo.
go
CREATE TRIGGER CambiarEstadoPrestamoPrestado
ON tblprestamo
FOR Insert 
as update tblEjemplar
set estado = 'prestado' from tblEjemplar inner join inserted
on inserted.Cod_Material = tblEjemplar.Cod_Material 
AND inserted.Num_Ejemplar = tblEjemplar.Num_Ejemplar 
go


Insert into tblPrestamo values(getdate(),'05/10/2010',1,4,124)

--2. Crear un trigger que cambie del ejemplar cuando se borra un pr�stamo.
go
CREATE TRIGGER CambiarEstadoPrestamoDisponible
ON tblprestamo
FOR Delete
as update tblEjemplar
set estado = 'disponible' from tblEjemplar inner join deleted
on deleted.Cod_Material = tblEjemplar.Cod_Material AND
deleted.Num_Ejemplar = tblEjemplar.Num_Ejemplar
go

DELETE FROM tblPrestamo where Cod_Prestamo=20;
--3. Crear un trigger que cambie la cantidad del material cuando se inserta un pr�stamo.
go
CREATE TRIGGER ReducirCantidadDeMaterial
ON tblPrestamo
FOR Insert
as update tblMaterial
set cantidad = (cantidad-1) from tblMaterial inner join inserted
on inserted.Cod_Material = tblMaterial.Cod_material
go

--4. Crear un trigger que cambie la cantidad del material cuando se borra un pr�stamo.

go
CREATE TRIGGER AumentarCantidadDeMaterial
ON tblPrestamo
FOR Delete
as update tblMaterial
set cantidad = (cantidad+1) from tblMaterial inner join deleted
on deleted.Cod_Material = tblMaterial.Cod_material
go


--5. Crear un trigger que cambie el estado del ejemplar a disponible cuando se realice una devoluci�n.
go
CREATE TRIGGER CambiarEstadoEjemplarDisponible
ON tbldevolucion
FOR Insert 
as update tblEjemplar 
set estado = 'disponible' 
from tblEjemplar inner join tblPrestamo 
on  tblEjemplar.Cod_Material = tblPrestamo.Cod_Material 
AND tblEjemplar.Num_Ejemplar = tblPrestamo.Num_Ejemplar 
inner join inserted on inserted.Num_Prestamo = tblPrestamo.Cod_Prestamo 

go

--6. Crear un trigger que evite que se actualice el campo "valor" de la tabla "material�
go
CREATE TRIGGER ImpedirCambioValorTBLMaterial
ON tblmaterial 
FOR update 
AS BEGIN
 IF EXISTS(Select * from inserted i join deleted d ON i.Cod_material = d.Cod_material Where i.Valor != d.Valor)
Raiserror ('No es posible cambiar el valor del campo valor en la tblMaterial', 16, 1)
Rollback transaction
END

--7. Crear un trigger que muestra el valor anterior y nuevo valor de los registros actualizados.
go
CREATE TRIGGER MostrarValorAnteriorNuevoTBLMaterial
ON tblMaterial
FOR update 
AS Begin
Declare @PrintMessage Varchar(1000)
Set @PrintMessage = '| Nuevo valor: ' + Cast((select Valor from inserted) as varchar) + ' | Viejo valor: ' + Cast((select Valor from deleted) as varchar)
Print @PrintMessage
END
go
--8. Crear un trigger que No permita actualizar el valor del material que tenga estado prestado.
go
CREATE TRIGGER ImpedirCambioValorTBLMaterialPrestado
ON tblMaterial
FOR update
AS BEGIN
 IF EXISTS(Select * from inserted i join deleted d ON i.Cod_material = d.Cod_material Where i.Valor != d.Valor 
 AND i.Cod_material IN (select Cod_material from tblPrestamo))
 Raiserror ('No es posible cambiar el valor del campo valor en la tblMaterial', 16, 1)
Rollback transaction
END
go

--9. Crear un trigger que cambie el estado del usuario cuando se inserta un pr�stamo.
go
CREATE TRIGGER CambiarEstadoUsuarioCuandoPrestamo
ON tblPrestamo
FOR insert  
AS update tblusuario
set Estado_usuario = 'Betado'
from tblPrestamo inner join inserted ON
tblPrestamo.Cedula = inserted.Cedula
go
--10. Crear una vista que muestre los datos de los materiales con un valor mayor a 500.000.
go
CREATE VIEW VerDatosMaterialesValorMayor
AS
(Select * from tblMaterial WHERE Valor>500000)
go

--11. Crear una vista que muestre los datos de los materiales que tienen un precio mayor que los materiales tipo audiovisual o revista.

go
CREATE VIEW VerDatosMaterialesPrecioMayorQueAudiovisualRevista
as
(Select * From tblMaterial Where Valor > (Select MAX(Valor) from tblMaterial inner join tblTipo_Material
ON tblMaterial.CodTipo_Material = tblTipo_Material.CodTipo_Material 
AND (tblMaterial.CodTipo_Material = 2 OR tblMaterial.CodTipo_Material = 4)))
go

Select Valor from tblMaterial inner join tblTipo_Material
ON tblMaterial.CodTipo_Material = tblTipo_Material.CodTipo_Material 
AND (tblMaterial.CodTipo_Material = 2 OR tblMaterial.CodTipo_Material = 4)

--12. Crear un procedimiento que muestre los datos de los materiales con un valor mayor que un valor dado por el usuario.
go
CREATE PROCEDURE VerMaterialesMayoresQue
@ValorCorte Int
as 
Select * from tblMaterial Where Valor > @ValorCorte
go

EXEC VerMaterialesMayoresQue @ValorCorte = 400

--13. Crear un procedimiento que inserte un material. 
go
CREATE PROCEDURE InsertarMaterial
@Nombre_Material varchar (35),
@Valor_Material int,
@A�o int,
@CodTipo_Material int,
@Cantidad int
as 
Insert into tblMaterial Values (@Nombre_Material,@Valor_Material,@A�o,@CodTipo_Material,@Cantidad)
Print 'Fue creado exitosamente el material ' + @Nombre_Material
go

EXEC InsertarMaterial 'Piedra',1500,2000,1,10

--14. Crear un procedimiento que actualice los datos del material.
go
CREATE PROCEDURE ActualizarMaterial
@Cod_Material int,
@Nombre_Material varchar (35),
@Valor_Material int,
@A�o int,
@CodTipo_Material int,
@Cantidad int
as 
Update tblMaterial 
Set Nombre_material = @Nombre_Material,
Valor = @Valor_Material,
a�o = @A�o,
CodTipo_Material= @CodTipo_Material,
cantidad = @Cantidad from tblMaterial where Cod_material = @Cod_Material
Print 'Fue Actualizado exitosamente el material ' + @Nombre_Material
go

EXEC ActualizarMaterial 10,'Petra',1501,2001,1,10

Select * from tblMaterial

--15. Crear un procedimiento que borre un pr�stamo.
go
CREATE PROCEDURE BorrarPrestamoConCodigo
@Cod_Prestamo int
as
Delete from tblPrestamo where Cod_Prestamo = @Cod_Prestamo
go


--16. Crear una funci�n que muestre los datos del material con un t�tulo entrado por el usuario.
go
CREATE FUNCTION VerMaterialConElTitulo(
@Titulo Varchar (30))
Returns table
as 
return (Select * from tblMaterial where Nombre_material = @Titulo)
go

Select * from VerMaterialConElTitulo('colombiano')

--17. Crear una funci�n que muestre los d�as de retraso despu�s de la fecha de devoluci�n.
go
CREATE FUNCTION MostrarDiasRetrasoDevolucion(
@Cod_Prestamo int)
Returns table
as
return (Select DATEDIFF(DAY, (Select Fecha_Devolucion from tblDevolucion where Num_Prestamo = @Cod_Prestamo), (Select Fecha_Devolucion from tblPrestamo where Cod_Prestamo = @Cod_Prestamo)) as Dias_de_Retraso)
go
select * from tblprestamo
Select * from MostrarDiasRetrasoDevolucion(3)

--18. Crear una funci�n escalar que muestre el m�ximo valor de los materiales.
go 
CREATE FUNCTION MostrarMaximoValorMaterial()
returns int
as
begin 
declare @Max int
Set @Max = (Select MAX(Valor) from tblMaterial)
return (@Max)
end
go

Select dbo.MostrarMaximoValorMaterial() as MostrarValorMaximo;

--19. Crear un usuario para la base de datos donde solo pueda consultar las tablas. 
USE [master]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [TestUser]    Script Date: 5/6/2023 7:34:31 PM ******/
CREATE LOGIN [TestUser] WITH PASSWORD=N'1V4ai4ixg1tDVftoZXmzy1bWtB/TsD2Fd5jTiE4cH0s=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [TestUser] ENABLE
GO
USE [DBBiblioteca2016]
GO
CREATE USER [TestUser] FOR LOGIN [TestUser]
GO
USE [DBBiblioteca2016]
GO
ALTER ROLE [db_datareader] ADD MEMBER [TestUser]
GO


--20. Generar la documentaci�n de la base de datos utilizando un programa compatible con el SQL server (DESC_DB)


/*
Descripci�n Base de datos:
La base de datos de la biblioteca contiene varias tablas para gestionar la informaci�n de los usuarios, materiales, pr�stamos, reservas y devoluciones. 

Tablas de la base de datos:
1	tblTipo_Usuario
2	tblusuario
3	tbldependencia
4	tblPertenece
5	tblTipo_Material
6	tblMaterial
7	tblEjemplar
8	tblPrestamo
9	tblReserva
10	tblDevolucion
11	TBL_Datos

La tabla 'tblTipo_Usuario' almacena los diferentes tipos de usuarios que pueden acceder a la biblioteca. La tabla 'tblUsuario' contiene la informaci�n personal de los usuarios registrados, como su nombre, direcci�n y n�mero de tel�fono. La tabla 'tblDependencia' almacena informaci�n sobre las dependencias de la biblioteca, como las �reas de estudio y las salas de conferencias. La tabla 'tblPertenece' es una tabla de relaci�n entre las tablas 'tblUsuario' y 'tblDependencia' para identificar qu� usuario pertenece a qu� dependencia.

La tabla 'tblMaterial' contiene informaci�n sobre los diferentes tipos de materiales disponibles en la biblioteca, como libros, revistas y discos compactos. La tabla 'tblEjemplar' contiene informaci�n espec�fica de cada ejemplar de material, como su n�mero de inventario y la fecha de adquisici�n. La tabla 'tblReserva' almacena informaci�n sobre las reservas realizadas por los usuarios para los materiales de la biblioteca.

La tabla 'tblPrestamo' registra los pr�stamos de materiales a los usuarios y la fecha de devoluci�n prevista. La tabla 'tblDevolucion' registra la devoluci�n real de los materiales prestados y la fecha en que se realiz� la devoluci�n. Finalmente, la tabla 'tblTipo_Material' almacena informaci�n sobre los diferentes tipos de materiales, como su categor�a y subcategor�a. En resumen, esta base de datos es una herramienta valiosa para la gesti�n de la biblioteca, proporcionando una visi�n completa de la informaci�n necesaria para llevar a cabo sus operaciones diarias.

1	tblTipo_Usuario	Cod_tipo	int
2	tblTipo_Usuario	Nom_Tipo	varchar
3	tblusuario	Cedula	int
4	tblusuario	Nombre	varchar
5	tblusuario	telefono	int
6	tblusuario	Direccion	varchar
7	tblusuario	Cod_Tipo	int
8	tblusuario	Estado_usuario	varchar
9	tbldependencia	Cod_Dependencia	int
10	tbldependencia	Nombre_Dependencia	varchar
11	tbldependencia	Ubicacion	varchar
12	tblPertenece	Cedula	int
13	tblPertenece	Cod_Dependencia	int
14	tblTipo_Material	CodTipo_Material	int
15	tblTipo_Material	NombreTipo_Material	varchar
16	tblTipo_Material	CantidadTipo_Material	int
17	tblMaterial	Cod_material	int
18	tblMaterial	Nombre_material	varchar
19	tblMaterial	Valor	int
20	tblMaterial	a�o	int
21	tblMaterial	CodTipo_Material	int
22	tblMaterial	cantidad	int
23	tblEjemplar	Num_Ejemplar	int
24	tblEjemplar	Cod_Material	int
25	tblEjemplar	estado	varchar
26	tblPrestamo	Cod_Prestamo	int
27	tblPrestamo	Fecha_Entrega	datetime
28	tblPrestamo	Fecha_Devolucion	datetime
29	tblPrestamo	Cod_Material	int
30	tblPrestamo	Num_Ejemplar	int
31	tblPrestamo	Cedula	int
32	tblReserva	Cod_reserva	int
33	tblReserva	Fecha	datetime
34	tblReserva	Cedula	int
35	tblReserva	Cod_Material	int
36	tblDevolucion	Cod_Devolucion	int
37	tblDevolucion	Fecha_Devolucion	datetime
38	tblDevolucion	Num_Prestamo	int
39	sysdiagrams	name	nvarchar
40	sysdiagrams	principal_id	int
41	sysdiagrams	diagram_id	int
42	sysdiagrams	version	int
43	sysdiagrams	definition	varbinary
44	TBL_Datos	Cedula	int
45	TBL_Datos	Nombre	varchar
46	TBL_Datos	telefono	int
47	TBL_Datos	Direccion	varchar
48	TBL_Datos	Cod_Tipo	int
49	TBL_Datos	Estado_usuario	varchar


*/

USE DBBiblioteca2016
Select Table_Name AS NombreTabla, COLUMN_NAME AS NombreColumna, DATA_TYPE AS TipoDato from INFORMATION_SCHEMA.COLUMNS































































































-----------------------------------------------
/*Punto 1 Insertar una reserva para el usuario Carlos con c�dula 8888 de la dependencia judicial 
para el material libro el Buen vendedor con un valor de 30000, a�o 2013 y cantidad 1. 
Si el usuario y el material no est�n en la base de datos tambi�n los debe insertar 
y asumir los datos faltantes.*/


INSERT INTO tblusuario Values (8888, 'Carlos', 9554, 758, 1, 'Vigente')
INSERT INTO tblPertenece Values (8888, 1)
INSERT INTO tblMaterial Values ('el Buen vendedor',30000,2013,1,1)
INSERT INTO tblReserva Values (getdate(),8888,8)

DELETE FROM tblReserva WHERE Cod_reserva = 11

-----------------------------------------------
/*Punto 2 Insertar en una tabla llamada TBL_datos los registros de �los usuarios con pr�stamos vigentes.*/
Create table TBL_Datos (Cedula int,
 Nombre varchar(30)not null,
 telefono int not null,
 Direccion varchar(30) not null,
 Cod_Tipo int not null,
 Estado_usuario varchar(30) not null,
 Primary Key (Cedula),
 Foreign key (Cod_Tipo)references 
 tblTipo_Usuario (Cod_Tipo) on delete cascade on update cascade
)

 Select * from tblusuario where Cedula in (Select Cedula from tblPrestamo);

 Insert into TBL_Datos  Select * from tblusuario where Cedula in (Select Cedula from tblPrestamo) AND Estado_usuario = 'Vigente';

 Select * from TBL_Datos;
----------------------------------------------------
/*Punto 3. ��Mostrar los datos de los materiales 
que no han devuelto los usuarios de sistemas o de administraci�n.*/

Select * from tblMaterial INNER JOIN tblPrestamo ON tblMaterial.Cod_material = tblPrestamo.Cod_Material;


--Consulta de Materiales Devueltos
Select * from tblMaterial 
INNER JOIN tblPrestamo 
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblDevolucion 
ON tblPrestamo.Cod_Prestamo = tblDevolucion.Num_Prestamo;


--Consulta de Usuarios en dependencia 3 y 2 (Administraci�n y Sistemas)
select * from tblusuario where Cedula in (Select Cedula from tblPertenece where Cod_Dependencia in ('3', '2'))

--Consultad de Materiales No Devueltos 

Select * from tblMaterial where Cod_material NOT IN( Select tblMaterial.Cod_material from tblMaterial
INNER JOIN tblPrestamo 
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblDevolucion 
ON tblPrestamo.Cod_Prestamo = tblDevolucion.Num_Prestamo)

--Consultad de Materiales No Devueltos que pertenecen a usuarios de Administraci�n y Sistemas

Select * from tblMaterial 
INNER JOIN tblPrestamo 
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblusuario
ON tblPrestamo.Cedula = tblusuario.Cedula
INNER JOIN tblPertenece
ON tblusuario.Cedula = tblPertenece.Cedula
INNER JOIN tbldependencia
ON tblPertenece.Cod_Dependencia = tbldependencia.Cod_Dependencia
AND tbldependencia.Cod_Dependencia in ('3','2')
where tblMaterial.Cod_material NOT IN( Select tblMaterial.Cod_material from tblMaterial
INNER JOIN tblPrestamo 
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblDevolucion 
ON tblPrestamo.Cod_Prestamo = tblDevolucion.Num_Prestamo
INNER JOIN tblusuario
ON tblPrestamo.Cedula = tblusuario.Cedula
INNER JOIN tblPertenece
ON tblusuario.Cedula = tblPertenece.Cedula
INNER JOIN tbldependencia
ON tblPertenece.Cod_Dependencia = tbldependencia.Cod_Dependencia
AND tbldependencia.Cod_Dependencia in ('3','2')) 

--(select * from tblusuario where Cedula in 
--(Select Cedula from tblPertenece where Cod_Dependencia in ('3', '2'))))


--AND Cod_material IN (
Select tblMaterial.Cod_material from tblMaterial INNER JOIN tblPrestamo
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblusuario
ON tblPrestamo.Cedula = tblusuario.Cedula WHERE tblusuario.Cedula IN 
(select * from tblusuario where Cedula in (Select Cedula from tblPertenece where Cod_Dependencia in ('3', '2')))


--+
select * from tblusuario u 
Inner Join tblPertenece p on u.Cedula = p.Cedula
Inner Join tbldependencia c on c.Cod_Dependencia = p.Cod_Dependencia
where RTRIM(ltrim(c.Nombre_Dependencia)) in ('Administraci�n', 'Sistemas')
and u.Cedula in (select pre.Cedula from tblPrestamo pre 
left join tblDevolucion d on d.Num_Prestamo = pre.Cod_Prestamo
where Cod_Devolucion is null)
--+
-------------------------------------------------------------------------------------------------

/*4. �Mostrar los nombres de los materiales y su cantidad de pr�stamos solo si 
esta cantidad es mayor que el promedio de todas las cantidades de los materiales. */

Select * from tblPrestamo
Select * from tblMaterial

--Consultar el promedio de cantidad disponible de los materiales

Select AVG(tblMaterial.cantidad) AS "Promedio_DE_LA_Cantidad_DE_Materiales" from  tblMaterial

--Mostrar materiales y prestamos cuya cantidad disponible es mayor que el promedio de disponibilidad de otros materiales

Select * From tblMaterial 
Inner Join tblPrestamo ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
AND tblMaterial.cantidad > (Select AVG(tblMaterial.cantidad) AS "Promedio_DE_LA_Cantidad_DE_Materiales" from  tblMaterial);

--

Select COUNT(tblPrestamo.Cod_Material) AS "NUMERO PRESTAMOS", Nombre_material from
 tblMaterial 
Inner Join tblPrestamo ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
AND tblMaterial.cantidad > (Select AVG(tblMaterial.cantidad) AS "Promedio_DE_LA_Cantidad_DE_Materiales" from  tblMaterial)
GROUP BY Nombre_material

-------------------------------------------------------------------------------------------------

/*5. Mostrar los datos de los usuarios con estado vetado que pertenecen a todas las dependencias.*/

Select * from tblusuario
INNER JOIN tblPertenece ON tblusuario.Cedula =tblPertenece.Cedula
INNER JOIN tbldependencia ON tbldependencia.Cod_Dependencia=tbldependencia.Cod_Dependencia
AND tbldependencia.Cod_Dependencia = Any (Select Cod_Dependencia from tblPertenece)
AND tblusuario.Estado_usuario = 'Betado' 

Select Cedula from tblPertenece Where Cod_Dependencia = ALL (Select Cod_Dependencia from tblPertenece)
-------------------------------------------------------------------------------------------------------------
/*6. �Actualizar el estado de los ejemplares de los materiales tipo pel�cula o juegos para estado reservado.*/
Select * from tblEjemplar
Select * from tblMaterial
Select * from tblTipo_Material
Select * from tblReserva

Select * from tblEjemplar 
INNER JOIN tblMaterial ON tblEjemplar.Cod_Material = tblMaterial.Cod_material
INNER JOIN tblTipo_Material ON tblMaterial.CodTipo_Material = tblTipo_Material.CodTipo_Material
AND tblMaterial.CodTipo_Material IN (4)

UPDATE tblEjemplar SET tblEjemplar.estado = 'reservado' 
WHERE Cod_material IN (Select tblEjemplar.Cod_Material from tblEjemplar 
INNER JOIN tblMaterial ON tblEjemplar.Cod_Material = tblMaterial.Cod_material
INNER JOIN tblTipo_Material ON tblMaterial.CodTipo_Material = tblTipo_Material.CodTipo_Material
AND tblMaterial.CodTipo_Material IN (4))

---------------------------------------------------------------------------------------------------------------
/*7. �Actualizar el valor de los materiales en una disminuci�n
del 5% con a�o menor que 2000 y se han prestado m�s de 5 veces */
 
Select * from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material


--Materiales organizados por n�mero de veces que se prestan
Select COUNT(tblMaterial.Cod_material) AS Veces_Prestado, tblMaterial.Nombre_material, 
tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material


Select COUNT(tblMaterial.Cod_material) AS Veces_Prestado, tblMaterial.Nombre_material, 
tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND a�o <'2000'
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material

-- Materiales que se prestaron m�s de 5 veces y cuyo a�o es mayor a 2000
Select COUNT(tblMaterial.Cod_material) AS Veces_Prestado, tblMaterial.Nombre_material, 
tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND a�o <'2000' 
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material HAVING(COUNT(tblMaterial.Cod_material)>5)


-- Respuesta
UPDATE tblMaterial SET tblMaterial.Valor = (Valor - Valor*0.05)
WHERE tblMaterial.Cod_material IN (Select tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND a�o <'2000' 
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material HAVING(COUNT(tblMaterial.Cod_material)>5))

-- (Solo se ve Codigo de Material) Materiales que se prestaron m�s de 5 veces y cuyo a�o es mayor a 2000

(Select tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND a�o <'2000' 
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material HAVING(COUNT(tblMaterial.Cod_material)>5))


/*8.Actualizar el estado de los usuarios Carlos Camilo y Camila a
vigente si pertenecen a las dependencias Judicial*/

Select * from tbldependencia
Select * from tblusuario

UPDATE tblusuario SET Estado_usuario = 'Vigente'  Where tblusuario.Nombre IN('Carlos','Camilo', 'Camila')
AND tblusuario.Cedula IN
(Select tblusuario.Cedula From tblusuario INNER JOIN tblPertenece ON tblusuario.Cedula = tblPertenece.Cedula
INNER JOIN tbldependencia ON tblPertenece.Cod_Dependencia = tbldependencia.Cod_Dependencia 
WHERE tbldependencia.Cod_Dependencia = '1' AND tblusuario.Nombre IN('Carlos','Camilo', 'Camila'))

/*9. Borrar las reservas de los usuarios Carlos Camilo y Camila.*/

Select * from tblReserva
INNER JOIN tblusuario ON tblReserva.Cedula = tblusuario.Cedula WHERE tblusuario.Nombre 
IN('Carlos','Camilo', 'Camila')

Delete from tblReserva Where Cod_reserva IN (Select Cod_reserva from tblReserva
INNER JOIN tblusuario ON tblReserva.Cedula = tblusuario.Cedula WHERE tblusuario.Nombre 
IN('Carlos','Camilo', 'Camila'))

/*10. Borrar los pr�stamos de los ejemplares de los materiales libros*/

Delete FROM tblPrestamo WHERE Cod_Material IN (Select tblPrestamo.Cod_Material From tblPrestamo 
INNER JOIN tblEjemplar ON tblPrestamo.Cod_Material = tblEjemplar.Cod_Material
INNER JOIN tblMaterial ON tblEjemplar.Cod_Material = tblMaterial.Cod_material
INNER JOIN tblTipo_Material ON tblMaterial.CodTipo_Material = tblTipo_Material.CodTipo_Material
WHERE tblTipo_Material.NombreTipo_Material = 'Libro')
