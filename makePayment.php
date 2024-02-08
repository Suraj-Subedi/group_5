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
    if (isset($_POST['booking_id'], $_POST['amount'])) {
        $booking_id = $_POST['booking_id'];
        $amount = $_POST['amount'];

        $sql = "select * from bookings where booking_id = $booking_id";

        $result = mysqli_query($CON, $sql);

        if (mysqli_num_rows($result) == 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Invalid booking_id"
            ));
            die();
        }

        $booking = mysqli_fetch_assoc($result);

        $status = $booking['status'];
        $start_date = $booking['start_date'];
        $end_date = $booking['end_date'];
        $vehicle_id = $booking['vehicle_id'];

        if ($status == 'success') {
            echo json_encode(array(
                "success" => false,
                "message" => "Payment already made"
            ));
            die();
        }

        if ($status == 'cancelled') {
            echo json_encode(array(
                "success" => false,
                "message" => "Booking already cancelled"
            ));
            die();
        }

        $sql = "select * from bookings where vehicle_id = $vehicle_id and ((start_date between '$start_date' and '$end_date') or (end_date between '$start_date' and '$end_date')) and status = 'success'";

        $result = mysqli_query($CON, $sql);

        if (mysqli_num_rows($result) > 0) {
            echo json_encode(array(
                "success" => false,
                "message" => "Vehicle already booked for the given dates"
            ));
            die();
        }

        $sql = "update bookings set status = 'success', amount = $amount where booking_id = $booking_id";



        $result = mysqli_query($CON, $sql);

        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Payment made successfully"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to make payment"
            ));
            die();
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Please provide booking_id, amount"
        ));
        die();
    }

    $result = mysqli_query($CON, $sql);

    if (mysqli_num_rows($result) > 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "Vehicle already booked for the given dates"
        ));
        die();
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Please provide a token"
    ));
    die();
}
