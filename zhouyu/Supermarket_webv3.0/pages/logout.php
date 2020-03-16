<?php
    include '../config/session.php';
    unset($_SESSION['uid']);
    unset($_SESSION['pw']);
    session_destroy();
    header('Location:login.php');
?>

