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


    if (isset($_POST['vehicle_id'], $_POST['rating'])) {
        $vehicle_id = $_POST['vehicle_id'];
        $rating = $_POST['rating'];
        $review = null;
        if (isset($_POST['review'])) {
            $review = $_POST['review'];
        }

        $query = "SELECT * FROM reviews WHERE user_id = '$user_id' AND vehicle_id = '$vehicle_id'";

        $result = mysqli_query($CON, $query);



        if (mysqli_num_rows($result) > 0) {
            $query = "UPDATE reviews SET rating = '$rating', review_message = '$review' WHERE user_id = '$user_id' AND vehicle_id = '$vehicle_id'";
        } else {
            $query = "INSERT INTO reviews (user_id, vehicle_id, rating,review_message) VALUES ('$user_id', '$vehicle_id', '$rating','$review')";
        }


        $result = mysqli_query($CON, $query);

        if ($result) {

            $query = "SELECT AVG(rating) as average_rating FROM reviews WHERE vehicle_id = '$vehicle_id'";

            $result = mysqli_query($CON, $query);

            $row = mysqli_fetch_assoc($result);

            $average_rating = $row['average_rating'];

            $query = "UPDATE vehicles SET rating = '$average_rating' WHERE vehicle_id = '$vehicle_id'";

            $result = mysqli_query($CON, $query);

            echo json_encode(array(
                "success" => true,
                "message" => "Rating added successfully",
                "rating" => $average_rating
            ));
        } else {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to add rating"
            ));
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "vehicle_id and rating are required, review is optional"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Token not found"
    ));
    die();
}
