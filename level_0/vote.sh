#!/bin/bash
url="http://158.69.76.135/level0.php"
id=892
for i in {1..1024}
do
	curl -X POST $url -d "holdthedoor=&id=$id" > /dev/null
	sleep .5
done
