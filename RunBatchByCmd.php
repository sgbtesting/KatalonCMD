<?php


class CommandLine {
    public  $batchDirectory =""; 


  function execInBackground($cmd) { 
        if (substr(php_uname(), 0, 7) == "Windows"){ 
            pclose(popen("start /B ". $cmd, "r"));  
        } 
        else { 
            exec($cmd . " > /dev/null &");   
        } 
    }

    function runTestSuitByDirectory($suitDirectory)
    {  $this ->batchDirectory = $suitDirectory;
      //  error_log($this->directory);
        $this ->execInBackground("start cmd.exe @cmd /k" . $this->batchDirectory);        
    }

}

$cmd = new CommandLine ();
$cmd->runTestSuitByDirectory (".\\bat\\test148.bat");

$jsonData = json_encode($cmd);

echo $jsonData. "\n";
