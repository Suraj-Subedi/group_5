<?php

include("./helpers/connection.php");
include("./helpers/auth.php");

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';

if (isset($_POST['email'])) {
    $email = $_POST['email'];

    $sql = "select * from users where email = '$email'";
    $result = mysqli_query($CON, $sql);

    if (mysqli_num_rows($result) > 0) {
        $user = mysqli_fetch_assoc($result);
        $user_id = $user['user_id'];
        $fullName = $user['full_name'];

        //6 digit random number
        $otp = rand(100000, 999999);

        $sql = "update users set code = $otp where user_id = $user_id";
        $result = mysqli_query($CON, $sql);

        if (!$result) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send code"
            ));
            die();
        }

        $mail = new PHPMailer();
        $mail->isSMTP();
        $mail->SMTPDebug = 0;
        $mail->Host = 'smtp.titan.email';
        $mail->SMTPAuth = true;
        $mail->Username = 'noreply@quizhunt.online';
        $mail->Password = 'b7Ni-YrrUaHuy?2';
        $mail->SMTPSecure = 'ssl';
        ///driver
        $mail->Port = 465;
        $mail->SMTPOptions = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true
            )
        );


        $mail->Subject = 'Pahuna Ghar Password Reset';
        $mail->Body    = "Your password reset code for Pahuna Ghar $otp";

        $mail->setFrom('noreply@quizhunt.online', 'Pahuna Ghar');        // Set sender of the mail          // Add a recipient
        $mail->addAddress("$email", "$fullName");  // Add a recipient
        // Add a recipient

        if (!$mail->send()) {
            echo json_encode(array(
                "success" => false,
                "message" => "Failed to send code $mail->ErrorInfo"
            ));
            die();
        } else {
            echo json_encode(array(
                "success" => true,
                "message" => "Password reset link sent to your email"
            ));
        }
    } else {
        echo json_encode(array(
            "success" => false,
            "message" => "User not found"
        ));
    }
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "Email is required"
    ));
    die();
}
