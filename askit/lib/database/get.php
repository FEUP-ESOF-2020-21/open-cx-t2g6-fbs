<?php
  require_once('db.php');

  $query = "SELECT * FROM Lecture";
  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();
  
  
  
  //Testing filter variables
  echo $_GET['timeFilter'] . "\n" . $_GET['Lecturer'] . "\n" . $_GET['Attendee'] . "\n";

  //Printing values of each lecture present in the database
  foreach($results as $row){
    echo "Id: " . $row["Id"] . "\n"; 
    echo "Title: " . $row["Title"] . "\n";
    echo "Description: " . $row["Description"] . "\n";
    echo "Capacity: " . $row["Capacity"] . "\n";
    echo "Date: " . $row["Date"] . "\n\n";
  }

?>