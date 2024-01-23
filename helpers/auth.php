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
