#!/bin/bash 

# This script should run the initial compilation of anything consumed
# by static analysis or unit tests.


mvn clean package -DskipTests=true
#Above command returns success(0) or failure(1) message to $? after executing pom.xml . Stop execution of build for failure.
cleanPackageResult=$?
if [[ $cleanPackageResult -ne 0 ]] ; then
  echo 'Could not perform clean package .'
  exit 1
fi
echo "Build Successful"

# Copy the compiled resources to the shared EFS directory, for
# consumption by other jobs
#if [[ $BUILD_TAG =~ .*-development-[0-9]+ ]] ;
#then
#	echo "jenkins compile"
 #   tar -czf compiled_sources.tar.gz .
  #  sudo mkdir $ARTIFACT_LOCATION
   # sudo cp compiled_sources.tar.gz $ARTIFACT_LOCATION
#fi
