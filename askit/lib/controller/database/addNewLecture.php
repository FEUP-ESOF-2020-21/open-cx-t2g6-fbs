<?php
  require_once('db.php');


  $email = $_GET['email'];
  $title = $_GET['title'];
  $description = $_GET['description'];
  $capacity = $_GET['capacity'];
  $date = $_GET['date'];
  $url = $_GET['fileUrl'];

  $query = "INSERT INTO Lecture (Id, Title, Description, Capacity, Date, Attendance, Slides)
   VALUES (NULL, '";
  $query = $query . addslashes($title) . "', '" . addslashes($description) . "', " . $capacity . ", '" . $date . "', 0,";
  
  if ($url == "NULL"){
    $query = $query . " NULL);";
  }
  else{
    $query = $query . " '" . addslashes($url) . "');";
  }
  

  //echo $query;
  
  
  
  $stm = $db->prepare($query);
  $stm->execute();

  $last_id = $db->lastInsertId();

  $add_tuple_to_attends_query = "INSERT INTO Attends (Email, Id, Role) 
    VALUES('";
  $add_tuple_to_attends_query = $add_tuple_to_attends_query . addslashes($email) . "', " . $last_id . ", 'Lecturer');";
  echo "<br>";
  echo  $add_tuple_to_attends_query;

  $stm2 = $db->prepare($add_tuple_to_attends_query);
  $stm2->execute();
  


?>