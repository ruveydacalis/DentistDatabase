-- Table: Clinic
CREATE TABLE Clinic (
    idClinic int PRIMARY KEY,
    Name varchar(50),
    Location varchar(50)
);

-- Table: Dentist
CREATE TABLE Dentist (
    idDentist int PRIMARY KEY,
    Name varchar(30),
    Surname varchar(30),
    Clinic_idClinic number(4),
    FOREIGN KEY (Clinic_idClinic) REFERENCES Dentist(idDentist)
);

-- Table: Material
CREATE TABLE Material (
    idMaterial int PRIMARY KEY,
    Name varchar(50),
    Price int
);

-- Table: Nurse
CREATE TABLE Nurse (
    idNurse int PRIMARY KEY,
    Name varchar(30),
    Surname varchar(30)  
);

-- Table: Patient
CREATE TABLE Patient (
    idPatient int PRIMARY KEY,
    Sex varchar(30),
    Name varchar(30),
    Surname varchar(30),
    DateOfBirth date,
    ContactNumber int,
    Email varchar(50),
    Address varchar(50)
);

-- Table: Service
CREATE TABLE Service (
    idService int PRIMARY KEY,
    Name varchar(30),
    Price int
);


-- Table: Surgery
CREATE TABLE Surgery (
    idSurgery int PRIMARY KEY,
    Name varchar(50)  ,
    Duration int  ,
    Visit date ,
    Patient_idPatient NUMBER(4),
    Dentist_idDentist NUMBER(4),
    FOREIGN KEY (Patient_idPatient) REFERENCES Surgery (idSurgery),
    FOREIGN KEY (Dentist_idDentist) REFERENCES Surgery (idSurgery)
);

-- Table: SurgeryMaterial
CREATE TABLE SurgeryMaterial (
    idSurgeryMaterial int PRIMARY KEY,
    Surgery_idSurgery NUMBER(4),
    Material_idMaterial NUMBER(4),
    Amount int ,
    FOREIGN KEY (Surgery_idSurgery) REFERENCES SurgeryMaterial (idSurgeryMaterial),
    FOREIGN KEY (Material_idMaterial) REFERENCES SurgeryMaterial (idSurgeryMaterial)
);

-- Table: SurgeryNurse
CREATE TABLE SurgeryNurse (
    idSurgeryNurse int PRIMARY KEY,
    Nurse_idNurse NUMBER(4),
    Surgery_idSurgery NUMBER(4),
    FOREIGN KEY (Nurse_idNurse) REFERENCES SurgeryNurse (idSurgeryNurse),
    FOREIGN KEY (Surgery_idSurgery) REFERENCES SurgeryNurse (idSurgeryNurse)
);

-- Table: SurgeryService
CREATE TABLE SurgeryService (
    idSurgeryService int PRIMARY KEY,
    Surgery_idSurgery NUMBER(4),
    Service_idService NUMBER(4),
    FOREIGN KEY (Surgery_idSurgery) REFERENCES SurgeryService (idSurgeryService),
    FOREIGN KEY (Service_idService) REFERENCES SurgeryService (idSurgeryService)
);

--INSERTING DATA
Insert Into Patient Values (1,'F','Ruv','Calis',TO_DATE('08-NOVEMBER-2000','DD-MON-YYYY'),123456789,'sruveydacls@gmail.com','Warsaw');
Insert Into Patient Values (2,'M','Anna','Smith',TO_DATE('11-JUNE-2006','DD-MON-YYYY'),234567890,'asmith@gmail.com','Warsaw');
Insert Into Patient Values (3,'F','Arthur','John',TO_DATE('17-FEBRUARY-1980','DD-MON-YYYY'),345678901,'arthurjj@gmail.com','Warsaw');
Insert Into Patient Values (4,'M','Angel','Brown',TO_DATE('22-AUGUST-1985','DD-MON-YYYY'),456789012,'brownangel@gmail.com','Warsaw');
Insert Into Patient Values (5,'F','Simon','William',TO_DATE('30-JANUARY-1995','DD-MON-YYYY'),567890123,'simonwllm@gmail.com','Warsaw');
Insert Into Patient Values (6,'F','Angel','William',TO_DATE('20-JANUARY-1995','DD-MON-YYYY'),5678900123,'angellm@gmail.com','Warsaw');

Insert Into Clinic Values(1,'Centrum Dentist','Al. Jerozolimskie 19');

Insert Into Dentist Values (1,'Dan','Fisher',1);
Insert Into Dentist Values (2,'Richard','Malouf',1);
Insert Into Dentist Values (3,'David','Alameel',1);
Insert Into Dentist Values (4,'Clint','Herzog',1);
Insert Into Dentist Values (5,'Simon','Dan',1);
Insert Into Dentist Values (6,'Anna','Dan',1);

Insert Into Nurse Values (1,'Jennifier','Elgan');
Insert Into Nurse Values (2,'Olivia','Devall');
Insert Into Nurse Values (3,'Emma','Hailey');
Insert Into Nurse Values (4,'Sophia','Robertson');
Insert Into Nurse Values (5,'Amelia','Danson');

Insert Into Surgery Values(1,'Implant',3,TO_DATE('01-MAY-2021','DD-MON-YYYY'),1,1);
Insert Into Surgery Values(2,'Root Canal Treatment',1,TO_DATE('10-MAY-2021','DD-MON-YYYY'),2,2);
Insert Into Surgery Values(3,'Corrective jaw surgery',1,TO_DATE('20-MAY-2021','DD-MON-YYYY'),3,3);
Insert Into Surgery Values(4,'Tooth extractions',1,TO_DATE('25-MAY-2021','DD-MON-YYYY'),4,4);
Insert Into Surgery Values(5,'Root Canal Treatment',2,TO_DATE('01-JUNE-2021','DD-MON-YYYY'),5,5);

Insert Into SurgeryNurse Values(1,1,1);
Insert Into SurgeryNurse Values(2,2,2);
Insert Into SurgeryNurse Values(3,3,3);
Insert Into SurgeryNurse Values(4,4,4);
Insert Into SurgeryNurse Values(5,5,5);

Insert Into Material Values(1,'Amalgam',50);
Insert Into Material Values(2,'Composite Resin',60);
Insert Into Material Values(3,'Ceramics',70);
Insert Into Material Values(4,'Gold',200);
Insert Into Material Values(5,'Zirconia',150);
Insert Into Material Values(5,'Zirconia',150);

Insert Into SurgeryMaterial Values(1,1,1,null);
Insert Into SurgeryMaterial Values(2,2,2,700);
Insert Into SurgeryMaterial Values(3,3,3,500);
Insert Into SurgeryMaterial Values(4,4,4,1000);
Insert Into SurgeryMaterial Values(5,5,5,1100);
Insert Into SurgeryMaterial Values(6,5,5,1100);

Insert Into Service Values(1,'A', 100);
Insert Into Service Values(2,'B', 150);
Insert Into Service Values(3,'C', 1200);
Insert Into Service Values(4,'D', 1500);
Insert Into Service Values(5,'F', 300);

Insert Into SurgeryService Values(1,1,1);
Insert Into SurgeryService Values(2,2,2);
Insert Into SurgeryService Values(3,3,3);
Insert Into SurgeryService Values(4,4,4);
Insert Into SurgeryService Values(5,5,5);

--QUERIES

--Find the materials with the maximum price for surgery. Present data by decreasing prices.
select Name
From Material
Where price in(select max(price)
               From Material
               Group by Name)
Order by price desc;

--Find dentist working in Surgery not described in table Surgery
select Name
from Dentist
where idDentist NOT IN(Select Dentist_idDentist
                       From Surgery);
                       
--Find the name of service with the lowest average price.
select Name
From Service
Group by Name
Having avg(Price) = (select min(avg(Price))
                      From Service
                      Group by Name);

--Show names of patient and address where they live . Do not show  names of people including 'A'
select Name, Address
From Patient
Where Name NOT LIKE '%A%';

--Which material are most used in surgery?
SELECT Name
FROM Material, SurgeryMaterial
WHERE Material.idMaterial = SurgeryMaterial.Material_idMaterial
GROUP BY Name
HAVING COUNT(Surgery_idSurgery) = ( 
SELECT MAX(COUNT(Surgery_idSurgery)) 
FROM SurgeryMaterial sm, Material m
WHERE m.idMaterial = sm.Material_idMaterial 
GROUP BY Name); 

--Show patients who have taken surgery by gender
Select Name, sex
From Patient
Where idPatient IN (Select Patient_idPatient
                    From Surgery)
Order by sex;

--Which nurse worked in Implant surgery?
Select Name, Surname
From Nurse
Where idNurse IN (Select Nurse_idNurse
                  From SurgeryNurse
                  Where Surgery_idSurgery = (Select idSurgery
                                             From Surgery
                                             Where Name = 'Implant'));
                            
--Are there any patients with the same surname?
Select Surname
From Patient
Having Count(Surname) > 1
Group by Surname;

--Which dentist's surgery took 3 hours?
Select Name, Surname
From Dentist
Where idDentist IN (Select Dentist_idDentist
                    From Surgery
                    Where Duration = 3);

--Are there any material which price then 100 less than 500? Show them (name and price) from the most expensive to the cheapest one?
Select Name, Price
From Material
Where Price BETWEEN 100 AND 500
Order by Price DESC;

--Show in one column address of patients and clinic
Select Address || ' address'
From Patient
UNION
Select Location || ' location'
From Clinic;

--Check who have surgery in 2020.
Select Name
From Patient
JOIN Surgery ON Surgery.Patient_idPatient = Patient.idPatient
WHERE EXTRACT (Year FROM Date) = 2020;
----------------------------------------------------

--TRIGGERS
SET SERVEROUTPUT ON;

--TRIGGER AFTER INSERT
CREATE OR REPLACE TRIGGER NumberOfMaterial
AFTER INSERT ON Material
DECLARE 
x INTEGER;
BEGIN
SELECT (COUNT(Name)+1) INTO x From Material;
DBMS_OUTPUT.PUT_LINE('TOTAL NUMBERS OF MATERIALS '||X||'');
END;
--Check the trigger 
Insert Into Material Values(10,'Amalgam',50);

--TRIGGER BEFORE INSERT
--If the patient is under 18 years, she or he can’t take surgery.
CREATE OR REPLACE TRIGGER CheckAge
BEFORE INSERT ON Patient
FOR EACH ROW
DECLARE
Age Integer;
Birth Date;
Exception_notAllowed EXCEPTION;
BEGIN
Birth := :NEW.DateOfBirth;
Age := TRUNC(MONTHS_BETWEEN(SYSDATE, Birth))/12;
IF INSERTING THEN    
    IF Age < 18 THEN
      RAISE Exception_notAllowed;
    ELSE
      dbms_output.put_line('YOU CAN TAKE A SURGERY'); 
    END IF;
  END IF;
EXCEPTION
WHEN Exception_notAllowed THEN
   Raise_application_error(-20100,'YOU CAN NOT TAKE A SURGERY') ;
END;
--Check the Trigger 
Insert Into Patient Values (10,'F','Isabella','Van',TO_DATE('11-JUNE-2015','DD-MON-YYYY'),234546890,'isabella@gmail.com','Warsaw');

--TRIGGER  AFTER UPDATE
CREATE OR REPLACE TRIGGER averageAmountOfSurgery
AFTER UPDATE ON SurgeryMaterial
Declare 
x INTEGER;
BEGIN
SELECT AVG(Amount) INTO x FROM SurgeryMaterial;
DBMS_OUTPUT.PUT_LINE('Average amount of Surgery is '||x||'');
END;
--Check the trigger 
UPDATE SurgeryMaterial
SET Amount = Amount + 100
WHERE Amount < (SELECT AVG(Amount)
                FROM SurgeryMaterial);

--TRIGGER BEFORE UPDATE
DROP TRIGGER amountCheck;

CREATE OR REPLACE TRIGGER amountCheck
BEFORE UPDATE
ON SurgeryMaterial
FOR EACH ROW
DECLARE
tmpValue Integer;
BEGIN
tmpValue := :NEW.Amount;
DBMS_OUTPUT.PUT_LINE('New value of the Amount is : ' || tmpValue);
IF UPDATING THEN
IF tmpValue <= 300 THEN 
RAISE_APPLICATION_ERROR(-20100,'Amount is not updated beacuse given amount is too low');
END IF;
END IF;
END;
--Check the trigger
UPDATE SurgeryMaterial SET Amount = 100 WHERE idSurgeryMaterial = 1;

--TRIGGER AFTER DELETE
--Triggers shows last surgery date
CREATE OR REPLACE TRIGGER showDate
AFTER DELETE
ON Surgery
DECLARE
lastDate Surgery.Visit%type;
BEGIN 
SELECT MAX(Visit) INTO lastDate
FROM Surgery;
DBMS_OUTPUT.PUT_LINE('Last date: ' || lastDate);
END;
--Check the trigger 
DELETE Surgery SET Duration =5 where idSurgery = 1;

--TRIGGER BEFORE DELETE
DROP TRIGGER priceCheck;
--If want to delete service record and the price is bigger than 500, raise error .
CREATE OR REPLACE TRIGGER priceCheck
BEFORE DELETE
ON Service
FOR EACH ROW
DECLARE
servicePrice Service.Price%type;
BEGIN
servicePrice := :old.Price;
DBMS_OUTPUT.PUT_LINE('Price is : ' || servicePrice);
IF DELETING THEN
IF servicePrice >= 500 THEN
Raise_application_error(-20100,'YOU CAN NOT DELETE') ;
END IF;
END IF;
END;
--Check the Trigger
DELETE from Service Where Price = 1000;

--TRIGGER BEFORE UPDATE
--Changing visit date, it doesn't allow to change date between given date
CREATE OR REPLACE TRIGGER changeVisitDate
BEFORE UPDATE OF Visit
ON Surgery
DECLARE
aDayOfMonth number;
BEGIN
aDayOfMonth := EXTRACT(DAY FROM sysdate);
IF aDayOfMonth BETWEEN 25 AND 31 THEN
RAISE_APPLICATION_ERROR(-20100,'Can not update');
END IF;
END;
--Check the Trigger 
UPDATE Surgery SET Visit = TO_Date('06/09/2021','dd/mm/yyyy') where idSurgery =5;

--TRIGGER BEFORE DELETE
--Before delete, show there are how many nurse
drop trigger numberOfNurse;
---
CREATE OR REPLACE TRIGGER numberOfNurse
BEFORE DELETE
ON Nurse
DECLARE howMany NUMBER;
BEGIN
SELECT COUNT(idNurse) INTO howMany From Nurse;
IF howMany = 0 THEN 
RAISE_APPLICATION_ERROR(-20100,'You can not delete it because there are no data');
ELSE
DBMS_OUTPUT.PUT_LINE('After deleting we have ' || (howMany - 1) || ' nurse.');
END IF;
END;
--Check the trigger
--(we have delete first from SurgeryNurse)
delete from SurgeryNurse where Nurse_idNurse = 3;
delete from Nurse where idNurse=3;
