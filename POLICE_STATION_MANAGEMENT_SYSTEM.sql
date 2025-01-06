CREATE DATABASE POLICE_STATION_MANAGEMENT_SYSTEM;

/*DEPARTMENT*/

CREATE TABLE DEPARTMENT (
    Dept_ID     INT        NOT NULL,
    Dept_name VARCHAR(40),
    Dept_loc VARCHAR(30),
	Head_badgeno INT,
    Head_startdate VARCHAR(30),
    
	CONSTRAINT DEPARTMENT_pk 
	PRIMARY KEY (Dept_ID),

    CONSTRAINT unique_name
	UNIQUE (Dept_name)
);


---VEHICLE---

CREATE TABLE VEHICLE
(
License_no  VARCHAR(20) NOT NULL,
Max_speed int,
Driver_name VARCHAR(30) NOT NULL,
No_of_passenger  int ,
Driver_badgeno int,

CONSTRAINT VEHICLE_pk 
PRIMARY KEY (License_no),


);

--POLICE DOG---

CREATE TABLE POLICE_DOG(
Dog_ID INT NOT NULL,
Dog_name varchar(10),
Trainer_badge_no INT,
Dog_type Varchar (20),
age INT,

CONSTRAINT POLICE_DOG_pk
PRIMARY KEY (Dog_ID)
);

/*EMPLOYEE*/
CREATE TABLE EMPLOYEE
(
Badge_no      INT          NOT NULL,
F_Name      VARCHAR(50)     NOT NULL,
M_Name 		VARCHAR(20) 	NOT NULL,
L_Name 		VARCHAR(20)    	NOT NULL,
Birth_date  VARCHAR(10)   ,
Address_Employee    VARCHAR(30),
telephone           VARCHAR(20),
sex          CHAR,
Rank_Employee   VARCHAR(50),
Salary          INT         ,
Super_badge_no  INT           ,
Dept_ID         INT          ,
shift_time       VARCHAR(30),
no_of_crimes    INT,           /*investigator*/
Patrol_district  VARCHAR(30), /*Patrol officer*/
office_number    INT,         /*officer*/
Working_hours    INT,
Assistant_dog_id INT,
vehicle_Lno     VARCHAR(20) ,

CONSTRAINT EMPLOYEE_pk 
PRIMARY KEY (Badge_no),

CONSTRAINT Employee_supervises_Employee_fk1
FOREIGN KEY (Super_badge_no) REFERENCES EMPLOYEE (Badge_no),

CONSTRAINT Employee_Department_fk2
FOREIGN KEY (Dept_ID) REFERENCES DEPARTMENT (Dept_ID),

CONSTRAINT Employee_Dog_fk3
FOREIGN KEY (Assistant_dog_id) REFERENCES POLICE_DOG (Dog_ID),

CONSTRAINT Employee_Vehicle_fk4
FOREIGN KEY (vehicle_Lno) REFERENCES VEHICLE (License_no)
);

---DEPENDENT---
CREATE table DEPENDENT(
Ebadge_no int,
Dependent_name Varchar(50),
Sex char,
Bdate varchar(20) ,
Relationship Varchar(20),

CONSTRAINT DEPENDENT_pk 
PRIMARY KEY (Ebadge_no,Dependent_name) ,

CONSTRAINT Dependent_Employee_fk1
FOREIGN KEY (Ebadge_no) REFERENCES EMPLOYEE(Badge_no),
);




--FINE--
CREATE TABLE FINE(
Fine_ID  INT NOT NULL,
Fine_type varchar(10),
fine_price int,
Date_time varchar(45),

CONSTRAINT FINE_pk
PRIMARY KEY (Fine_ID)
);

---CELL---
CREATE TABLE CELL(
Cell_no INT,
no_of_detainees INT,
OffIcer_in_charge_badgeno INT,

CONSTRAINT CELL_pk
PRIMARY KEY (Cell_no),

CONSTRAINT Cell_Employee_fk1
FOREIGN KEY (Officer_in_charge_Badgeno) REFERENCES EMPLOYEE (Badge_no)

);
---EVIDENCE---
CREATE TABLE EVIDENCE (
    Evi_ID INT NOT NULL,
    Evi_type VARCHAR(100),
    Storage_loc VARCHAR(55),
    Dispostition VARCHAR(55),
    Collected_date VARCHAR(55),
    Received_from  INT,
	badgeReceived_by  INT  ,
	CONSTRAINT EVIDENCE_pk 
	PRIMARY KEY (Evi_ID),

	CONSTRAINT Evidence_Employee_fk1
	Foreign Key (badgeReceived_by) REFERENCES EMPLOYEE(Badge_no)
);
---CRIME---
CREATE Table CRIME (
Crime_ID               int not null ,
Crime_Date            Varchar(10) ,
Investigator_badge_no  int ,
Description             varchar(100),
responsible_dept_ID       int,
Crime_scene            Varchar(20),

Constraint CRIME_pk Primary key (Crime_ID),

Constraint Crime_Employee_fk1 Foreign key (Investigator_badge_no) References EMPLOYEE(Badge_no),

Constraint Crime_Dept_fk2 Foreign key (responsible_dept_ID) References DEPARTMENT(Dept_ID)

);

---CIVILIAN---
CREATE TABLE CIVILIAN(
SSN INT NOT NULL,
Fname varchar(20),
Mname varchar (20),
Lname varchar(20),
Address varchar(30),
Birth_date varchar(30),
Phone_number varchar(20),
Sex char,
Crime_id INT,
Evidence_provided_id INT,
Investigator_badge_no INT,
Cellno INT,
Fineid INT,

CONSTRAINT CIVILIAN_PK
PRIMARY KEY (SSN),

CONSTRAINT Civilian_Crime_fk1
FOREIGN KEY (Crime_id) REFERENCES CRIME (Crime_ID),

CONSTRAINT Civilian_Evidence_fk2
FOREIGN KEY (Evidence_provided_id) REFERENCES EVIDENCE (Evi_ID),

CONSTRAINT Civilian_cell_fk3
FOREIGN KEY (cellno) REFERENCES CELL (Cell_no),

CONSTRAINT Civilian_fine_fk4
FOREIGN KEY (fineid) REFERENCES FINE (Fine_ID)

);

---Adjustments and constraints---
ALTER TABLE POLICE_DOG
ADD CONSTRAINT Policedog_emp_fk1
FOREIGN KEY (Trainer_badge_no) REFERENCES EMPLOYEE(Badge_no);

ALTER TABLE EVIDENCE
ADD CONSTRAINT Evidence_Civilian_fk2
FOREIGN KEY(Received_from) REFERENCES CIVILIAN (SSN);

ALTER TABLE CIVILIAN
ADD CONSTRAINT Civilian_Employee_fk5
FOREIGN KEY (Investigator_badge_no) REFERENCES EMPLOYEE(Badge_no);


ALTER TABLE VEHICLE
ADD CONSTRAINT Vehicle_Employee_fk1
Foreign key (Driver_badgeno) REFERENCES EMPLOYEE(Badge_no);

ALTER TABLE VEHICLE
DROP CONSTRAINT Vehicle_Employee_fk1;

ALTER TABLE VEHICLE
ADD CONSTRAINT Vehicle_Employee_fk1
Foreign key (Driver_badgeno) REFERENCES EMPLOYEE(Badge_no);

ALTER TABLE Department
ADD CONSTRAINT Department_head_fk
FOREIGN KEY (Head_badgeno) REFERENCES Employee (Badge_no);


----DEPARTMENT VALUES----
INSERT INTO DEPARTMENT (Dept_ID, Dept_name, Dept_loc, Head_badgeno, Head_startdate)
VALUES (101,'Homicide Unit','Nasr city','','5/5/2023');

INSERT INTO DEPARTMENT
VALUES (102,'Cybercrime Division','masr elgdeda','','6/6/2021');

INSERT INTO DEPARTMENT
VALUES (103,'Narcotics Unit','maadi','','12/7/2020');

INSERT INTO DEPARTMENT
VALUES (104,'Missing Persons','sherouk','','5/5/2019');

INSERT INTO DEPARTMENT
VALUES (105,'Drug Enforcement','downtown','','10/9/2022');


----VEHICLE VALUES----
INSERT INTO VEHICLE (License_no ,Max_speed ,Driver_name ,No_of_passenger)
VALUES ('FHY456',120,'Samer',4);

INSERT INTO VEHICLE (License_no ,Max_speed ,Driver_name ,No_of_passenger)
VALUES ('LMK457','180','mohamed',5);

INSERT INTO VEHICLE (License_no ,Max_speed ,Driver_name ,No_of_passenger)
VALUES ('WEP458',180,'hazem',3);

INSERT INTO VEHICLE (License_no ,Driver_name ,No_of_passenger)
VALUES ('OPY459','ahmed',3);

INSERT INTO VEHICLE (License_no ,Driver_name ,No_of_passenger)
VALUES ('VOM460','ahmed',1);




---POLICE DOGS VALUES----
INSERT INTO POLICE_DOG (Dog_ID,Dog_name,Dog_type,age)
VALUES(1991,'Kai','GermanSheperd',10);

INSERT INTO POLICE_DOG (Dog_ID,Dog_name,Dog_type,age)
VALUES(1992,'Leo','GermanSheperd',7);

INSERT INTO POLICE_DOG (Dog_ID,Dog_name,Dog_type,age)
VALUES(1993,'gem','Labrador',5);

INSERT INTO POLICE_DOG (Dog_ID,Dog_name,Dog_type,age)
VALUES(1994,'Ari','Labrador',5);

INSERT INTO POLICE_DOG (Dog_ID,Dog_name,Dog_type,age)
VALUES(1995,'Moon','GermanSheperd',11);


-- EMPLOYEE VALUES --
INSERT INTO EMPLOYEE (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary
,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,Assistant_dog_id)
VALUES ('2/4/1998','ELbhara','20124575445',1,'M','General','ahmad','aly','ghaly',5000,101,7,'8am','nasr city',14,8,1991);

INSERT INTO EMPLOYEE (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary
,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,Assistant_dog_id,vehicle_Lno )
VALUES('11/4/1997','Esmelya','20124578825',2,'M','Lt.General','samer','gmal','daly',5500,1,102,8,'5am','nasr city',14,8,1992,'FHY456');

INSERT INTO  EMPLOYEE  (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary
,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,Assistant_dog_id,vehicle_Lno )
VALUES  ('7/5/1994','dmyat','201785678825',3,'M','Senior constable','ramy','gmal','eldaly',9500,2,103,9,'5am','nasr city',4,6,1993,'LMK457');

INSERT INTO EMPLOYEE (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours ,vehicle_Lno)
VALUES ('2/9/1999','ELbhara','201245122115',4,'F','constable','salma','aly','ghaly',5000,3,104,5,'10am','maadi',19,8,'WEP458');

INSERT INTO EMPLOYEE (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,vehicle_Lno )
VALUES ('2/2/1985','madinty','20124520000',5,'M','sergeant','amer','aly','ghazy',15000,4,105,6,'7pm','nasr city',12,8,'OPY459');

INSERT INTO EMPLOYEE (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,vehicle_Lno )
VALUES ('11/4/1988','maadi','20135678765',6,'M','General','Mehdi','mohamed','abbas',15000,5,105,2,'7pm','nasr city',12,8,'VOM460');

INSERT INTO EMPLOYEE (Birth_date,Address_Employee,telephone,Badge_no,sex,Rank_Employee,F_Name,M_Name,L_Name,Salary,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,vehicle_Lno )
VALUES ('28/4/1975','eldaher','2011178272732',9,'F','General','Rana','ahmed','Ramy',10000,1,101,1,'10am','downtown',1,5,'WEP458');

INSERT INTO EMPLOYEE (Badge_no, F_Name, M_Name, L_Name, Rank_Employee,Birth_date,telephone,sex,Salary,Super_badge_no,Dept_ID,no_of_crimes,shift_time,Patrol_district,office_number,Working_hours,vehicle_Lno)
VALUES (10, 'omar', 'gamal', 'medhat', 'General','11/9/1977','201117721627','M',20000,9,104,4,'8am','nasr city',12,8,'OPY459');

Update EMPLOYEE set Birth_date='11/9/1977',telephone='201117721627',sex='M',Salary=20000,Super_badge_no=9,Dept_ID=104,no_of_crimes=4,shift_time='8am',Patrol_district='nasr city',office_number=12,Working_hours=8,
vehicle_Lno='OPY459';



UPDATE DEPARTMENT
SET Head_badgeno= 1
WHERE Dept_ID = 101;

UPDATE DEPARTMENT
SET Head_badgeno = 2
WHERE Dept_ID = 102;

UPDATE DEPARTMENT
SET Head_badgeno= 3
WHERE Dept_ID = 103;

UPDATE DEPARTMENT
SET Head_badgeno= 4
WHERE Dept_ID = 104;

UPDATE DEPARTMENT
SET Head_badgeno = 5
WHERE Dept_ID= 105;

UPDATE POLICE_DOG
SET Trainer_badge_no=1
WHERE Dog_ID=1991;


UPDATE POLICE_DOG
SET Trainer_badge_no=2
WHERE Dog_ID=1992;


UPDATE POLICE_DOG
SET Trainer_badge_no=3
WHERE Dog_ID=1993;


UPDATE POLICE_DOG
SET Trainer_badge_no=4
WHERE Dog_ID=1994;

---DEPENDENT VALUES----
INSERT INTO DEPENDENT(Ebadge_no, Dependent_name,Sex,Bdate, Relationship)
valueS(1,'Ahmed','M','23/11/2003','Son');

INSERT INTO DEPENDENT (Ebadge_no, Dependent_name,Sex,Bdate, Relationship)
valueS(2,'Sara','F','20/12/2000','Daughter');

INSERT INTO DEPENDENT (Ebadge_no, Dependent_name,Sex,Bdate, Relationship)
valueS(3,'Ahmed','M','12/11/2002','Son');

INSERT INTO DEPENDENT (Ebadge_no, Dependent_name,Sex,Bdate, Relationship)
valueS(4,'Ali','M','10/1/2000','Son');

INSERT INTO DEPENDENT (Ebadge_no, Dependent_name,Sex,Bdate, Relationship)
valueS(5,'mariam','M','6/7/2004','daughter');

---FINE VALUES----
INSERT INTO FINE (Fine_ID, Fine_Type, Fine_price, Date_time)
VALUES (1, 'Parking', 50, '2023-01-15 12:30:00');
  
INSERT INTO FINE
VALUES (2, 'Parking', 50, '2023-02-05 09:45:00');

INSERT INTO FINE 
VALUES(3, 'Seat belt', 75, '2023-03-20 18:15:00');

INSERT INTO FINE  
VALUES(4, 'Parking', 50, '2023-04-10 14:00:00');

INSERT INTO FINE  
VALUES(5, 'Seat belt', 75, '2023-05-02 11:20:00');

INSERT INTO FINE
VALUES(6, 'Running Red Light', 95, '2023-05-25 08:20:00');

INSERT INTO FINE
VALUES(7, 'Speeding', 100, '2023-06-15 10:10:00');

INSERT INTO FINE
VALUES(8, 'Running Red Light', 95, '2023-07-08 20:45:00');

INSERT INTO FINE
VALUES(9, 'Running Red Light', 95, '2023-08-12 14:30:00');

INSERT INTO FINE
VALUES(10, 'Seat belt', 75, '2023-09-05 16:20:00');

INSERT INTO FINE
VALUES(11, 'Speeding', 100, '2023-10-18 09:00:00');

INSERT INTO FINE
VALUES(12, 'Running Red Light', 95, '2023-11-02 15:45:00');

INSERT INTO FINE
VALUES(13, 'Speeding', 100, '2023-01-08 12:15:00');

INSERT INTO FINE
VALUES(14, 'Speeding', 100, '2023-02-14 11:00:00');

INSERT INTO FINE
VALUES(15, 'Seat belt', 75, '2023-12-20 18:30:00');

UPDATE FINE SET Date_time='1/6/2023' Where Fine_ID=14;
UPDATE FINE SET Date_time='1/7/2023' Where Fine_ID=15;
----CELL VALUES----
INSERT INTO CELL 
VALUES (2222, 6, 1);

INSERT INTO CELL 
VALUES(2223,  6, 2);

INSERT INTO CELL 
VALUES(2224,  7  ,3);
 
INSERT INTO CELL 
VALUES(2225,  8 , 4);

INSERT INTO CELL 
VALUES(2226,  7 , 5);

----EVIDENCE VALUES----
INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1001, 'Weapon','Evidence Room 1','In storage','15/1/2022',1);
INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1002,'Crowbar','Evidence Room 2','Disposed','28/2/2022',2);

INSERT INTO EVIDENCE(Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1003,'Knife','Evidence Room 3','In Analysis','1/1/2022',3);

INSERT INTO EVIDENCE(Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1004,'Packet of Drugs','Evidence Room 4','Disposed','1/1/2022',4);

INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1005,'Hammer','Evidence Room 5','Returned','23/4/2022',5);

INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1006,'Weapon','Evidence Room 6','In storage','22/3/2022',1);

INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1007,'Knife','Evidence Room 7','Disposed','10/2/2022',1);

INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1008,'Packet of Drugs','Evidence Room 8','Disposed','1/2/2022',1);

INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1009,'Hammer','Evidence Room 9','Returned','1/6/2022',4);

INSERT INTO EVIDENCE (Evi_id, Evi_type, Storage_loc, Dispostition, Collected_date,badgeReceived_by)
VALUES (1010,'Screwdriver','Evidence Room 10','In Analysis','1/7/2022',3);


----CRIME VALUES----
INSERT INTO CRIME(Crime_ID,Crime_Date,Investigator_badge_no,Description,responsible_dept_ID,Crime_scene)
VALUES (123,'1/1/2020',1,'Financial Crimes',101,'Office');

INSERT INTO CRIME (Crime_ID,Crime_Date,Investigator_badge_no,Description,responsible_dept_ID,Crime_scene)
VALUES (124,'22/11/2021',2,'Cybercrimes',102,'Snapchat');

INSERT INTO CRIME 
VALUES (127,'23/4/2022',3,'Sexual Harassment',103, 'School');

INSERT INTO CRIME 
VALUES (125,'11/11/2020',4,'Financial Crimes',104,'Company');

INSERT INTO CRIME 
VALUES (126,'12/6/2023',5,'Sexual Harassment',105, 'Traffic');

INSERT INTO CRIME (Crime_ID, Crime_Date, Investigator_badge_no, Description, Crime_scene)
VALUES (127, '1/1/2023', 10, 'Fraud', 'Office');

INSERT INTO CRIME (Crime_ID, Crime_Date, Investigator_badge_no, Description, Crime_scene)
VALUES (128, '15/2/2023', 10, 'Embezzlement', 'Bank');

INSERT INTO CRIME (Crime_ID, Crime_Date, Investigator_badge_no, Description, Crime_scene)
VALUES (129, '20/3/2023', 10, 'Corruption', 'Government Building');


----CIVILIAN VALUES----

INSERT INTO CIVILIAN (SSN,Address,Birth_date,Phone_number,sex,
Fname,Mname,Lname, Investigator_badge_no ,Fineid)
VALUES(6001,'maadi','22/11/2001','2011188291732','F','Yara','Ahmed','Fahmy',1,3);

INSERT INTO CIVILIAN (SSN,Address,Birth_date,Phone_number,sex,
Fname,Mname,Lname, Investigator_badge_no ,Fineid)
VALUES(6002,'masr gdeda','10/6/2000','2012278547','M','Omar','Ahmed','Saleh',1,1);

INSERT INTO CIVILIAN (SSN,Address,Birth_date,Phone_number,sex,
Fname,Mname,Lname, Investigator_badge_no ,Fineid)
VALUES(6003,'nasr city','12/1/1999','2019901122','F','Baheera','Omar','Zaher',2,2);


INSERT INTO CIVILIAN (SSN,Address,Birth_date,Phone_number,sex,
Fname,Mname,Lname, Investigator_badge_no ,Fineid)
VALUES(6004,'nasr city','23/1/1999','2012388904323','F','Mona','Mahmoud','Maghraby',2,3);

UPDATE EVIDENCE
SET Received_from=6001
WHERE Evi_ID=1001

UPDATE EVIDENCE
SET Received_from=6001
WHERE Evi_ID=1002

UPDATE EVIDENCE
SET Received_from=6001
WHERE Evi_ID=1003

UPDATE EVIDENCE
SET Received_from=6002
WHERE Evi_ID=1004

UPDATE EVIDENCE
SET Received_from=6002
WHERE Evi_ID=1005;

UPDATE EVIDENCE
SET Received_from=6002
WHERE Evi_ID=1006;

UPDATE EVIDENCE
SET Received_from=6003
WHERE Evi_ID=1007;

UPDATE EVIDENCE
SET Received_from=6003
WHERE Evi_ID=1008;

UPDATE EVIDENCE
SET Received_from=6004
WHERE Evi_ID=1009;

UPDATE EVIDENCE
SET Received_from=6004
WHERE Evi_ID=1010;

UPDATE CIVILIAN
SET Cellno=2222
WHERE SSN=6001;

UPDATE CIVILIAN
SET Cellno=2223
WHERE SSN=6002;

UPDATE CIVILIAN
SET Cellno=2222
WHERE SSN=6003;

UPDATE CIVILIAN
SET Cellno=2226
WHERE SSN=6004;

UPDATE CIVILIAN
SET Crime_id=123
WHERE SSN=6001;

UPDATE CIVILIAN
SET Crime_id=124
WHERE SSN=6002;

UPDATE CIVILIAN
SET Crime_id=123
WHERE  SSN=6003;

UPDATE CIVILIAN
SET Crime_id=127
WHERE SSN=6004;

UPDATE CIVILIAN
SET Evidence_provided_id=1001
WHERE SSN=6001;

UPDATE CIVILIAN
SET Evidence_provided_id=1001
WHERE SSN=6002;

UPDATE CIVILIAN
SET Evidence_provided_id=1010
WHERE SSN=6003;

UPDATE CIVILIAN
SET Evidence_provided_id=1009
WHERE SSN=6004;

---RECORDS OF TABLES/DATA RETREIVAL----
SELECT F_name+''+M_name+''+L_name AS 'Full Name',Badge_no AS 'Badge number',Dept_ID AS 'Department ID',Super_badge_no AS 'Supervisor Badge number'
FROM EMPLOYEE;

SELECT*
FROM EMPLOYEE;

SELECT*
FROM DEPARTMENT;

SELECT*
FROM POLICE_DOG;

SELECT*
FROM DEPENDENT;

SELECT*
FROM CIVILIAN;

SELECT*
FROM VEHICLE;

SELECT*
FROM FINE;

SELECT*
FROM CELL;

SELECT*
FROM EVIDENCE;

SELECT*
FROM CRIME;

---QUERIES---

---PART 1---
SELECT Description, Crime_ID, Crime_Date
FROM CRIME 
WHERE Description= 'Sexual Harassment';

SELECT Crime_scene ,Crime_ID
FROM CRIME
WHERE Crime_scene='Office';

SELECT responsible_dept_ID ,Crime_scene , SSN
FROM  CRIME,DEPARTMENT,CIVILIAN,EVIDENCE
WHERE responsible_dept_ID =Dept_ID and SSN=Received_from ;


SELECT *
FROM DEPENDENT
WHERE Dependent_name= 'Ahmed' OR Dependent_name= 'Mohamed';


SELECT distinct Bdate , sex ,Dependent_name AS'Dependent name'
FROM DEPENDENT 
WHERE  Dependent_name='Ali';

---PART 2----

SELECT Fname+' '+Mname+' '+Lname AS 'Full Name',SSN AS 'Social Security Number',Fineid AS 'Fine ID'
FROM CIVILIAN;

SELECT Cellno AS 'Cell Number',
       COUNT(SSN) AS 'Number of Detainees'
FROM CIVILIAN
GROUP BY Cellno;

SELECT C.Fname + ' ' + C.Mname + ' ' + C.Lname AS 'Civilian Name',
       C.SSN AS 'Social Security Number',
       C.Investigator_badge_no AS 'Investigator Badge Number',
       C.Crime_id AS 'Crime ID'
FROM CIVILIAN C;


SELECT C.Fname + ' ' + C.Mname + ' ' + C.Lname AS 'Civilian Name',
       E.Evi_ID AS 'Evidence ID',
       E.Evi_type AS 'Evidence Type'
FROM CIVILIAN C
LEFT JOIN EVIDENCE E ON C.Evidence_provided_id = E.Evi_ID;


SELECT E.Badge_no AS 'Employee Badge Number',  E.F_Name + ' ' + E.M_Name + ' ' + E.L_Name AS 'Employee Name', PD.Dog_ID AS 'Dog ID', PD.Dog_name AS 'Dog Name'
FROM EMPLOYEE E LEFT JOIN POLICE_DOG PD ON E.Assistant_dog_id = PD.Dog_ID;

SELECT emp.F_Name + ' ' + emp.L_Name AS 'Employee Name',
       m.F_Name + ' ' + m.L_Name AS 'Manager Name'
FROM EMPLOYEE emp
JOIN EMPLOYEE m ON emp.Super_badge_no = m.Badge_no;



SELECT DISTINCT Crime_ID
FROM CRIME
WHERE Crime_ID IN(SELECT Crime_ID
FROM CRIME,EMPLOYEE
WHERE CRIME.Investigator_badge_no=EMPLOYEE.Badge_no
AND Badge_no=10);

SELECT F_Name + ' ' + L_Name AS 'Employee Name',
       shift_time AS 'Shift Time',
       office_number AS 'Office Number',
       Assistant_dog_id AS 'Assistant Dog ID'
FROM EMPLOYEE
WHERE Assistant_dog_id IN (
    SELECT Assistant_dog_id
    FROM EMPLOYEE
    WHERE shift_time = '8am'
);

SELECT Badge_no, F_Name+' '+ M_Name+' '+ L_Name AS 'Investigator Full Name'
FROM EMPLOYEE e
WHERE EXISTS (
    SELECT 1
    FROM CRIME c
    WHERE c.Investigator_badge_no = e.Badge_no
);

----PART 3----
SELECT * FROM FINE WHERE Fine_type = 'Seat belt' ORDER BY fine_price DESC;



SELECT CELL.Cell_no, CELL.no_of_detainees, MAX(FINE.fine_price) AS'Maximum fine price'
FROM CELL
LEFT JOIN FINE ON CELL.Cell_no = FINE.Fine_ID
GROUP BY CELL.Cell_no, CELL.no_of_detainees;


SELECT Fine_type, MIN(fine_price) AS 'minimum fine price'
FROM FINE
GROUP BY Fine_type;

SELECT * 
FROM FINE 
WHERE Date_time >= '1/6/2023' AND Date_time < '1/7/2023';





---PART 4---

SELECT Birth_date, Address_Employee
FROM Employee 
WHERE F_Name='ahmad' AND L_Name='ghaly';

SELECT F_Name, L_Name ,Rank_Employee
FROM DEPARTMENT FULL OUTER JOIN Employee
ON DEPARTMENT.Head_badgeno = Employee.Badge_no;

SELECT *
FROM Employee
WHERE Address_Employee= 'ELbhara' OR F_Name= 'alya';


SELECT DISTINCT L_Name, Salary
FROM Employee;

SELECT License_no
FROM VEHICLE
WHERE Max_speed  BETWEEN '10' AND '180';

SELECT M_Name
FROM Employee
WHERE F_Name LIKE '_a%';

SELECT SUM (Salary), AVG (Salary), MIN (Salary), MAX
(Salary)
FROM Employee WHERE Working_hours BETWEEN 1 and 8 ;

SELECT Dept_ID, AVG (Salary), COUNT (*)
FROM Employee
GROUP BY Dept_ID
HAVING AVG (Salary) > 1000;

SELECT SSN, Fineid, count (Fine_ID) 
FROM CIVILIAN, FINE
WHERE Fineid = Fine_ID
GROUP BY SSN, Fineid
HAVING count (Fine_ID) > 0;

SELECT F_Name, L_Name
FROM Employee
WHERE EXISTS (SELECT *
FROM Dependent
WHERE Ebadge_no = Badge_no)
AND
EXISTS (SELECT *
FROM DEPARTMENT, Employee e
WHERE DEPARTMENT.Dept_ID = Employee.Dept_ID);

---PART 5---
SELECT COUNT(*) AS TotalEvidence
FROM EVIDENCE;

SELECT
    DEPARTMENT.Dept_ID,
    DEPARTMENT.Dept_name,
    AVG(EMPLOYEE.Salary) AS AverageSalary,
    COUNT(EMPLOYEE.Badge_no) AS NumberOfEmployees
FROM
    DEPARTMENT
LEFT JOIN
    EMPLOYEE ON DEPARTMENT.Dept_ID = EMPLOYEE.Dept_ID
GROUP BY
    DEPARTMENT.Dept_ID, DEPARTMENT.Dept_name
HAVING
    AVG(EMPLOYEE.Salary) > 4000;

	SELECT
    DEPARTMENT.Dept_name,
    AVG(EMPLOYEE.Salary) AS AverageSalary
FROM
    DEPARTMENT
JOIN
    EMPLOYEE ON DEPARTMENT.Dept_ID = EMPLOYEE.Dept_ID
WHERE
    EMPLOYEE.sex = 'M'
GROUP BY
    DEPARTMENT.Dept_name;

SELECT
    EMPLOYEE.F_Name+ ' ' + EMPLOYEE.L_Name as 'NAME',
    DEPARTMENT.Dept_name
FROM
    EMPLOYEE
JOIN
    DEPARTMENT ON EMPLOYEE.Dept_ID = DEPARTMENT.Dept_ID;

	SELECT
    F_Name +' '+ M_Name +' '+ L_Name AS 'EMP_FULL_NAME',
	Salary
FROM
    EMPLOYEE
ORDER BY
    Salary DESC;

	SELECT COUNT(*) AS NumberOfKnives
FROM EVIDENCE
WHERE Evi_type = 'Knife';

SELECT COUNT(*) AS NumberOfPackets
FROM EVIDENCE
WHERE Evi_type = 'Packet of Drugs';

SELECT
    Evi_type,
    COUNT(*) AS NumberOfEvidence
FROM
    EVIDENCE
GROUP BY
    Evi_type; 

SELECT
	F_Name + ' ' +L_Name AS 'Manager_Name',
	DEPENDENT.Dependent_name as Dependent_name
FROM
    EMPLOYEE
JOIN
    DEPARTMENT ON EMPLOYEE.Dept_ID = DEPARTMENT.Dept_ID
JOIN
    DEPENDENT ON EMPLOYEE.Badge_no = DEPENDENT.Ebadge_no
WHERE
    EMPLOYEE.Badge_no = DEPARTMENT.Head_badgeno;

SELECT
F_Name + ' ' +L_Name AS Employee_Name
FROM
    EMPLOYEE
LEFT JOIN
    DEPENDENT ON EMPLOYEE.Badge_no = DEPENDENT.Ebadge_no
WHERE
    DEPENDENT.Ebadge_no IS NULL;

	SELECT
    Evi_ID,
    Evi_type,
    Dispostition,
    Storage_loc AS Location
FROM
    EVIDENCE;

SELECT
    Dispostition,
    COUNT(*) AS EvidenceCount
FROM
    EVIDENCE
GROUP BY
    Dispostition;--10--
	SELECT
    E1.F_Name+' '+ E1.L_Name AS 'EMP_Name',
    E2.F_Name+' '+ E2.L_Name AS 'Manager_Name'
FROM
    EMPLOYEE E1
LEFT JOIN
    EMPLOYEE E2 ON E1.Super_badge_no = E2.Badge_no;

--Q2--
ALTER TABLE FINE
ADD fine_status Varchar(20);

--Q1--
SELECT e.F_Name+' '+ e.L_Name AS 'Employee name',FINE.Fine_ID
FROM EMPLOYEE e, FINE
WHERE Fine_ID IN (SELECT SSN
		         FROM CIVILIAN
			     WHERE CIVILIAN.SSN='6001');