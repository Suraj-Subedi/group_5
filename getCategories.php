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

    $sql = "select * from categories";

    $result = mysqli_query($CON, $sql);

    $categories = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $categories[] = $row;
    }

    echo json_encode(array(
        "success" => true,
        "categories" => $categories
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
}
