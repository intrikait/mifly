connect 'jdbc:derby:mifly;create=true';

CREATE TABLE ServiceArea
(
	Area		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_servicearea PRIMARY KEY (Area)
);

CREATE TABLE Airports
(
	FAA_Abbr	VARCHAR(3) NOT NULL,
	Port_Name	VARCHAR(30) NOT NULL,
	Area		VARCHAR(20) NOT NULL,
	Location	VARCHAR(20) NOT NULL,
	CONSTRAINT pk_airports PRIMARY KEY (FAA_Abbr)
);
  
CREATE TABLE Flights
(
	Flight_Num	INTEGER NOT NULL,
	Arr_Port	VARCHAR(3) NOT NULL,
	Dept_Port	VARCHAR(3) NOT NULL,
	Arr_Time	VARCHAR(7) NOT NULL,
	Dept_Time	VARCHAR(7) NOT NULL,
	F_Date		DATE NOT NULL,
	F_Length	INTEGER NOT NULL,
	Airline_Name	VARCHAR(20) NOT NULL,
	Crew_Num	INTEGER NOT NULL,
	CONSTRAINT pk_flights PRIMARY KEY (Flight_Num)
);
  
CREATE TABLE Airlines
(
	Airline_Name	VARCHAR(20) NOT NULL,
	Location		VARCHAR(20) NOT NULL,
	FAA_Abbr	VARCHAR(3) NOT NULL,
	Fly_Type	VARCHAR(20) NOT NULL,
	CONSTRAINT pk_airlines PRIMARY KEY (Airline_Name)
);

CREATE TABLE Planes
(
	Airline_Name VARCHAR(20) NOT NULL,
	FAA_Tail	VARCHAR(6) NOT NULL,
	Manufacturer	VARCHAR(20) NOT NULL,
	Model_Num	VARCHAR(3) NOT NULL,
	Num_Pssgrs	INTEGER NOT NULL,
	Plane_Name	VARCHAR(20),
	CONSTRAINT pk_planes PRIMARY KEY (FAA_Tail)
);

CREATE TABLE Crew
(
	Crew_Num	INTEGER NOT NULL,
	Attndt_Qty	INTEGER NOT NULL,
	CONSTRAINT pk_crew PRIMARY KEY (Crew_Num)
);

CREATE TABLE Cost
(
	Flight_Num	INTEGER NOT NULL,
	C_Type		VARCHAR(20) NOT NULL,
	Cost		DECIMAL(3,2) NOT NULL,
	CONSTRAINT pk_cost PRIMARY KEY (Flight_Num,C_Type)
);

CREATE TABLE Personnel
(
	Emp_ID		INTEGER NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	E_Type		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_personnel PRIMARY KEY (Emp_ID)
);

CREATE TABLE FlightCrew
(
	Emp_ID		INTEGER NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	Job		VARCHAR(20) NOT NULL,
	FAA_Num		VARCHAR(4) NOT NULL,
	Crew_Num		INTEGER NOT NULL,
	CONSTRAINT pk_flightcrew PRIMARY KEY (FAA_Num)
);

CREATE TABLE GroundWorkers
(
	Emp_ID		INTEGER NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	Job			VARCHAR(20) NOT NULL,
	CONSTRAINT pk_groundworkers PRIMARY KEY (Emp_ID)
);

CREATE TABLE IncidentReports
(
	Flight_Num	INTEGER NOT NULL,
	Filed_FAA	VARCHAR(4) NOT NULL,
	Reported_FAA	VARCHAR(4) NOT NULL,
	Inc_Type		VARCHAR(20) NOT NULL,
	Inc_Desc		VARCHAR(30) NOT NULL,
	CONSTRAINT pk_increports PRIMARY KEY (Flight_Num,Filed_FAA,Reported_FAA)
);

ALTER TABLE Airports
	ADD CONSTRAINT airports_servicearea_fk
	FOREIGN KEY (Area)
	REFERENCES ServiceArea(Area);//Constraint 'AIRPORTS_SERVICEAREA_FK' is invalid: there is no unique or primary key constraint on table '"APP"."SERVICEAREA"' that matches the number and types of the columns in the foreign key.

ALTER TABLE Planes
	ADD CONSTRAINT planes_airlines_fk
	FOREIGN KEY (Airline_Name)
	REFERENCES Airlines (Airline_Name);

ALTER TABLE Flights
	ADD CONSTRAINT flights_ARRport_fk
	FOREIGN KEY (Arr_Port)
	REFERENCES Airports (FAA_Abbr);

ALTER TABLE Flights
	ADD CONSTRAINT flights_DEPTport_fk
	FOREIGN KEY (Dept_Port)
	REFERENCES Airports (FAA_Abbr);	
  
ALTER TABLE Flights
	ADD CONSTRAINT flights_airlines_fk
	FOREIGN KEY (Airline_Name)
	REFERENCES Airlines (Airline_Name);
	
ALTER TABLE Flights
	ADD CONSTRAINT flights_crew_fk
	FOREIGN KEY (Crew_Num)
	REFERENCES Crew (Crew_Num);

ALTER TABLE Cost
	ADD CONSTRAINT cost_flights_fk
	FOREIGN KEY (Flight_Num)
	REFERENCES Flights (Flight_Num);
	
ALTER TABLE GroundWorkers
	ADD CONSTRAINT ground_workers_fk
	FOREIGN KEY (Emp_ID)
	REFERENCES Personnel (Emp_ID);
	
ALTER TABLE FlightCrew
	ADD CONSTRAINT flight_member_fk
	FOREIGN KEY (Emp_ID)
	REFERENCES Personnel (Emp_ID);

ALTER TABLE FlightCrew
	ADD CONSTRAINT flight_crew_fk
	FOREIGN KEY (Crew_Num)
	REFERENCES Crew (Crew_Num);
	
ALTER TABLE IncidentReports
	ADD CONSTRAINT filed_incr_fk
	FOREIGN KEY (Filed_FAA)
	REFERENCES FlightCrew (FAA_Num);//Constraint 'FILED_INCR_FK' is invalid: there is no unique or primary key constraint on table '"APP"."FLIGHTCREW"' that matches the number and types of the columns in the foreign key.

ALTER TABLE IncidentReports
	ADD CONSTRAINT reported_incr_fk
	FOREIGN KEY (Reported_FAA)
	REFERENCES FlightCrew (FAA_Num);//Constraint 'REPORTED_INCR_FK' is invalid: there is no unique or primary key constraint on table '"APP"."FLIGHTCREW"' that matches the number and types of the columns in the foreign key.

ALTER TABLE IncidentReports
	ADD CONSTRAINT flight_incr_fk
	FOREIGN KEY (Flight_Num)
	REFERENCES Flights (Flight_Num);

INSERT INTO ServiceArea VALUES('Los Angeles');
INSERT INTO ServiceArea VALUES('New York');
INSERT INTO ServiceArea VALUES('Manila');
INSERT INTO ServiceArea VALUES('Seattle');
INSERT INTO ServiceArea VALUES('Tokyo');

INSERT INTO Airports VALUES('LAX','Los Angeles Airport','Los Angeles','Los Angeles');
INSERT INTO Airports VALUES('JFK','John F. Kennedy Airport',' New York','Newark');
INSERT INTO Airports VALUES('LBX','Long Beach Airport','Los Angeles','Long Beach');
INSERT INTO Airports VALUES('NRT','Narita International','Tokyo','Narita');
INSERT INTO Airports VALUES('LGA','LaGuardia Airport',' New York','LaGuardia');
INSERT INTO Airports VALUES('MNL','Ninoy Aquino International','Manila','Manila');
INSERT INTO Airports VALUES('ONT','Ontario Airport','Los Angeles','Ontario');
INSERT INTO Airports VALUES('CRK','Clark International','Manila','Pampanga');
INSERT INTO Airports VALUES('SEA','Seattle-Tacoma International','Seattle','Seattle');

INSERT INTO Flights VALUES(194,'JFK','LAX','8:00AM','1:30PM','2014-12-17',300,'Jet Blue',369);
INSERT INTO Flights VALUES(699,'ONT','LGA','4:00PM','8:00PM','2014-12-17',240,'Jet Blue',369);
INSERT INTO Flights VALUES(290,'LBX','SEA','6:00AM','8:00AM','2014-12-25',120,'SouthWest Airlines',414);
INSERT INTO Flights VALUES(138,'SEA','NRT','9:30AM','11:30PM','2014-12-25',870,'Air Japan',414);
INSERT INTO Flights VALUES(152,'NRT','CRK','12:00AM','1:30AM','2014-12-26',90,'Philippine Airlines',557);
INSERT INTO Flights VALUES(174,'MNL','CRK','5:30PM','6:00PM','2015-01-11',30,'Philippine Airlines',557);
INSERT INTO Flights VALUES(120,'LGA','SEA','2:30PM','4:00PM','2015-01-11',210,'American Airlines',369);
INSERT INTO Flights VALUES(395,'LAX','SEA','3:00PM','4:00PM','2015-01-11',180,'SouthWest Airlines',414);

INSERT INTO Airlines VALUES('American Airlines','Los Angeles','LAX','Domestic');
INSERT INTO Airlines VALUES('Jet Blue','New York','JFK','Domestic');
INSERT INTO Airlines VALUES('SouthWest Airlines','Dallas','LAX','Local');
INSERT INTO Airlines VALUES('Philippine Airlines','Manila','MNL','International');
INSERT INTO Airlines VALUES('Air Japan','Tokyo','NRT','International');

INSERT INTO Planes VALUES('Jet Blue','B135JB','Boeing','767',285,'Flash');
INSERT INTO Planes VALUES('American Airlines','A692AA','Arrow','777',420,'');
INSERT INTO Planes VALUES('SouthWest Airlines','B782SW','Boeing','747',500,'Black Widow');
INSERT INTO Planes VALUES('Philippine Airlines','B546PI','Boeing','747',605,'');

INSERT INTO Crew VALUES(369,3);
INSERT INTO Crew VALUES(414,4);
INSERT INTO Crew VALUES(557,5);

INSERT INTO Cost VALUES(194,'Bag Check',5.95);
INSERT INTO Cost VALUES(699,'Bag Check',3.45);
INSERT INTO Cost VALUES(152,'Bag Check',9.42);
INSERT INTO Cost VALUES(395,'Bag Check',2.78);
INSERT INTO Cost VALUES(138,'Bag Check',3.37);
INSERT INTO Cost VALUES(290,'Water',2.50);
INSERT INTO Cost VALUES(138,'Water',1.05);
INSERT INTO Cost VALUES(395,'Water',2.55);
INSERT INTO Cost VALUES(174,'Water',1.75);
INSERT INTO Cost VALUES(152,'Water',3.00);
INSERT INTO Cost VALUES(120,'Water',2.29);
INSERT INTO Cost VALUES(138,'Blankets',9.62);
INSERT INTO Cost VALUES(174,'Blankets',5.45);
INSERT INTO Cost VALUES(290,'Blankets',6.13);
INSERT INTO Cost VALUES(194,'Blankets',7.25);
INSERT INTO Cost VALUES(395,'Pillows',2.12);
INSERT INTO Cost VALUES(699,'Pillows',1.59);
INSERT INTO Cost VALUES(120,'Pillows',4.59);

INSERT INTO Personnel VALUES(3691,'Barry Allen','Flight Crew');
INSERT INTO Personnel VALUES(3692,'Diana Prince','Flight Crew');
INSERT INTO Personnel VALUES(3693,'Dinah Lance','Flight Crew');
INSERT INTO Personnel VALUES(3694,'Oliver Queen','Flight Crew');
INSERT INTO Personnel VALUES(3695,'Bruce Wayne','Flight Crew');
INSERT INTO Personnel VALUES(3696,'Jonn Jonzz','Flight Crew');
INSERT INTO Personnel VALUES(4141,'Steve Rogers','Flight Crew');
INSERT INTO Personnel VALUES(4142,'Clint Barton','Flight Crew');
INSERT INTO Personnel VALUES(4143,'Natasha Romanov','Flight Crew');
INSERT INTO Personnel VALUES(4148,'Thor Odinson','Flight Crew');
INSERT INTO Personnel VALUES(4149,'Loki Laufeyson','Flight Crew');
INSERT INTO Personnel VALUES(4144,'Pietro Maximoff','Flight Crew');
INSERT INTO Personnel VALUES(4145,'Maria Hill','Flight Crew');
INSERT INTO Personnel VALUES(5571,'Richard Grayson','Flight Crew');
INSERT INTO Personnel VALUES(5572,'Wally West','Flight Crew');
INSERT INTO Personnel VALUES(5573,'Connor Kent','Flight Crew');
INSERT INTO Personnel VALUES(5574,'Mgann Morzz','Flight Crew');
INSERT INTO Personnel VALUES(5575,'Artemis Crock','Flight Crew');
INSERT INTO Personnel VALUES(5576,'Kaldur Ahm','Flight Crew');
INSERT INTO Personnel VALUES(5577,'Zatanna Zatara','Flight Crew');
INSERT INTO Personnel VALUES(5578,'Roy Harper','Flight Crew');
INSERT INTO Personnel VALUES(2004,'Tony Stark','Ground Worker');
INSERT INTO Personnel VALUES(2005,'Bruce Banner','Ground Worker');
INSERT INTO Personnel VALUES(2006,'Nicholas Fury','Ground Worker');
INSERT INTO Personnel VALUES(2007,'Bucky Barnes','Ground Worker');
INSERT INTO Personnel VALUES(2010,'Clark Kent','Ground Worker');
INSERT INTO Personnel VALUES(2011,'Peter Parker','Ground Worker');

INSERT INTO FlightCrew VALUES(3692,'Diana Prince','Captain','F032',369);
INSERT INTO FlightCrew VALUES(3691,'Barry Allen','Navigator','F031',369);
INSERT INTO FlightCrew VALUES(3696,'Jonn Jonzz','Co-Pilot','F036',369);
INSERT INTO FlightCrew VALUES(3693,'Dinah Lance','Attendant','F033',369);
INSERT INTO FlightCrew VALUES(3695,'Bruce Wayne','Attendant','F035',369);
INSERT INTO FlightCrew VALUES(3694,'Oliver Queen','Attendant','F034',369);
INSERT INTO FlightCrew VALUES(4141,'Steve Rogers','Captain','F041',414);
INSERT INTO FlightCrew VALUES(4149,'Loki Laufeyson','Co-Pilot','F049',414);
INSERT INTO FlightCrew VALUES(4142,'Clint Barton','Navigator','F042',414);
INSERT INTO FlightCrew VALUES(4143,'Natasha Romanov','Attendant','F043',414);
INSERT INTO FlightCrew VALUES(4148,'Thor Odinson','Attendant','F048',414);
INSERT INTO FlightCrew VALUES(4145,'Maria Hill','Attendant','F045',414);
INSERT INTO FlightCrew VALUES(4144,'Pietro Maximoff','Attendant','F044',414);
INSERT INTO FlightCrew VALUES(5576,'Kaldur Ahm','Captain','F056',557);
INSERT INTO FlightCrew VALUES(5571,'Richard Grayson','Co-Pilot','F051',557);
INSERT INTO FlightCrew VALUES(5574,'Mgann Morzz','Navigator','F054',557);
INSERT INTO FlightCrew VALUES(5572,'Wally West','Attendant','F052',557);
INSERT INTO FlightCrew VALUES(5573,'Connor Kent','Attendant','F053',557);
INSERT INTO FlightCrew VALUES(5575,'Artemis Crock','Attendant','F055',557);
INSERT INTO FlightCrew VALUES(5577,'Zatanna Zatara','Attendant','F057',557);
INSERT INTO FlightCrew VALUES(5578,'Roy Harper','Attendant','F058',557);

INSERT INTO GroundWorkers VALUES(2004,'Tony Stark','Airplane Mechanic');
INSERT INTO GroundWorkers VALUES(2005,'Bruce Banner','Sr Researcher');
INSERT INTO GroundWorkers VALUES(2006,'Nicholas Fury','Flight Director');
INSERT INTO GroundWorkers VALUES(2007,'Bucky Barnes','Janitor');
INSERT INTO GroundWorkers VALUES(2010,'Clark Kent','Report Analyst');
INSERT INTO GroundWorkers VALUES(2011,'Peter Parker','Asst Researcher');

INSERT INTO IncidentReports VALUES(194,'F033','F034','Complaint','Back-sassing attitude.');
INSERT INTO IncidentReports VALUES(699,'F036','F031','Recognition','Quick thinking.');
INSERT INTO IncidentReports VALUES(699,'F032','F136','Recognition','Great co-pilot.');
INSERT INTO IncidentReports VALUES(194,'F035','F032','Recognition','Gracious captain.');
INSERT INTO IncidentReports VALUES(290,'F043','F049','Problem','Conflicting resolution.');
INSERT INTO IncidentReports VALUES(290,'F048','F049','Recognition','Gracious captain.');
INSERT INTO IncidentReports VALUES(290,'F045','F044','Concern','Not careful.');
INSERT INTO IncidentReports VALUES(138,'F049','F048','Complaint','Harrassment.');
INSERT INTO IncidentReports VALUES(138,'F042','F043','Complaint','Bossy and mean.');
INSERT INTO IncidentReports VALUES(138,'F043','F042','Complaint','Lazy.');
INSERT INTO IncidentReports VALUES(138,'F048','F041','Recognition','Noble leader.');
INSERT INTO IncidentReports VALUES(138,'F045','F041','Recognition','Stupendous captain.');
INSERT INTO IncidentReports VALUES(152,'F057','F055','Recognition','Efficient and wonderful.');
INSERT INTO IncidentReports VALUES(152,'F052','F056','Recognition','O captain, my captain.');
INSERT INTO IncidentReports VALUES(152,'F053','F054','Complaint','Nosy.');
INSERT INTO IncidentReports VALUES(152,'F054','F053','Concern','External anger mgmt issues.');
INSERT INTO IncidentReports VALUES(152,'F052','F055','Concern','Why so serious.');
INSERT INTO IncidentReports VALUES(174,'F055','F056','Complaint','Dilly-dallyer, bold.');
INSERT INTO IncidentReports VALUES(174,'F051','F056','Problem','Loyalites questionable.');
INSERT INTO IncidentReports VALUES(152,'F056','F051','Recognition','Clever thinking.');