#!/bin/bash
# filter md files and show the http status code
# thanks to https://stackoverflow.com/questions/6136022/script-to-get-the-http-status-code-of-a-list-of-urls
# ToDo write results in a file

cat $1 | awk -F\( '{print $2}' | awk -F\) '{print $1}' | grep http > $2

while read LINE; do
	curl -o /dev/null --silent --head --write-out '%{http_code}' "$LINE" 
	echo " $LINE" 
done < $2

