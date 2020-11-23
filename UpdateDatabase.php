<?php

class Database
{
    // Name of the file
    public $servername = "localhost";
    public $username = "root";
    public $password = "";
    public $conn;

    public $dbName = "";

    function createConnection()
    {
        // Create connection
        $this->conn = new mysqli($this->servername, $this->username, $this->password);

        if ($this->conn->connect_error) {
            die("Connection failed: " . $this->conn->connect_error);
        }
    }

    function closeConnection()
    {
        $this->conn->close();
    }

    function createDatabase($dbName)
    {
        // Create database
        $sql = "CREATE DATABASE " . $dbName;
        if ($this->conn->query($sql) === TRUE) {
            echo "Database created successfully";
        } else {
            echo "Error creating database: " . $this->conn->error;
        }
    }


    function dropDatabase($dbName)
    {
        $this->dbName = $dbName;
        // Create database
        $sql = "DROP DATABASE " . $dbName;
        if ($this->conn->query($sql) === TRUE) {
            echo "Database DROP successfully";
        } else {
            echo "Error DROP database: " . $this->conn->error;
        }
    }

    function importDatabase($fileSQLDirectory, $dbName)
    {
        $sqlSource = file_get_contents($fileSQLDirectory);
        $this->conn->query("USE" . $dbName);
        mysqli_multi_query($this->conn, $sqlSource);
    }
}


$db = new Database();

$db->createConnection();
$db->createDatabase("ezactive_bfa");
$db->importDatabase("./bat/ezactive_bfa.sql", "ezactive_bfa");
// $db->dropDatabase("ezactive_bfa");
$db->closeConnection();
