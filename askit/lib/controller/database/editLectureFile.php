<?php
  require_once('db.php');


  $lectureId = $_GET['lectureId'];
  $fileName = $_GET['fileUrl'];

  $query = "UPDATE Lecture SET Slides='$fileName' WHERE Id=$lectureId;";
  echo $query;
  
  
  $stm = $db->prepare($query);
  $stm->execute();


?>