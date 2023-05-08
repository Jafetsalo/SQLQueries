
/*Let's review commands and variable creation*/
declare @textMessage varchar(200);

set @textMessage = 'Im excited  to explore SQLServer features. Now, it is early Tuesday :)';

print @textMessage;

-- --------------------------------------------------


Declare @FirstNumber Int;
Declare @SecondNumber Int;
Declare @Result Int;

Set @FirstNumber =-3
Set @SecondNumber =7

Set @Result = (@FirstNumber + @SecondNumber);



IF (@Result < 5 )
Begin

Print 'Your numbers together =' + cast(@Result as varchar) +' are smaller than 5 :p'

End
Else

Print 'Your numbers together are greater or equal to 5 :)'


Create Database TestDB
GO
Use TestDB
 --Remember to delete this database accordingly

Create table TBLTest 
 (TestName Varchar (50),
 TestID int Identity(1,1))

 ALTER TABLE TBLTest 
 ADD
 CONSTRAINT ConstTestID primary key (TestID)



 Select * from TBLTest;
 
 go

 Create Trigger AddCat
 ON TBLTest
 FOR Insert
 As Update TBLTest
 Set TestName = CONCAT (TestName, 'CAT')

 insert into TBLTest values ('Miau')



 go

 CREATE Trigger HamperDroping
 ON Database
 FOR  DROP_TABLE, ALTER_TABLE
 AS
 BEGIN
 RAISERROR ('No se puede eliminar TestTBL porque así o digo yo', 16, 1)
 ROLLBACK Transaction
 END

 go

CREATE Trigger StopNamingSMBJafet
 ON TBLTest
 FOR Insert
 AS
Begin
Declare @ThisName Varchar(20)
SET @ThisName = (Select TestName From TBLTest where TestName = 'Jafet')
IF (@ThisName = 'Jafet') 
BEGIN
 RAISERROR ('No se puede crear a alguien como Jafet porque así o digo yo', 16, 1)
 ROLLBACK Transaction
 END
 ELSE
 BEGIN
 PRINT 'Se pudo crear al usuariio y me da pereza concatenar :P'
 END
End

 
 Insert into TBLTest values ('Jafet')

 Select * From TBLTest

 go
 CREATE VIEW ShowTBLTest AS (Select * from TBLTest);
 go


 select * from ShowTBLTest;


--Aujourdhui on va reviser les procédures stockés 
-- On demarre
go
Create function SPTestCount()
returns int
as
begin
Declare @NumberOfRows int
Set @NumberOfRows = (Select Count( TestID) from TBLTest)
return (@NumberOfRows)
end

go

--Count(Select TestID from TBLTest)

DECLARE @ReceiveNumber int
EXEC @ReceiveNumber = SPTestCount
SELECT 'Return Value' = @ReceiveNumber 
go

--Next step let's work on the Assignment

--We're first working on Users and their access 

