<?php

$doc = new DOMDocument();
@$doc->loadHTMLFile('C:/dev/ezactivevn/KatalonCMD/2222.html');

$xpath = new DOMXpath($doc);

$elements = $xpath->query('//*[@id="s1-t1"]/div[2]/table/tbody/tr[3]/td/span');

if(is_object($elements->item(0))){
    //do your stuff

 }
 echo $elements->item(0)->textContent;

 echo $doc->saveHTML();


?>
