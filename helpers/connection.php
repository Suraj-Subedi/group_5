<?php

$host = 'localhost';
$user = 'root';
$password = '';
$db = 'ecom5';

$CON = mysqli_connect($host, $user, $password, $db);


if (!$CON) {
    echo "Connection Failed";
}
