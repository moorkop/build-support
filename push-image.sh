#!/bin/bash

OUR_DIR=$(dirname $_)
. $OUR_DIR/build-common.sh

while getopts b:t: var ; do
  case $var in
   b)
    branch=$OPTARG ;;
   t)
    tag=$OPTARG ;;
  esac
done

if [[ -z $tag ]]; then
  if [[ $branch == "master" ]]; then
    tag=latest
  fi
fi

echo "Pushing image"
echo "Repo path: ${DOCKER_REPO_PATH}"
echo "Module: ${OUR_MODULE:=$(basename $PWD)}"
echo "Tag: ${tag}"

check_var DOCKER_EMAIL
check_var DOCKER_REPO_USER
check_var DOCKER_REPO_PASSWORD
check_var DOCKER_REPO_PATH
resolve_vars

docker login -e $DOCKER_EMAIL -u $DOCKER_REPO_USER -p $DOCKER_REPO_PASSWORD $DOCKER_REPO_SERVER
docker tag $OUR_MODULE $DOCKER_REPO_PATH/$OUR_MODULE:$tag
docker push $DOCKER_REPO_PATH/$OUR_MODULE:$tag
