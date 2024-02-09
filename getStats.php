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

    if (!$isAdmin) {
        echo json_encode(array(
            "success" => false,
            "message" => "You are not authorized",
        ));
        die();
    }


    $sql = "select count(*) as total_bookings from bookings where status = 'success'";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $total_bookings = $row['total_bookings'];

    $sql = "select count(*) as total_users from users";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $total_users = $row['total_users'];

    $sql = "select count(*) as total_vehicles from vehicles";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $total_vehicles = $row['total_vehicles'];

    //total income

    $sql = "select sum(amount) as total_income from bookings where status = 'success'";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $total_income = $row['total_income'];

    //this month income
    $sql = "select sum(amount) as this_month_income from bookings where status = 'success' and month(start_date) = month(now()) and year(start_date) = year(now())";
    $result = mysqli_query($CON, $sql);
    $row = mysqli_fetch_assoc($result);
    $this_month_income = $row['this_month_income'];


    echo json_encode(array(
        "success" => true,
        "message" => "Stats fetched successfully",
        "stats" => array(
            array(
                "label" => "Total Bookings",
                "value" => $total_bookings
            ),
            array(
                "label" => "Total Users",
                "value" => $total_users
            ),
            array(
                "label" => "Total Vehicles",
                "value" => $total_vehicles
            ),
            array(
                "label" => "Total Income",
                "value" => "Rs. " . ($total_income / 100) . "/-"
            ),
            array(
                "label" => "This Month Income",
                "value" => "Rs. " . ($this_month_income / 100) . "/-"
            )
        )
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Please provide token"
    ));
    die();
}
