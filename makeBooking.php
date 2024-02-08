<?php

include("./helpers/connection.php");
include("./helpers/auth.php");

if (isset($_POST['token'])) {
    $token = $_POST['token'];
    $user_id = getUserId($token);

    if (!$user_id) {
        echo json_encode(array(
            "success" => false,
            "message" => "Invalid token"
        ));
        die();
    }
    if (isset($_POST['vehicle_id'], $_POST['start_date'], $_POST['end_date'])) {
        $vehicle_id = $_POST['vehicle_id'];
        $start_date = $_POST['start_date'];
        $end_date = $_POST['end_date'];

        $sql = "select * from bookings where vehicle_id = $vehicle_id and ((start_date between '$start_date' and '$end_date') or (end_date between '$start_date' and '$end_date')) and status = 'success'";

        $result = mysqli_query($CON, $sql);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Vehicle already booked for the given dates"
            ));
            die();
        }

        $sql = "insert into bookings (vehicle_id, start_date, end_date, user_id) values ($vehicle_id, '$start_date', '$end_date', $user_id)";

        $result = mysqli_query($CON, $sql);

        $booking_id = mysqli_insert_id($CON);

        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Booking made successfully",
                "booking_id" => $booking_id
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to add booking"
            ));
            die();
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Please provide, vehicle_id, start_date, end_date"
        ));
        die();
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
    die();
}
