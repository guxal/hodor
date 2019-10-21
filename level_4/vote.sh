#!/bin/bash

RED='\033[0;31m'
BLU='\033[0;34m'
GRE='\033[0;32m'
NC='\033[0m' # No Color
url="http://158.69.76.135/level4.php"

id=892

user_agent='Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36'
referer="Referer: http://158.69.76.135/level4.php"

for i in {1..98}
do
echo -e "${RED}------Vote for ${id}------${NC}"
proxy=$(curl http://pubproxy.com/api/proxy?type=http | grep -o '"ipPort":.*' | cut -d '"' -f4 | cut -d '"' -f1)
echo "hey"
echo $proxy
cookie=$(curl -x $proxy -c cookie.txt -I -s -H "$referer" -A "$user_agent" $url | grep -o 'HoldTheDoor=.*' | cut -d ';' -f1 | cut -d '=' -f2)

curl -x $proxy -H "$referer" -A "$user_agent" --cookie cookie.txt -X POST $url -d "key=$cookie&holdthedoor=&id=$id" #> /dev/null

echo -e "${BLU}Send Post ... ${NC}"

#sleep 10
done
