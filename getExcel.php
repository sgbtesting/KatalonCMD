<?php

function getStatusFromExcel ($excelFile) {

  $the_big_array = []; 

  if (($h = fopen($excelFile, "r")) !== FALSE) 
  {
    // Convert each line into the local $data variable
    while (($data = fgetcsv($h, 1000, ",")) !== FALSE) 
    {		
      // Read the data from a single line
      $the_big_array[] = $data;		
  
    }
  
    // Close the file
    fclose($h);
  }
  
  
  print_r($the_big_array[1][7]);
}

echo ("STATUS is : ");
getStatusFromExcel("data.csv");


?>