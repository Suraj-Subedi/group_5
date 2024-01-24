<?php


include("./helpers/connection.php");



function getUserId($token)
{
    global $CON;
    $sql = "select * from access_tokens where token = '$token'";
    $result = mysqli_query($CON, $sql);

    if (!$result) {
        return null;
    }

    if (mysqli_num_rows($result) == 0) {
        return null;
    }

    $row = mysqli_fetch_assoc($result);
    return $row['user_id'];
}


function isAdmin($userId)
{

    global $CON;
    $sql = "select * from users where user_id = '$userId'";
    $result = mysqli_query($CON, $sql);

    if (!$result) {
        return false;
    }

    if (mysqli_num_rows($result) == 0) {
        return false;
    }

    $row = mysqli_fetch_assoc($result);

    if ($row['role'] == 'admin') {
        return true;
    } else {
        return false;
    }
}
