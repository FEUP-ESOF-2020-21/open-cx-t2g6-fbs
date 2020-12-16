<?php
  require_once('db.php');


  
  $name = $_GET['name'];
  
  $email = $_GET['email'];
 

  $query = "INSERT INTO User(Email, Name)
   VALUES ('";
  $query = $query . addslashes($email) . "', '" . addslashes($name) . "');";
  

  echo $query;
  

  
  $stm = $db->prepare($query);
  $stm->execute();

?>