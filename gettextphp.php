<?php 
$string="1/2/3";
$array=explode('/',$string);
foreach($array as $key => $item)
{
    echo $key."=>".$item."/n";
}
?>