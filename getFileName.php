<?php
class GetAllFileName
{
    public $batFileDirectory;
    public $katalonDirectory;
    public $fileExtension;
    public $suiteFolder;
    public $textFileDirectory;
    public $testCaseFolder;
    public $testCaseName;


    private function execInBackground($cmd)
    {
        if (substr(php_uname(), 0, 7) == "Windows") {
            pclose(popen("start /B " . $cmd, "r"));
        } else {
            exec($cmd . " > /dev/null &");
        }
    }

    /*Set variables -------------------------------------------------------------- */
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

    function setTestCaseFolder($testCaseFolder)
    {
        $this->testCaseFolder = $testCaseFolder;
    }

    function setTestCaseName($testCaseName)
    {
        $this->testCaseName = $testCaseName;
    }



    /* ---------------------------------------end set variables */



    /*Get Name, Folder, Path --------------------------------------- */
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


    function  getTestCaseFolder() {

        $this->execInBackground("start cmd.exe @cmd /k" . $this->batFileDirectory . " " . $this->katalonDirectory . " " . $this->textFileDirectory);
    }



    function getTestCaseName()
    {
        $this->execInBackground("start cmd.exe @cmd /k" . $this->batFileDirectory . " " .  $this->katalonDirectory . " " . $this->testCaseFolder  . " " . $this->textFileDirectory);
    }

    /* ----------------------------------------------- END GET FOLDER PATH NAME ----------------------------------------------- */



    /*--------------------------------EXECUTE FUNCTIONS---------------------------------------------------------------------  */

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

    function countTestCase(){
        $count = 0;
        $fh = fopen($this->textFileDirectory, 'r');
        while ($line = fgets($fh)) {
            // <... Do your work with the line ...>
            // echo($line);
            $count ++;            
        }
        return $count;
        fclose($fh);
    }



    function callGetFileName($projectName)
    {
        $getFileName = new GetAllFileName();
        $getFileName->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getFileName.bat");
        $getFileName->setKatalonDirectory("D:TestCase\\".$projectName);
        $getFileName->setFileExtension("*.prj");
        $getFileName->setTextFileDirectory("D:\\dev\\KatalonCMD\\fileName.txt");
        $getFileName->getProjectName();
        $getFileName->writeToTextFile();
    }


    function callGetSuiteFolder($projectName)
    {
        $getSuiteFolder = new GetAllFileName();
        $getSuiteFolder->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getSuiteFolder.bat");
        $getSuiteFolder->setKatalonDirectory("D:TestCase\\".$projectName);
        $getSuiteFolder->setTextFileDirectory("D:\\dev\\KatalonCMD\\suiteFolder.txt");
        $getSuiteFolder->getTestSuiteFolder();
        $getSuiteFolder->writeToTextFile();
    }


    function callGetSuiteName( $projectName, $suiteFolder)
    {
        $getSuiteName = new GetAllFileName();
        $getSuiteName->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getSuiteName.bat");
        $getSuiteName->setKatalonDirectory("D:TestCase\\".$projectName);
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

    function callGetCaseFolder ($projectName) {
        $getCasesFolder = new GetAllFileName();
        $getCasesFolder->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getCaseFolder.bat");
        $getCasesFolder->setKatalonDirectory("D:\\TestCase\\".$projectName);
        $getCasesFolder->setTextFileDirectory("D:\\dev\\KatalonCMD\\caseFolder.txt");
        $getCasesFolder->getTestCaseFolder();
        $getCasesFolder->writeToTextFile();
    }


    function callGetTestCaseName($projectName, $caseFolder)
    {
        $getTestCaseName = new GetAllFileName();
        $getTestCaseName->setBatchFileDirectory("D:\\dev\\KatalonCMD\\bat\\getCaseName.bat");
        $getTestCaseName->setKatalonDirectory("D:\\TestCase\\".$projectName);
        $getTestCaseName->setTestCaseFolder($caseFolder);
        $getTestCaseName->setFileExtension("*.tc");
        $getTestCaseName->setTextFileDirectory("D:\\dev\\KatalonCMD\\CaseName.txt");
        $getTestCaseName->getTestCaseName();
        $getTestCaseName->writeToTextFile();
        echo "<br> Number of Testcase: ";
        echo $getTestCaseName->countTestCase();
    }
}




$getFile = new GetAllFileName();


// callGetFileName(); //echo project Katalon .prj name

// callGetSuiteFolder(); //echo suite folder name



// callGetSuiteName("VF-166"); // echo test suite file name

// echo $getFile->findStringInTextFile("VF-166", "suiteFolder.txt");


// $getFile->callGetCaseFolder("hkjfl_qc");
// $getFile->callGetTestCaseName ("sgb_qc","SGB-135");
$getFile->callGetTestCaseName ("vf_qc","VF-166");