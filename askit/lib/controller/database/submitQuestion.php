<?php
  require_once('db.php');


  
  $question = $_GET['question'];
  $email = $_GET['email'];
  $lectureId = $_GET['lectureId'];
  $slide = $_GET['slide'];
 
  $date = date("Y-m-d-H-i");
  //echo $date;
  $query = "INSERT INTO Question(Question, Rating, Slide, UserEmail, LectureId, TimePosted)
   VALUES ('";
  $query = $query . addslashes($question) . "', 0, " . $slide . ", '" . addslashes($email) . "', $lectureId, '$date');";
  

  //echo $query;
  

  
  $stm = $db->prepare($query);
  $stm->execute();

?>