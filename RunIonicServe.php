<?php


class IonicServe {
    public  $batchDirectory =""; 
    public $projectDirectory= ""; 
    public $hostname = "";
    public $port = "";

  function execInBackground($cmd) { 
        if (substr(php_uname(), 0, 7) == "Windows"){ 
            pclose(popen("start /B ". $cmd, "r"));  
        } 
        else { 
            exec($cmd . " > /dev/null &");   
        } 
    }

    function setBatchPath ($batchDirectory) { // .bat directory
        $this-> batchDirectory = $batchDirectory;
    }

    function setProjectDirectory ($projectDirectory) { //project folder
        $this->projectDirectory = $projectDirectory;
    }

    function setHostName ($hostname) { //localhost or IP
        $this->hostname =  $hostname;
    }

    function setPortNumber ($port) { //8101
        $this->port = $port;
    }

   function runIonicServe () { //to call batfile to run ionic serve --host --port 
      
        $this ->execInBackground("start cmd.exe @cmd /k" 
        . $this->batchDirectory . " " 
        . $this->projectDirectory . " "
        . $this->host . " " 
        . $this->port      );        

   }

}

$serve = new IonicServe ();

/* Set value  */
$serve->setBatchPath (".\\bat\\installLibrary.bat");
$serve->setProjectDirectory("C:\\dev\\ezactivevn\\hkjfl");
$serve->setHostName("localhost");
$serve->setPortNumber("8101");

/* Run cmd ionic serve */
$serve->runIonicServe();


/* print html */
$jsonData = json_encode($serve);

echo $jsonData. "\n";
