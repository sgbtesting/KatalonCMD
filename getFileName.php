<?php
class GetAllFileName
{
    public $batFileDirectory;
    public $katalonDirectory;
    public $fileExtension;
    public $suiteFolder;
    public $textFileDirectory;


    private function execInBackground($cmd)
    {
        if (substr(php_uname(), 0, 7) == "Windows") {
            pclose(popen("start /B " . $cmd, "r"));
        } else {
            exec($cmd . " > /dev/null &");
        }
    }

    function setBatchFileDirectory($batfile)
    {
        $this->batFileDirectory = $batfile;
    }

    function setKatalonDirectory($katalonDirectory)
    {
        $this->katalonDirectory = $katalonDirectory;
    }

    function setFileExtension($fileExtension)
    {
        $this->fileExtension = $fileExtension;
    }

    function setTextFileDirectory($textFileDirectory)
    {
        $this->textFileDirectory = $textFileDirectory;
    }

    function setSuiteFolder($suiteFolder)
    {
        $this->suiteFolder = $suiteFolder;
    }

    function getProjectName()
    {

        $this->execInBackground("start cmd.exe @cmd /k" . $this->batFileDirectory . " " . $this->katalonDirectory . " " . $this->fileExtension . " " . $this->textFileDirectory);
    }

    function getTestSuiteFolder()
    {

        $this->execInBackground("start cmd.exe @cmd /k" . $this->batFileDirectory . " " . $this->katalonDirectory . " " . $this->textFileDirectory);
    }



    function getTestSuiteName()
    {

        $this->execInBackground("start cmd.exe @cmd /k" . $this->batFileDirectory . " " .  $this->katalonDirectory . " " . $this->suiteFolder  . " " . $this->textFileDirectory);
    }




    function writeToTextFile()
    {
        $fh = fopen($this->textFileDirectory, 'r');
        while ($line = fgets($fh)) {
            // <... Do your work with the line ...>
            // echo($line);
            echo ($line . "</br>");
        }
        fclose($fh);
    }
}


function callGetFileName()
{
    $getFileName = new GetAllFileName();
    $getFileName->setBatchFileDirectory("C:\\dev\\KatalonCMD\\bat\\getFileName.bat");
    $getFileName->setKatalonDirectory("C:\\test\\ezactivevn\\SGB_Mobile_Test-");
    $getFileName->setFileExtension("*.prj");
    $getFileName->setTextFileDirectory("C:\\dev\\KatalonCMD\\fileName.txt");
    $getFileName->getProjectName();
    $getFileName->writeToTextFile();
}


function callGetSuiteFolder()
{
    $getSuiteFolder = new GetAllFileName();
    $getSuiteFolder->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getSuiteFolder.bat");
    $getSuiteFolder->setKatalonDirectory("D:\\TestCase\\VF_TestCase");
    $getSuiteFolder->setTextFileDirectory("D:\\dev\\KatalonCMD\\suiteFolder.txt");
    $getSuiteFolder->getTestSuiteFolder();
    $getSuiteFolder->writeToTextFile();
}


function callGetSuiteName($suiteFolder)
{
    $getSuiteName = new GetAllFileName();
    $getSuiteName->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getSuiteName.bat");
    $getSuiteName->setKatalonDirectory("D:\\TestCase\\VF_TestCase");
    $getSuiteName->setSuiteFolder($suiteFolder);
    $getSuiteName->setFileExtension("*.ts");
    $getSuiteName->setTextFileDirectory("D:\\dev\\KatalonCMD\\suiteName.txt");
    $getSuiteName->getTestSuiteName();
    $getSuiteName->writeToTextFile();
}

function findStringInTextFile($search, $file)
{
    $file = file($file);

    foreach ($file as $line) {
        $line = trim($line);
        if ($line == $search) {

            // echo $search . " is in the file.txt";
            return $search;
        } else {

            // echo $search . " not in the file";
            return  $search . " not a test suite";
        }
    }
}



// callGetFileName(); //echo project Katalon .prj name

// callGetSuiteFolder(); //echo suite folder name

echo findStringInTextFile("VF-166", "suiteFolder.txt");

// callGetSuiteName("VF-166"); // echo test suite file name
