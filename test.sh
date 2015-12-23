#!/bin/bash 

export APP_HOST=$1
if [[ -z $APP_HOST ]]
then
	 APP_HOST=localhost
fi

echo "Downloading the app front page"
wget http://$APP_HOST:81 

echo "Verifying that it is \'youtubeRemoteApp\' page"
if [ -f index.html ]; then
	cat index.html |grep "<body ng-app=\"youtubeRemoteApp\">" 
	EXIT=$?

	echo "cleaning up"
	rm index.html
else
	EXIT=1
fi 
if [[ $EXIT == 0 ]]; then
	OUT='Success';
else
	OUT='Failure';
fi
echo "Test status is $OUT"
exit 0
