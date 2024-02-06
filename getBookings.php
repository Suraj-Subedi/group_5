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

    $isAdmin = isAdmin($user_id);

    $sql = '';

    if ($isAdmin) {
        $sql = "select full_name,email,address,bookings.*,vehicles.*,category from bookings join users on bookings.user_id = users.user_id join vehicles on bookings.vehicle_id = vehicles.vehicle_id join categories on vehicles.category_id = categories.category_id";
    } else {
        $sql = "select full_name,email,address,bookings.*,vehicles.*,category from bookings join users on bookings.user_id = users.user_id join vehicles on bookings.vehicle_id = vehicles.vehicle_id join categories on vehicles.category_id = categories.category_id where bookings.user_id = $user_id";
    }

    $result = mysqli_query($CON, $sql);

    $bookings = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $bookings[] = $row;
    }

    echo json_encode(array(
        "success" => true,
        "message" => "Bookings fetched successfully",
        "bookings" => $bookings
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Please provide token"
    ));
    die();
}
