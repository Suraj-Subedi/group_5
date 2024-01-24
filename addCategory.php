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


    if (isset($_POST['category_name'])) {
        $category_name = $_POST['category_name'];


        $sql = "insert into categories (category) values ('$category_name')";

        $result = mysqli_query($CON, $sql);

        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Category added successfully"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to add category"
            ));
            die();
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "Category name is required"
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
