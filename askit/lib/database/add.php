<?php
  require_once('db.php');

  
  
  $title = $_GET['title'];
  
  $description = $_GET['description'];
  $capacity = $_GET['capacity'];
  $date = $_GET['date'];

  $query = "INSERT INTO Lecture (Id, Title, Description, Capacity, Date)
   VALUES (NULL, '";
  $query = $query . addslashes($title) . "', '" . addslashes($description) . "', " . $capacity . ", '" . $date . "');";
  

  echo $query;
  

  
  $stm = $db->prepare($query);
  $stm->execute();

?>