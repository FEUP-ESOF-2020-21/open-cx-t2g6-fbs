<?php
  require_once('db.php');
  require_once('auxiliaryFunctions.php');


  $lectureId = $_GET['lectureId'];
  $email = $_GET['email'];
  
  $query = "Select Role from Attends Where Id=$lectureId AND Email='$email'";
  $stm = $db->prepare($query);
  $stm->execute();
  $result = $stm->fetchAll();
  foreach ($result as $row){
    echo $row['Role'];
  }

?>