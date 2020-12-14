<?php
  require_once('db.php');
  require_once('auxiliaryFunctions.php');


  $email = $_GET['email'];
  $lectureId = $_GET['lectureId'];
  
  //Insert record into Attends Table
  $query = "INSERT INTO Attends(Email, Id, Role) Values('";
  $query = $query . addslashes($email) . "', " . $lectureId . ", 'Attendee');";

  echo $query;
  
  $stm = $db->prepare($query);
  $stm->execute();

  //Update Lecture table to increase the attendance of said lecture
  //!!!NOT NEEDED because Trigger was created in the database !!!
  /*
  $query_update = "UPDATE Lecture Set Attendance = Attendance+1 Where Id=";
  $query_update = $query_update . $lectureId . ";";
  echo $query_update;

  $stm_update = $db->prepare($query_update);
  $stm_update->execute();*/



?>