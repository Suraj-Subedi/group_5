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


    if (isset($_POST['category_id'])) {
        $category_id = $_POST['category_id'];

        $sql = "select * from categories where category_id = $category_id";

        $result = mysqli_query($CON, $sql);

        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Category not found"
            ));
            die();
        }

        $category = mysqli_fetch_assoc($result);

        $isDeleted = $category['is_deleted'];

        $sql = '';

        if ($isDeleted == 0) {
            $sql = "update categories set is_deleted = 1 where category_id = $category_id";
        } else {
            $sql = "update categories set is_deleted = 0 where category_id = $category_id";
        }

        $result = mysqli_query($CON, $sql);

        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Category updated successfully"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to update category"
            ));
            die();
        }
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
    die();
}
