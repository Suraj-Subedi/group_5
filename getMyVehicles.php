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

    $sql = "select full_name, email,address,vehicles.*,category from vehicles inner join categories on vehicles.category_id = categories.category_id join users on vehicles.user_id = users.user_id where vehicles.user_id = $user_id";

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
        "message" => "vehicles fecched successfully",
        "vehicles" => $vehicles
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
}
