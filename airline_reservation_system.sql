-- =============================
-- Airline Reservation System SQL Script
-- =============================

-- Create Database
CREATE DATABASE AirlinesReservation;
USE AirlinesReservation;

-- Airport Table
CREATE TABLE airport (
  airportid CHAR(2) PRIMARY KEY,
  airportname VARCHAR(25) NOT NULL,
  city VARCHAR(15) NOT NULL,
  country VARCHAR(15) NOT NULL
);

-- Client Table
CREATE TABLE client (
  clientid CHAR(2) PRIMARY KEY,
  lastname VARCHAR(10),
  firstname VARCHAR(10),
  passportnum CHAR(8),
  airportid CHAR(2),
  FOREIGN KEY (airportid) REFERENCES airport(airportid)
);

-- Booking Table
CREATE TABLE booking (
  bookingnum CHAR(5) PRIMARY KEY,
  clientid CHAR(2),
  price NUMERIC(6,2) NOT NULL,
  FOREIGN KEY (clientid) REFERENCES client(clientid)
);

-- Airlines Table
CREATE TABLE airlines (
  airlinesid CHAR(2) PRIMARY KEY,
  mainoffice VARCHAR(15) NOT NULL
);

-- Flight Status Table
CREATE TABLE flightstatus (
  statusid CHAR(2) PRIMARY KEY,
  departuretime VARCHAR(10),
  departuredate DATE,
  arrivaltime VARCHAR(10),
  arrivaldate DATE
);

-- Flight Table
CREATE TABLE flight (
  flightid CHAR(2) PRIMARY KEY,
  originairportid CHAR(2),
  destairportid CHAR(2),
  statusid CHAR(2),
  airlinesid CHAR(2),
  returnflightid CHAR(2),
  FOREIGN KEY (originairportid) REFERENCES airport(airportid),
  FOREIGN KEY (destairportid) REFERENCES airport(airportid),
  FOREIGN KEY (statusid) REFERENCES flightstatus(statusid),
  FOREIGN KEY (airlinesid) REFERENCES airlines(airlinesid),
  FOREIGN KEY (returnflightid) REFERENCES flight(flightid)
);

-- Aircraft Table
CREATE TABLE aircraft (
  aircraftid CHAR(2) PRIMARY KEY,
  model VARCHAR(15),
  flightid CHAR(2),
  FOREIGN KEY (flightid) REFERENCES flight(flightid)
);

-- Components Table
CREATE TABLE components (
  componentsid CHAR(3) PRIMARY KEY,
  componentsname VARCHAR(10)
);

-- Manufacturer Table
CREATE TABLE manufacturer (
  manuid CHAR(3) PRIMARY KEY,
  manuname VARCHAR(10)
);

-- Provides Table
CREATE TABLE provides (
  manuid CHAR(3),
  componentsid CHAR(3),
  aircraftid CHAR(2),
  PRIMARY KEY (manuid, componentsid, aircraftid),
  FOREIGN KEY (manuid) REFERENCES manufacturer(manuid),
  FOREIGN KEY (componentsid) REFERENCES components(componentsid),
  FOREIGN KEY (aircraftid) REFERENCES aircraft(aircraftid)
);

-- Travel Class Table
CREATE TABLE travelclass (
  classid CHAR(2) PRIMARY KEY,
  classname VARCHAR(10),
  classdescription VARCHAR(20),
  refreshments VARCHAR(15)
);

-- Aircraft Seat Table
CREATE TABLE aircraftseat (
  seatnum CHAR(5) PRIMARY KEY,
  aircraftid CHAR(2),
  classid CHAR(2),
  FOREIGN KEY (classid) REFERENCES travelclass(classid),
  FOREIGN KEY (aircraftid) REFERENCES aircraft(aircraftid)
);

-- Trigger: Ensure departure is before arrival
DELIMITER //
CREATE TRIGGER flightstatus_BEFORE_INSERT
BEFORE INSERT ON flightstatus
FOR EACH ROW
BEGIN
  DECLARE msg VARCHAR(200);
  IF NEW.departuredate < NEW.arrivaldate THEN
    SET msg = CONCAT('Error: Departure date earlier than arrival date for status ID ', NEW.statusid);
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
  END IF;
END;//
DELIMITER ;

-- Sample Data Insertion
INSERT INTO airport VALUES ('A1', 'Heathrow', 'London', 'UK'), ('A2', 'JFK', 'New York', 'USA');
INSERT INTO client VALUES ('C1', 'Doe', 'John', 'AB123456', 'A1');
INSERT INTO booking VALUES ('B001', 'C1', 499.99);
INSERT INTO airlines VALUES ('AL', 'London');
INSERT INTO flightstatus VALUES ('S1', '10:00', '2024-06-01', '14:00', '2024-06-01');
INSERT INTO flight VALUES ('F1', 'A1', 'A2', 'S1', 'AL', NULL);
INSERT INTO aircraft VALUES ('AC', 'Boeing 737', 'F1');
INSERT INTO components VALUES ('CMP', 'Engine');
INSERT INTO manufacturer VALUES ('MFG', 'Rolls');
INSERT INTO provides VALUES ('MFG', 'CMP', 'AC');
INSERT INTO travelclass VALUES ('EC', 'Economy', 'Standard seat', 'Snacks');
INSERT INTO aircraftseat VALUES ('1A', 'AC', 'EC');
