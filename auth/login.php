<?php
include("../helpers/connection.php");

if (isset($_POST['email'], $_POST['password'])) {

    $email = $_POST['email'];
    $password = $_POST['password'];

    global $CON;

    $sql = "select * from users where email = '$email'";

    $result = mysqli_query($CON, $sql);

    $count = mysqli_num_rows($result);

    if ($count == 0) {
        echo json_encode(array(
            "success" => false,
            "message" => "User not found!"
        ));
        die();
    }

    $user = mysqli_fetch_assoc($result);
    $hashedPassword = $user['password'];

    $isCorrectPassword = password_verify($password, $hashedPassword);


    if (!$isCorrectPassword) {
        echo json_encode(array(
            "success" => false,
            "message" => "Incorrect password"
        ));
        die();
    }

    $token =  bin2hex(random_bytes(32));

    $user_id = $user['user_id'];
    $role = $user['role'];


    $sql = "insert into access_tokens (token,user_id) values('$token','$user_id')";

    $result = mysqli_query($CON, $sql);

    if (!$result) {
        echo json_encode(array(
            "success" => false,
            "message" => "Failed to logged in"
        ));
    } else {
        echo json_encode(array(
            "success" => true,
            "message" => "Logged in successfully!",
            "token" => $token,
            "role" => $role
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Email and password is required"
    ));
}
