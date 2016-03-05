#!/bin/bash

OUR_DIR=$(dirname $_)
. $OUR_DIR/build-common.sh

echo "Pushing image"
echo "Repo path: ${DOCKER_REPO_PATH}"
echo "Module: ${OUR_MODULE:=$(basename $PWD)}"
echo "Tag: ${IMAGE_TAG:=$CIRCLE_BRANCH}"

check_var DOCKER_EMAIL
check_var DOCKER_REPO_USER
check_var DOCKER_REPO_PASSWORD
check_var DOCKER_REPO_PATH
check_var IMAGE_TAG
resolve_vars

docker login -e $DOCKER_EMAIL -u $DOCKER_REPO_USER -p $DOCKER_REPO_PASSWORD $DOCKER_REPO_SERVER
docker tag $OUR_MODULE $DOCKER_REPO_PATH/$OUR_MODULE:$IMAGE_TAG
docker push $DOCKER_REPO_PATH/$OUR_MODULE:$IMAGE_TAG
