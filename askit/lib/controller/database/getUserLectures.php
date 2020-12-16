<?php
  require_once('db.php');
  require_once('auxiliaryFunctions.php');

  $email = $_GET['email'];
  $timeFilter = $_GET['timeFilter'];
  $isLecturer = $_GET['Lecturer'];
  $isAttendee = $_GET['Attendee'];


  
  $query = "SELECT * FROM Lecture NATURAL JOIN Attends WHERE Email='";
  $query = $query . addslashes($email) . "'";
  if ($isLecturer=='true' and $isAttendee=='true'){
    //Do nothing
  }
  else{

   if ($isAttendee == 'true'){
      $query = $query . " AND Role='Attendee'";
    }
    else if ($isLecturer == 'true'){
      $query = $query . " AND Role='Lecturer'";
    }
  }
  $query = $query . ";";
  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();
  
 
  if ($isAttendee == 'true' or $isLecturer == 'true'){
    if ($timeFilter == "previous"){
      printPreviousLectures($results);
    }
    else if ($timeFilter == "upcoming"){
      printUpcomingLectures($results);
    }
  }

?>