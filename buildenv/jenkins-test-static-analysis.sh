#!/bin/bash -x

# Use this script to define steps needed for static analysis.
echo "-----Executing jenkins-static-analysis.sh :: START :: SONAR_URL: $SONAR_URL"


# Execute sonar scanner command, to run in debug mode, add --debug
mvn sonar:sonar --errors -Dsonar.host.url=$SONAR_URL

echo "-----Executing jenkins-static-analysis.sh :: END"