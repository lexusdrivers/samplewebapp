#!/bin/bash -x

# Use this script to define steps needed for static analysis.
echo "-----Executing jenkins-selenium-test.sh :: START :: SONAR_URL: $SONAR_URL"


# Execute sonar scanner command, to run in debug mode, add --debug

docker exec -u 0 -it selenium_master bash

mvn clean test

echo "-----Executing jenkins-selenium-test.sh :: END"
