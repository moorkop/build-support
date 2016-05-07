#!/bin/bash

OUR_DIR=$(dirname $_)
. $OUR_DIR/build-common.sh

if [ -z MVN_RELEASE_VER ]; then

    check_var MVN_RELEASE_TAG
    check_var MVN_RELEASE_DEV_VER

    set -ex

    mvn -B -Dtag=${MVN_RELEASE_TAG} release:prepare \
                 -DreleaseVersion=${MVN_RELEASE_VER} \
                 -DdevelopmentVersion=${MVN_RELEASE_DEV_VER}

    mvn -s settings.xml release:perform

    mvn release:clean
fi
