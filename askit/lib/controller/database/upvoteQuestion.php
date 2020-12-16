<?php
  require_once('db.php');
  require_once('auxiliaryFunctions.php');


  $email = $_GET['email'];
  $questionId = $_GET['questionId'];

  $query = "SELECT type FROM UserVotedQuestion WHERE UserEmail='" . addslashes($email) . "' AND QuestionId=$questionId;";
  echo $query;
  
  $stm = $db->prepare($query);
  $stm->execute();
  $results = $stm->fetchAll();

  if (!empty($results)){ //if user already voted
    $type= $results[0]['type'];
    if ($type == "U"){ //If user upvoted that question, remove vote
      $remove_query = "DELETE FROM UserVotedQuestion Where UserEmail='" . addslashes($email) . "' AND QuestionId=$questionId;";
      $remove_stm = $db->prepare($remove_query);
      $remove_stm->execute();
    }
    else{
      invertVoting($db, $email, $questionId, "U");
    }
  }
  else{
    echo "not present yet!";
    //Insert into UserVotedQuestion(...) VALUES ($email, $questionId, "U")
    $insert_query = "INSERT INTO UserVotedQuestion(UserEmail, QuestionId, Type) VALUES ('" . addslashes($email) . "', $questionId, 'U');";
    echo $insert_query;
    $insert_stm = $db->prepare($insert_query);
    $insert_stm->execute();
  }



  

?>