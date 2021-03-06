<?php


class GitHub
{
    public $sourceDirectory;
    public $batRunGitDirectory;
    public $gitBranch;

    function execInBackground($cmd)
    {
        if (substr(php_uname(), 0, 7) == "Windows") {
            pclose(popen("start /B " . $cmd, "r"));
        } else {
            exec($cmd . " > /dev/null &");
        }
    }

    function setBatchRunGitDirectory($batRunGitDirectory)
    {
        $this->batRunGitDirectory = $batRunGitDirectory;
    }

    function setSourceDirectory($sourceDirectory)
    {
        $this->sourceDirectory = $sourceDirectory;
    }   

    function setGitBranch($gitBranch)
    {
        $this->gitBranch = $gitBranch;
    }

    function runGitByBranch()
    {
        //  error_log($this->directory);
        $this->execInBackground("start cmd.exe @cmd /k" . $this->batRunGitDirectory . " ". $this->sourceDirectory . " " . $this->gitBranch );
    }

}

// $git = new GitHub();
// $git->setBatchRunGitDirectory("D:\\Dev\\KatalonCMD\\bat\\pullSourceGit.bat");
// $git->setSourceDirectory("D:\\Dev\\ezactivevn\\bfa");
// $git->setGitBranch("develop");


///////////////////////////////* THIS IS PULL FRAME WORK *//////////////////////////
$pull = new GitHub();

/* Set Value */
$pull->setBatchRunGitDirectory("C:\\Dev\\KatalonCMD\\bat\\pullSourceGit.bat");
$pull->setSourceDirectory("C:\\Dev\\ezactivevn\\framework");
$pull->setGitBranch("develop");


/* Pull project */
$pull-> runGitByBranch();

///////////////////////////////*///////////////////////////////*///////////////////////////////


$jsonData = json_encode($git);

echo $jsonData . "\n";
