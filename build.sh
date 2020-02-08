#!/bin/bash

if [[ "$YR_VERSION" == "" ]]
then
	echo "YR_VERSION must be set!"
	exit 1
fi
echo "YR_VERSION=$YR_VERSION"

if [[ "$WORKSPACE" == "" ]]
then
	WORKSPACE=${PWD}
fi
echo "WORKSPACE=$WORKSPACE"

echo "Build ynginx image for version ${YR_VERSION}"
cd ${WORKSPACE}/ynginx
docker build -t yremote/ynginx:${YR_VERSION} .
echo
echo "Build yremote image for version ${YR_VERSION}"
cd ${WORKSPACE}/yremote
docker build -t yremote/yremote:${YR_VERSION} .
