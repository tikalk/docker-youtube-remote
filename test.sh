#!/bin/bash 

echo "Downloading the app front page"
wget -o /tmp/index.html http://localhost:81 &1> /dev/null

echo "Verifying that it is \'youtubeRemoteApp\' page"
cat /tmp/index.html |grep "<body ng-app=\"youtubeRemoteApp\">" > /dev/null 
EXIT=$?

echo "cleaning up"
rm /tmp/index.html
if [[ $EXIT == 0 ]]; then
	OUT='Success';
else
	OUT='Failure';
fi
echo "Test status is $OUT"
exit $EXIT
