connect 'jdbc:derby:mifly;create=true';

CREATE TABLE ServiceArea
(
	Area		VARCHAR(15) NOT NULL,
	CONSTRAINT pk_servicearea PRIMARY KEY (Area)
);

CREATE TABLE Airports
(
	FAA_Abbr	VARCHAR(3) NOT NULL,
	Port_Name	VARCHAR(20) NOT NULL,
	Area		VARCHAR(20) NOT NULL,
	Location	VARCHAR(20) NOT NULL,
	CONSTRAINT pk_airports PRIMARY KEY (FAA_Abbr)
);
  
CREATE TABLE Flights
(
	Flight_Num	INTEGER(3) NOT NULL,
	Arr_Port	VARCHAR(3) NOT NULL,
	Dept_Port	VARCHAR(3) NOT NULL,
	Time_Stamp	VARCHAR(7) NOT NULL,
	F_Date		DATE NOT NULL,
	F_Length	INTEGER(3) NOT NULL,
	Airline_Name	VARCHAR(20) NOT NULL,
	Crew_Num	INTEGER(4) NOT NULL,
	CONSTRAINT pk_flights PRIMARY KEY (Flight_Num,Dept_Time,Arr_Time,F_Date)
);
  
CREATE TABLE Airlines
(
	Airline_Name	VARCHAR(20) NOT NULL,
	City		VARCHAR(20) NOT NULL,
	Fly_Type	VARCHAR(20) NOT NULL,
	CONSTRAINT pk_airlines PRIMARY KEY (Airline_Name)
);

CREATE TABLE Planes
(
	Airline_Name VARCHAR(20) NOT NULL,
	FAA_Tail	VARCHAR(6) NOT NULL,
	Manufacturer	VARCHAR(20) NOT NULL,
	Model_Num	VARCHAR(20) NOT NULL,
	Num_Pssgrs	INTEGER(3) NOT NULL,
	Plane_Name	VARCHAR(20),
	CONSTRAINT pk_planes PRIMARY KEY (FAA_Tail)
);

CREATE TABLE Crew
(
	Crew_Num	INTEGER(4) NOT NULL,
	Attndt_Qty	INTEGER(3) NOT NULL,
	CONSTRAINT pk_crew PRIMARY KEY (Crew_Num)
);

CREATE TABLE Cost
(
	Flight_Num	INTEGER(3) NOT NULL,
	C_Type		VARCHAR(20) NOT NULL,
	Cost		INTEGER(3) NOT NULL,
	CONSTRAINT pk_cost PRIMARY KEY (C_Type)
);

CREATE TABLE Personnel
(
	Emp_ID		INTEGER(4) NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	E_Type		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_personnel PRIMARY KEY (Emp_ID)
);

CREATE TABLE FlightCrew
(
	Emp_ID		INTEGER(4) NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	Job		VARCHAR(20) NOT NULL,
	FAA_Num		INTEGER(4) NOT NULL,
	Crew_Num		INTEGER(3) NOT NULL,
	CONSTRAINT pk_flightcrew PRIMARY KEY (Emp_ID)
);

CREATE TABLE GroundWorkers
(
	Emp_ID		INTEGER(4) NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	Job			VARCHAR(20) NOT NULL,
	CONSTRAINT pk_groundworkers PRIMARY KEY (Emp_ID)
);

CREATE TABLE IncidentReports
(
	Date_Filed		DATE NOT NULL,
	Filed_FAA		INTEGER(4) NOT NULL,
	Reported_FAA	INTEGER(4) NOT NULL,
	Inc_Type		VARCHAR(20) NOT NULL,
	Inc_Desc		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_increports PRIMARY KEY (Date_Filed,Filed_FAA,Reported_FAA)
);

ALTER TABLE Airports
	ADD CONSTRAINT airports_servicearea_fk
	FOREIGN KEY (Area),
	REFERENCES ServiceArea (Area);

ALTER TABLE Planes
	ADD CONSTRAINT planes_airlines_fk
	FOREIGN KEY (Airline_Name),
	REFERENCES Airlines (Airline_Name);

ALTER TABLE Flights
	ADD CONSTRAINT flights_ARRport_fk
	FOREIGN KEY (Arr_Port),
	REFERENCES Airports (FAA_Abbr);

ALTER TABLE Flights
	ADD CONSTRAINT flights_DEPTport_fk
	FOREIGN KEY (Dept_Port),
	REFERENCES Airports (FAA_Abbr);	
  
ALTER TABLE Flights
	ADD CONSTRAINT flights_airlines_fk
	FOREIGN KEY (Airline_Name),
	REFERENCES Airlines (Airline_Name);
	
ALTER TABLE Flights
	ADD CONSTRAINT flights_crew_fk
	FOREIGN KEY (Crew_Num),
	REFERENCES Crew (Crew_Num);

ALTER TABLE Cost
	ADD CONSTRAINT cost_flights_fk
	FOREIGN KEY (Flight_Num),
	REFERENCES Flights (Flight_Num);
	
ALTER TABLE GroundWorkers
	ADD CONSTRAINT ground_workers_fk
	FOREIGN KEY (Emp_ID),
	REFERENCES Personnel (Emp_ID);
	
ALTER TABLE FlightCrew
	ADD CONSTRAINT flight_member_fk
	FOREIGN KEY (Emp_ID),
	REFERENCES Personnel (Emp_ID);

ALTER TABLE FlightCrew
	ADD CONSTRAINT flight_crew_fk
	FOREIGN KEY (Crew_Num),
	REFERENCES Crew (Crew_Num);
	
ALTER TABLE Crew
	ADD CONSTRAINT crew_flightcrew_fk
	FOREIGN KEY (FAA_Num),
	REFERENCES FlightCrew (FAA_Num);
	
ALTER TABLE IncidentReports
	ADD CONSTRAINT filed_incr_fk
	FOREIGN KEY (Filed_FAA),
	REFERENCES FlightCrew (FAA_Num);

ALTER TABLE IncidentReports
	ADD CONSTRAINT reported_incr_fk
	FOREIGN KEY (Reported_FAA),
	REFERENCES FlightCrew (FAA_Num);	

