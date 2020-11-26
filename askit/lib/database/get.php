<?php
  require_once('db.php');

  $query = "SELECT * FROM Lecture";
  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();
  
  
  $timeFilter = $_GET['timeFilter'];

  echo $_GET['timeFilter'] . "\n" . $_GET['Lecturer'] . "\n" . $_GET['Attendee'] . "\n";

  if ($timeFilter == "previous"){
    printPreviousLectures($results);
  }
  else if ($timeFilter == "upcoming"){
    printUpcomingLectures($results);
  }
  
  function printPreviousLectures($results){
    foreach($results as $row){
      if ($row["Date"] < date("Y-m-d")){
        printLecture($row);
      }
    }
  }

  function printUpcomingLectures($results){
    foreach($results as $row){
      if ($row["Date"] >= date("Y-m-d")){
        printLecture($row);
      }
    }
  }

  function printLecture($row){
    echo $row["Id"] . "\n"; 
        echo $row["Title"] . "\n";
        echo $row["Description"] . "\n";
        echo $row["Date"] . "\n";
        echo $row["Capacity"] . "\n";
  }
?>
