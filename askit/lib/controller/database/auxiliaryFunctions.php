<?php
  //Auxiliary functions
  //Print on screen the information regarding all the upcoming lectures
  function printUpcomingChoosableLectures($results, $availabilityFilter, $list){
    foreach($results as $row){
      if ($availabilityFilter == 'all'){
        if ($row["Date"] >= date("Y-m-d")){
          if (!in_array($row["Id"], $list)){
            printLecture($row);
          }
        }
      }
      else{ //Print only available ones
        if ($row["Date"] >= date("Y-m-d") and $row["Attendance"] < $row["Capacity"]){
          if (!in_array($row["Id"], $list)){
            printLecture($row);
          }
        }
      }
   }
  }
  
  function printAllLectures($results){
    foreach($results as $result){
      printLecture($result);
    }
  }

  //Print individual lecture
  function printLecture($row){
    echo $row["Id"] . "\n"; 
    echo $row["Title"] . "\n";
    echo $row["Description"] . "\n";
    echo $row["Date"] . "\n";
    echo $row["Capacity"] . "\n";
    echo $row["Attendance"] . "\n";
    echo $row["Slides"] . "\n";
    echo $row["Status"] . "\n";
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
        //Print role here 
      }
    }
  }


  //Returns a list with all the ids of the lectures the user attended
  function getAllIdsUserAttended($user, $db){
    $query2 = "SELECT Id FROM Attends WHERE Email='";
    $query2 = $query2 . addslashes($user) . "';";
    $stm2 = $db->prepare($query2);
    $stm2->execute();
    $listOfResults = $stm2->fetchAll();

    $listOfIds = array();
    foreach( $listOfResults as $ID){
      array_push($listOfIds, $ID["Id"]);
    }

    return $listOfIds;
  }


  function invertVoting($db, $email, $questionId, $new_type){
    //Remove from table UserVotedQuestion where email=$email and questionId=$questionId
    $remove_query = "DELETE FROM UserVotedQuestion Where UserEmail='" . addslashes($email) . "' AND QuestionId=$questionId;";
    $remove_stm = $db->prepare($remove_query);
    $remove_stm->execute();

    //Insert into UserVotedQuestion(...) VALUES ($email, $questionId, $new_type)
    $insert_query = "INSERT INTO UserVotedQuestion(UserEmail, QuestionId, Type) VALUES ('" . addslashes($email) . "', $questionId, '$new_type');";
    $insert_stm = $db->prepare($insert_query);
    $insert_stm->execute();
  }
?>
