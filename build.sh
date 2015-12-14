#!/bin/bash

DOCKER_REGISTRY=dreg.tikalknowledge.com:5000


if [ -z YR_VERSION ]
then
	echo "YR_VERSION must be set!"
	exit 1
fi
echo "YR_VERSION=$YR_VERSION"

if [ -z WORKSPACE ]
then
	WORKSPACE=${PWD}
fi
echo "WORKSPACE=$WORKSPACE"

echo "Build ynginx image for version ${YR_VERSION}"
cd ${WORKSPACE}/ynginx
docker build -t ${DOCKER_REGISTRY}/ynginx:${YR_VERSION} .
docker push ${DOCKER_REGISTRY}/ynginx:${YR_VERSION}
docker tag -f ${DOCKER_REGISTRY}/ynginx:${YR_VERSION} ${DOCKER_REGISTRY}/ynginx:latest-not-tested
docker push ${DOCKER_REGISTRY}/ynginx:latest-not-tested
echo
echo "Build yremote image for version ${YR_VERSION}"
cd ${WORKSPACE}/yremote
docker build -t ${DOCKER_REGISTRY}/yremote:${YR_VERSION} .
docker push ${DOCKER_REGISTRY}/yremote:${YR_VERSION}
docker tag -f ${DOCKER_REGISTRY}/yremote:${YR_VERSION} ${DOCKER_REGISTRY}/yremote:latest-not-tested
docker push ${DOCKER_REGISTRY}/yremote:latest-not-tested



