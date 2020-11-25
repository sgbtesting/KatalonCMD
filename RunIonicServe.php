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

   function runIonicServe ($batPath, $path, $host, $port) {
        $this->batchDirectory = $batPath;
      
        $this ->execInBackground("start cmd.exe @cmd /k" . $this->batchDirectory . " " . $path . " " . $host . " " . $port );        

   }

}

$cmd = new CommandLine ();
$cmd->runIonicServe(".\\bat\\installLibrary.bat", "C:\dev\\ezactivevn\hkjfl", "localhost", "8101");

$jsonData = json_encode($cmd);

echo $jsonData. "\n";
