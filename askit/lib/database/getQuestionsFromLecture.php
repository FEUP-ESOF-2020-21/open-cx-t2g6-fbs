<?php
  require_once('db.php');


  $lectureId = $_GET['lectureId'];
  $sort = $_GET['sort']; //Can be 'new' or 'hot'

  if ($sort =="hot"){
    $filter = "ORDER BY RATING DESC";
  }
  else{
    $filter = "ORDER BY TimePosted DESC";
  }
  $query = "SELECT Id, Question, Rating, Slide, LectureId, TimePosted
            FROM Question
            WHERE lectureId=$lectureId $filter;";

  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();


  foreach ($results as $row){
    echo $row['Id'] . "\n";
    echo $row['Question'] . "\n";
    echo $row['Rating'] . "\n";
    echo $row['Slide'] . "\n";
  }
  


?>