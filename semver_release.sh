#!/bin/bash

# This script is using semver_increment.sh (and it's argument options) to bump the selected version number.

# Load property file
PROJECT_PROPERTIES="project.properties"
source ${PROJECT_PROPERTIES}

# Set version numbers
OLD_VERSION=${VERSION}
NEW_VERSION=`./semver_bump.sh $@ ${OLD_VERSION}`

if [ $# -eq 0 ]; then
	echo "ACTUAL VERSION=${OLD_VERSION}"
	echo "Usage: $(basename $0) [-Mmp]"
	exit 1
fi


echo "OLD VERSION=${OLD_VERSION}"
echo "NEW VERSION=${NEW_VERSION}"
sed -i -e "s/VERSION=*.*.*/VERSION=${NEW_VERSION}/g" ${PROJECT_PROPERTIES}

# The commit & tag annotation message
GIT_COMMIT_MESSAGE="Release for ${PROJECT_NAME} - New version: ${NEW_VERSION}"

# Add PROJECT_PROPERTIES to commit the new version
git add ${PROJECT_PROPERTIES}
git commit -m "${GIT_COMMIT_MESSAGE}"
echo "[GIT] Commit created for '${PROJECT_PROPERTIES}' file"

# Create a release tag
git tag -a ${NEW_VERSION} -m "${GIT_COMMIT_MESSAGE}"
echo "[GIT] TAG created for version ${NEW_VERSION} with message: '${GIT_COMMIT_MESSAGE}'"
echo "[GIT] Pushing changes..."

# Push the tag & the commit to git
git push origin master --follow-tags
echo "[GIT] The new release (v${NEW_VERSION}) has been pushed to the repository!"