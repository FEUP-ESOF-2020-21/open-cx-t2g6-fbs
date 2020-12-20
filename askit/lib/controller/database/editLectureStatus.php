<?php
  require_once('db.php');


  $lectureId = $_GET['lectureId'];
  $status = $_GET['status'];

  $query = "UPDATE Lecture SET Status='$status' WHERE Id=$lectureId;";
  echo $query;
  
  
  $stm = $db->prepare($query);
  $stm->execute();


?>