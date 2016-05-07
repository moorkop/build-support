#!/bin/bash

OUR_DIR=$(dirname $_)
. $OUR_DIR/build-common.sh

if [[ -v MVN_RELEASE_VER ]]; then

    check_var MVN_RELEASE_TAG
    check_var MVN_RELEASE_DEV_VER
    check_var MVN_RELEASE_USER_EMAIL
    check_var MVN_RELEASE_USER_NAME

    set -e

    git config user.email "${MVN_RELEASE_USER_EMAIL}"
    git config user.name "${MVN_RELEASE_USER_NAME}"

    mvn -B -Dtag=${MVN_RELEASE_TAG} release:prepare \
                 -DreleaseVersion=${MVN_RELEASE_VER} \
                 -DdevelopmentVersion=${MVN_RELEASE_DEV_VER}

    mvn -s settings.xml release:perform

    mvn release:clean
fi
