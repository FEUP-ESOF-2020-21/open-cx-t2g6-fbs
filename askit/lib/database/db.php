<?php 

$dns = "mysql:host=sql2.freemysqlhosting.net;dbname=sql2378489";
$user = 'sql2378489';
$pass = 'dN4%bT2%';

try{
  $db = new PDO($dns, $user, $pass);
  //echo 'Connected';
}
catch(PDOException $e){
  $error = $e->getMessage();
  echo $error;
}

?>