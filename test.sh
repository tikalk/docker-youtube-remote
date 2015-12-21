#!/bin/bash 

echo "Downloading the app front page"
wget -o index.html http://localhost:81 

echo "Verifying that it is \'youtubeRemoteApp\' page"
cat index.html |grep "<body ng-app=\"youtubeRemoteApp\">" 
EXIT=$?

echo "cleaning up"
rm index.html
if [[ $EXIT == 0 ]]; then
	OUT='Success';
else
	OUT='Failure';
fi
echo "Test status is $OUT"
exit $EXIT
