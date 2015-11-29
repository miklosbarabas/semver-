#!/bin/bash

# This script is using semver_increment.sh (and it's argument options) to bump the selected version number.

# Load property file
PROJECT_PROPERTIES="project.properties"
source ${PROJECT_PROPERTIES}

# Set version numbers
OLD_VERSION=${VERSION}
NEW_VERSION=`./semver_bump.sh $@ ${OLD_VERSION}`


echo "OLD VERSION=${OLD_VERSION}"
echo "NEW VERSION=${NEW_VERSION}"
sed -i -e "s/VERSION=*.*.*/VERSION=${NEW_VERSION}/g" ${PROJECT_PROPERTIES}


