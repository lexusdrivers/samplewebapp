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

if [ -z "$TOMCAT_CREDENTIALS_URL" ]; then
    echo "Environment variable SONARQUBE_CREDENTIALS_URL not provided!"
    exit
fi

aws s3 cp --sse aws:kms $TOMCAT_CREDENTIALS_URL servercred.env
echo "Receieved servercred.env"
ls -ltr
source servercred.env
rm servercred.env

#curl  "http://$TOMCAT_USERNAME:$TOMCAT_PASSWORD@http://ec2-35-161-134-196.us-west-2.compute.amazonaws.com:8090/manager/text/undeploy?path=/HelloWorld"

curl -T HelloWorld.war "http://$TOMCAT_USERNAME:$TOMCAT_PASSWORD@ec2-35-161-134-196.us-west-2.compute.amazonaws.com:8090/manager/text/deploy?path=/HelloWorld&update=true"

# Copy the compiled resources to the shared EFS directory, for
# consumption by other jobs
#if [[ $BUILD_TAG =~ .*-development-[0-9]+ ]] ;
#then
#	echo "jenkins compile"
 #   tar -czf compiled_sources.tar.gz .
  #  sudo mkdir $ARTIFACT_LOCATION
   # sudo cp compiled_sources.tar.gz $ARTIFACT_LOCATION
#fi
