<?php

class GetAllBranch {
    public $textFileDirectory;
    public $batFileDirectory;
    public $projectDirectory;


    function execInBackground($cmd)
    {
        if (substr(php_uname(), 0, 7) == "Windows") {
            pclose(popen("start /B " . $cmd, "r"));
        } else {
            exec($cmd . " > /dev/null &");
        }
    }
    
    function setProjectDirectory ($projectDirectory)
    {
        $this->projectDirectory = $projectDirectory;
    }

    function setBatchFileDirectory ($batFileDirectory) {
        $this->batFileDirectory = $batFileDirectory;
    }

    function setTextFileDirectory ($textFileDirectory) {
        $this->textFileDirectory = $textFileDirectory;
    }

    function writeBranchToTextFile() {
        $this->execInBackground("start cmd.exe @cmd /k" . $this->batFileDirectory . " ". $this->projectDirectory . " " . $this->textFileDirectory );

    }

    function getAllBranchFromTextFile () {
        $fh = fopen($this->textFileDirectory,'r');
        while ($line = fgets($fh)) {
          // <... Do your work with the line ...>
          // echo($line);
          echo ($line."</br>");
        }
        fclose($fh);
    }
}

$gab = new GetAllBranch();

$gab->setProjectDirectory("C:/dev/ezactivevn/hkjfl");
$gab->setBatchFileDirectory("C:/dev/KatalonCMD/bat/getAllBranch.bat");
$gab->setTextFileDirectory("branch.txt");

$gab->writeBranchToTextFile();

$gab->getAllBranchFromTextFile();






?>