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

    $sql = "select * from vehicles";

    $result = mysqli_query($CON, $sql);

    // if (!$result) {
    //     echo json_encode(array(
    //         "success" => false,
    //         "message" => "Failed to fetch vehicles"
    //     ));
    //     die();
    // }

    $vehicles = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $vehicles[] = $row;
    }

    echo json_encode(array(
        "success" => true,
        "vehicles" => $vehicles
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
}
