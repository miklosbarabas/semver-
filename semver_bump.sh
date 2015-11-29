#!/bin/bash

# Increment a version string according to the Semantic Versioning (SemVer) terminology.

# Parse command line options.
while getopts ":Mmp" Option
do
  case $Option in
    M ) major=true;;
    m ) minor=true;;
    p ) patch=true;;
  esac
done

# Remove all the options that have been parsed by getopts...
shift "$(($OPTIND - 1))"
# ...so $1 will be the first non-option argument
version=$1

# Build array from version string.
a=( ${version//./ } )

# If version string is missing or has the wrong number of members, show usage message.

if [ ${#a[@]} -ne 3 ]
then
  echo "Usage: $(basename $0) [-Mmp] major.minor.patch"
  exit 1
fi

# Increment version numbers based on the selected command line option.
if [ ! -z $major ]
then
  ((a[0]++))
  a[1]=0
  a[2]=0
fi

if [ ! -z $minor ]
then
  ((a[1]++))
  a[2]=0
fi

if [ ! -z $patch ]
then
  ((a[2]++))
fi

echo "${a[0]}.${a[1]}.${a[2]}"
