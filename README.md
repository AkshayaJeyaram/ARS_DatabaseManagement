# Airline Reservation System (DBMS Project)

A mini project developed using MySQL and PHP that simulates a simple airline reservation system. Built for academic purposes to demonstrate database design, normalization, triggers, joins, and data handling.

## Features
- Stores flight, client, aircraft, and booking data.
- Implements SQL queries including joins, aggregation, nested queries.
- Validates logical constraints with a trigger.
- Frontend interface to insert and view client data (PHP + HTML).
- Sample dataset for testing.

## Tech Stack
- MySQL
- PHP
- HTML


## How to Run
1. Import `airline_reservation_system.sql` into your MySQL server.
2. Place the PHP files inside your XAMPP/Apache `htdocs` folder.
3. Access `index.html` in your browser (e.g., http://localhost/index.html).
4. Use the form to add/view clients.

## Sample Query

SELECT clientid, lastname, firstname
FROM client
WHERE airportid = (
  SELECT airportid FROM client WHERE firstname = 'Brantly' AND lastname = 'Morgan'
);

Future Improvements
Add UI for more entities (flights, bookings).

Extend to support login system.

Export reports and statistics.
