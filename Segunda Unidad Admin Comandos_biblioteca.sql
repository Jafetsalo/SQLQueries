/*Creacion Base de Datos*/
create database DBBiblioteca2016
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
Insert into tbldependencia values('Administración','B3_106')
Insert into tbldependencia values('Educación','B3_107')
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
 año int  not null,
 CodTipo_Material int not null,
 check (Valor between 1000 and 200000),
 check (año between 1930 and 2013),
 cantidad int check (cantidad between 1 and 20),
 Primary Key (Cod_material),
 foreign key (CodTipo_Material) references
 tblTipo_Material (CodTipo_Material) on delete cascade on update cascade
)

ALTER TABLE tblMaterial 
DROP CONSTRAINT CK__tblMaterial__año__1352D76D

ALTER TABLE tblMaterial 
ADD CONSTRAINT CK__tblMaterial__año__1352D76D CHECK (año between 1930 and 2013)

/*Crear Index Unico para Nombre del material */
create unique index Nombre_material on tblMaterial (Nombre_material)

/*Datos para Material*/
Insert into tblMaterial values('Fundamentos de Bases de datos',50000,1989,1,4)
Insert into tblMaterial values('Modelos de bases de datos',50000,1990,1,2)
Insert into tblMaterial values('Nueva tecnología',70000,1990,2,2)
Insert into tblMaterial values('colombiano',90000,2012,3,5)
Insert into tblMaterial values('Sql 2008',50000,1999,1,2)
Insert into tblMaterial values('Al día',70000,1990,2,2)
Insert into tblMaterial values('Matemáticas operativas',90000,1991,1,2)
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
/*Punto 1 Insertar una reserva para el usuario Carlos con cédula 8888 de la dependencia judicial 
para el material libro el Buen vendedor con un valor de 30000, año 2013 y cantidad 1. 
Si el usuario y el material no están en la base de datos también los debe insertar 
y asumir los datos faltantes.*/


INSERT INTO tblusuario Values (8888, 'Carlos', 9554, 758, 1, 'Vigente')
INSERT INTO tblPertenece Values (8888, 1)
INSERT INTO tblMaterial Values ('el Buen vendedor',30000,2013,1,1)
INSERT INTO tblReserva Values (getdate(),8888,8)

DELETE FROM tblReserva WHERE Cod_reserva = 11

-----------------------------------------------
/*Punto 2 Insertar en una tabla llamada TBL_datos los registros de  los usuarios con préstamos vigentes.*/
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
/*Punto 3.   Mostrar los datos de los materiales 
que no han devuelto los usuarios de sistemas o de administración.*/

Select * from tblMaterial INNER JOIN tblPrestamo ON tblMaterial.Cod_material = tblPrestamo.Cod_Material;


--Consulta de Materiales Devueltos
Select * from tblMaterial 
INNER JOIN tblPrestamo 
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblDevolucion 
ON tblPrestamo.Cod_Prestamo = tblDevolucion.Num_Prestamo;


--Consulta de Usuarios en dependencia 3 y 2 (Administración y Sistemas)
select * from tblusuario where Cedula in (Select Cedula from tblPertenece where Cod_Dependencia in ('3', '2'))

--Consultad de Materiales No Devueltos 

Select * from tblMaterial where Cod_material NOT IN( Select tblMaterial.Cod_material from tblMaterial
INNER JOIN tblPrestamo 
ON tblMaterial.Cod_material = tblPrestamo.Cod_Material 
INNER JOIN tblDevolucion 
ON tblPrestamo.Cod_Prestamo = tblDevolucion.Num_Prestamo)

--Consultad de Materiales No Devueltos que pertenecen a usuarios de Administración y Sistemas

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
where RTRIM(ltrim(c.Nombre_Dependencia)) in ('Administración', 'Sistemas')
and u.Cedula in (select pre.Cedula from tblPrestamo pre 
left join tblDevolucion d on d.Num_Prestamo = pre.Cod_Prestamo
where Cod_Devolucion is null)
--+
-------------------------------------------------------------------------------------------------

/*4.  Mostrar los nombres de los materiales y su cantidad de préstamos solo si 
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
/*6.  Actualizar el estado de los ejemplares de los materiales tipo película o juegos para estado reservado.*/
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
/*7.  Actualizar el valor de los materiales en una disminución
del 5% con año menor que 2000 y se han prestado más de 5 veces */
 
Select * from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material


--Materiales organizados por número de veces que se prestan
Select COUNT(tblMaterial.Cod_material) AS Veces_Prestado, tblMaterial.Nombre_material, 
tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material


Select COUNT(tblMaterial.Cod_material) AS Veces_Prestado, tblMaterial.Nombre_material, 
tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND año <'2000'
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material

-- Materiales que se prestaron más de 5 veces y cuyo año es mayor a 2000
Select COUNT(tblMaterial.Cod_material) AS Veces_Prestado, tblMaterial.Nombre_material, 
tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND año <'2000' 
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material HAVING(COUNT(tblMaterial.Cod_material)>5)


-- Respuesta
UPDATE tblMaterial SET tblMaterial.Valor = (Valor - Valor*0.05)
WHERE tblMaterial.Cod_material IN (Select tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND año <'2000' 
GROUP BY tblMaterial.Nombre_material, tblMaterial.Cod_material HAVING(COUNT(tblMaterial.Cod_material)>5))

-- (Solo se ve Codigo de Material) Materiales que se prestaron más de 5 veces y cuyo año es mayor a 2000

(Select tblMaterial.Cod_material from tblMaterial 
INNER JOIN tblPrestamo ON tblPrestamo.Cod_Material=tblMaterial.Cod_material
AND año <'2000' 
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

/*10. Borrar los préstamos de los ejemplares de los materiales libros*/

Delete FROM tblPrestamo WHERE Cod_Material IN (Select tblPrestamo.Cod_Material From tblPrestamo 
INNER JOIN tblEjemplar ON tblPrestamo.Cod_Material = tblEjemplar.Cod_Material
INNER JOIN tblMaterial ON tblEjemplar.Cod_Material = tblMaterial.Cod_material
INNER JOIN tblTipo_Material ON tblMaterial.CodTipo_Material = tblTipo_Material.CodTipo_Material
WHERE tblTipo_Material.NombreTipo_Material = 'Libro')
