<?php
  require_once('db.php');
  require_once('auxiliaryFunctions.php');

  $query = "SELECT * FROM Lecture";
  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();
  
  $email = $_GET['email'];
  
  $availabilityFilter = $_GET['availabilityFilter'];
  

  //Gets all the ids of the lectures the user is attending. Upcoming lectures should not include those ones
  $list = getAllIdsUserAttended($email, $db);
  printUpcomingChoosableLectures($results, $availabilityFilter, $list);

?>


