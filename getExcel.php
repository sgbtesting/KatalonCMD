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
  // for ($row = 0; $row < count($the_big_array); $row++) {

    //start at row 2 to skip header data
    for ($a =2; $a < count( $the_big_array ); $a++) {

      for ($b=0; $b < count( $the_big_array[$a] ); $b++) {

        $str = $the_big_array[$a][$b];
         if(strpos( $str, "Test Cases/") !== FALSE) 
         {
          $str="";

          print ($the_big_array [$a][0]);
          echo " ---------------";

           print ($the_big_array[$a][7]); 
           echo "<br>";
         } 
       
        // if (strpos ($str,"Test Cases/") == true) {
          
        //   print ($the_big_array[$a][7]);

        // }


      }
    }
    // echo '<pre>';
    // var_dump($the_big_array);
    // echo '</pre>';
  
}

// echo ("STATUS is : ");
getStatusFromExcel("result.csv");
