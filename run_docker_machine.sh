#!/bin/bash 

DOCKER_REGISTRY="dreg.tikalknowledge.com:5000"

export YR_VERSION=$1
if [[ -z $YR_VERSION ]]
then
	 echo "Version is not defined!"
     exit 1
fi
echo "YR_VERSION=$YR_VERSION"
MACHINE_NAME=yremote-$YR_VERSION

export DOCKER_MACHINE_DRIVER=virtualbox
if (( $# > 1 )); then
    export DOCKER_MACHINE_DRIVER=$2
fi

echo "DOCKER_MACHINE_DRIVER is $DOCKER_MACHINE_DRIVER"
if [ "$DOCKER_MACHINE_DRIVER" == "aws" ];then
		
	echo "Set AWS keys.."
	if [ -f ~/.aws/aws_dm_config ]; then
	    . ~/.aws/aws_dm_config
	else
		echo "You must have ~/.aws/aws_dm_config file with AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and the rest of the AWS variables set!"
		exit 1
	fi
	
	# Configuration file for aws cli
	export AWS_CONFIG_FILE=~/.aws/aws_config
	
	export AWS_INSTANCE_TYPE=m3.large
	
	echo "Create a new machine ${MACHINE_NAME}"
			
	docker-machine create --driver amazonec2 --amazonec2-access-key "${AWS_ACCESS_KEY_ID}" --amazonec2-secret-key "${AWS_SECRET_ACCESS_KEY}" \
	 --amazonec2-ami ${AWS_AMI} --amazonec2-instance-type "${AWS_INSTANCE_TYPE}" --amazonec2-region "${AWS_DEFAULT_REGION}" --amazonec2-zone "${AWS_ZONE}" \
	 --amazonec2-vpc-id "${AWS_VPC_ID}" --amazonec2-subnet-id "${AWS_SUBNET_ID}" --amazonec2-security-group "${AWS_SECURITY_GROUP}" \
	 --amazonec2-private-address-only=true --engine-insecure-registry "${DOCKER_REGISTRY}" \
	 --engine-env DOCKER_REGISTRY=${DOCKER_REGISTRY} --engine-env YR_VERSION=${YR_VERSION} ${MACHINE_NAME}
	 
else

	docker-machine create --driver $DOCKER_MACHINE_DRIVER --engine-insecure-registry "${DOCKER_REGISTRY}" \
	--engine-env DOCKER_REGISTRY=${DOCKER_REGISTRY} --engine-env YR_VERSION=${YR_VERSION} ${MACHINE_NAME}

fi
	
echo "Run $(docker-machine env ${MACHINE_NAME})"
eval "$(docker-machine env ${MACHINE_NAME})"

# Workaround for docker-machine bug with --engine-env
sed -i -- 's/\$YR_VERSION/'${YR_VERSION}'/g' docker-compose.yml

docker-compose up -d

return ${MACHINE_NAME}
