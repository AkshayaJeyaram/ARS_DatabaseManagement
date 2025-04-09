<?php
$conn = new mysqli("localhost", "root", "", "AirlinesReservation");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO client (clientid, firstname, lastname, passportnum, airportid)
VALUES ('{$_POST['clientid']}', '{$_POST['firstname']}', '{$_POST['lastname']}', '{$_POST['passportnum']}', '{$_POST['airportid']}')";

if ($conn->query($sql) === TRUE) {
    echo "New client added successfully.";
} else {
    echo "Error: " . $conn->error;
}

$conn->close();
?>
