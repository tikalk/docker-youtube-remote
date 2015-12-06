#!/bin/bash

DOCKER_REGISTRY=xx:5000


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

echo "Build yremote-nginx image for version ${YR_VERSION}"
cd ${WORKSPACE}/yremote-nginx
docker build -t ${DOCKER_REGISTRY}/yremote-nginx:${YR_VERSION} .
docker push ${DOCKER_REGISTRY}/yremote-nginx:${YR_VERSION}
docker tag -f ${DOCKER_REGISTRY}/yremote-nginx:${YR_VERSION} ${DOCKER_REGISTRY}/yremote-nginx:latest-not-tested
docker push ${DOCKER_REGISTRY}/yremote-nginx:latest-not-tested

echo "Build yremote image for version ${YR_VERSION}"
cd ${WORKSPACE}/yremote
docker build -t ${DOCKER_REGISTRY}/yremote:${YR_VERSION} .
docker push ${DOCKER_REGISTRY}/yremote:${YR_VERSION}
docker tag -f ${DOCKER_REGISTRY}/yremote:${YR_VERSION} ${DOCKER_REGISTRY}/yremote:latest-not-tested
docker push ${DOCKER_REGISTRY}/yremote:latest-not-tested



