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

    $sql = "select full_name, email,address,role from users where user_id = $user_id";

    $result = mysqli_query($CON, $sql);

    $user = mysqli_fetch_assoc($result);

    echo json_encode(array(
        "success" => true,
        "message" => "User details fetched successfully",
        "user" => $user
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
}
