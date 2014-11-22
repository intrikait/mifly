connect 'jdbc:derby:albumsdb;create=true';

CREATE TABLE ServiceArea
(
	Area		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_servicearea PRIMARY KEY (Area)
);

CREATE TABLE Airports
(
	Port_Name	VARCHAR(20) NOT NULL,
	Location	VARCHAR(20) NOT NULL,
	FAA_abbr	VARCHAR(3) NOT NULL,
	CONSTRAINT pk_airports PRIMARY KEY (FAA_abbr)
);
  
CREATE TABLE Flights
(
	Length		INTEGER(3) NOT NULL,
	Dept_Time	TIME NOT NULL,
	Arr_Time	TIME NOT NULL,
	Date		DATE NOT NULL,
	CONSTRAINT pk_flights PRIMARY KEY (Dept_Time,Arr_Time,Date)
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
	FAA_Tail	VARCHAR(20) NOT NULL,
	Manufacturer	VARCHAR(20) NOT NULL,
	Model_Num	VARCHAR(20) NOT NULL,
	Num_Pssgrs	VARCHAR(20) NOT NULL,
	Plane_Name	VARCHAR(20),
	CONSTRAINT pk_planes PRIMARY KEY (FAA_Tail)
);

CREATE TABLE Crew
(
	Attndt_Qty	INTEGER(3) NOT NULL,
	CONSTRAINT pk_crew PRIMARY KEY (FAA_Tail)
);

CREATE TABLE Cost
(
	Type		VARCHAR(20) NOT NULL,
	Cost		INTEGER(3) NOT NULL,
	Check_Bags	BOOLEAN NOT NULL,
	CONSTRAINT pk_cost PRIMARY KEY (FAA_Tail)
);

CREATE TABLE Personnel
(
	Emp_ID		INTEGER(4) NOT NULL,
	Emp_Name	VARCHAR(20) NOT NULL,
	Type		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_flightcrew PRIMARY KEY (Emp_ID)
);

CREATE TABLE FlightCrew
(
	Emp_Name	VARCHAR(20) NOT NULL,
	Job		VARCHAR(20) NOT NULL,
	FAA_num		INTEGER(4) NOT NULL,
	CONSTRAINT pk_flightcrew PRIMARY KEY (FAA_num)
);

CREATE TABLE GroundWorkers
(
	Emp_Name	VARCHAR(20) NOT NULL,
	Job		VARCHAR(20) NOT NULL,
	FAA_num		INTEGER(4) NOT NULL,
	CONSTRAINT pk_flightcrew PRIMARY KEY (FAA_num)
);

CREATE TABLE IncidentReports
(
	Emp_Name	VARCHAR(20) NOT NULL,
	Job		VARCHAR(20) NOT NULL,
	FAA_num		INTEGER(4) NOT NULL,
	CONSTRAINT pk_flightcrew PRIMARY KEY (FAA_num)
);

ALTER TABLE albums
          ADD CONSTRAINT groups_albums_fk
          FOREIGN KEY (g_name),
          REFERENCES groups (g_name);
		  
ALTER TABLE albums
          ADD CONSTRAINT studios_albums_fk
          FOREIGN KEY (s_name),
          REFERENCES studios (s_name);
		  
INSERT INTO groups VALUES('Paramore','Haley Williams','2004','alternative rock');
INSERT INTO groups VALUES('Queen','Freddie Mercury','1970','opera rock');
INSERT INTO groups VALUES('Simple Plan','Pierre Bouvier','1999','rock');
INSERT INTO groups VALUES('Relient K','Matt Thiessen','1998','alternative rock');
INSERT INTO groups VALUES('Weezer','Rivers Cuomo','1992','indie rock');

INSERT INTO albums VALUES('Riot!','Paramore','Atlantic Records','06-12-2007','38:58',11);
INSERT INTO albums VALUES('Queen','Queen','Atlantic Records','07-13-1973','38:36',10);
INSERT INTO albums VALUES('Flash Gordon','Queen','Republic Records','12-08-1981','35:01',18);
INSERT INTO albums VALUES('Simple Plan','Simple Plan','Atlantic Records','02-12-1008','43:33',11);
INSERT INTO albums VALUES('Still Not Getting Any...','Simple Plan','Lava Records','10-26-2004','44:27',12);
INSERT INTO albums VALUES('Two Lefts Dont Make a Right','Relient K','Lava Records','03-11-2003','59:34',15);
INSERT INTO albums VALUES('Mmhmm','Relient K','Capitol Records','11-02-2004','50:22',14);
INSERT INTO albums VALUES('Five Score and Seven Years Ago','Relient K','Capitol Records','03-06-2007','51:12',14);
INSERT INTO albums VALUES('Wheezer','Wheezer','Republic Records','06-03-2008','41:23',10);
INSERT INTO albums VALUES('Everything Will Be Alright in the End','Wheezer','Republic Records','10-07-2014','42:24',13);

INSERT INTO studios VALUES('Atlantic Records','3400 W Olive Ave, Burbank, CA','Warner Bros','818-238-2200');
INSERT INTO studios VALUES('Lava Records','3400 W Olive Ave, Burbank, CA','Jason Flom','818-238-6900');
INSERT INTO studios VALUES('Capitol Records','1750 Vine St, Los Angeles, CA','Johnny Mercer','323-462-6252');
INSERT INTO studios VALUES('Republic Records','1755 Broadway, New York, NY','Monte Lipman','212-841-5100');