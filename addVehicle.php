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

    if (
        isset(
            $_POST['vehicle_name'],
            $_POST['description'],
            $_POST['per_day_price'],
            $_POST['category_id'],
            $_FILES['image']

        )
    ) {

        $vehicle_name = $_POST['vehicle_name'];
        $description = $_POST['description'];
        $per_day_price = $_POST['per_day_price'];
        $category_id = $_POST['category_id'];
        $image = $_FILES['image'];







        $image_name = $image['name'];
        $image_tmp_location = $image['tmp_name'];
        $image_extension = pathinfo($image_name, PATHINFO_EXTENSION);

        $allowed_extensions = array("jpg", "jpeg", "png", "webp");

        if (!in_array($image_extension, $allowed_extensions)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Only images are allowed , jpg, jpeg, png, webp"
            ));
            die();
        }


        $image_size = $image['size'];

        if ($image_size > (5 * 1024 * 1024)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Image size should be less than 5MB"
            ));
            die();
        }

        $new_image_name = time() . "-" . rand(10000, 1000000)  . "." . $image_extension;
        $new_location = "./images/" . $new_image_name;
        $image_url = "\/images/" . $new_image_name;

        if (!move_uploaded_file($image_tmp_location, $new_location)) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to upload image"
            ));
            die();
        }

        $sql = "insert into vehicles (name, description, per_day_price, category_id, image_url,user_id) values ('$vehicle_name', '$description', '$per_day_price', '$category_id', '$image_url','$user_id')";

        $result = mysqli_query($CON, $sql);

        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Vehicle added successfully"
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to add vehicle"
            ));
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "vehicle_name, description, per_day_price, category_id, image are required"
        ));
        die();
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
}
