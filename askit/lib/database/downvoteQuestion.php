<?php
  require_once('db.php');
  require_once('auxiliaryFunctions.php');


  $email = $_GET['email'];
  $questionId = $_GET['questionId'];

  $query = "SELECT type FROM UserVotedQuestion WHERE UserEmail='" . addslashes($email) . "' AND QuestionId=$questionId;";
  
  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();

  if (!empty($results)){ //if user already voted
    $type= $results[0]['type'];
    if ($type == "D"){ //If user downvoted that question, remove vote
      $remove_query = "DELETE FROM UserVotedQuestion Where UserEmail='" . addslashes($email) . "' AND QuestionId=$questionId;";
      $remove_stm = $db->prepare($remove_query);
      $remove_stm->execute();
    }
    else{ //If user upvoted, new type will be D -> downvote
      invertVoting($db, $email, $questionId, "D");
    }
  }
  else{
    $insert_query = "INSERT INTO UserVotedQuestion(UserEmail, QuestionId, Type) VALUES ('" . addslashes($email) . "', $questionId, 'D');";
    $insert_stm = $db->prepare($insert_query);
    $insert_stm->execute();
  }



  

?>