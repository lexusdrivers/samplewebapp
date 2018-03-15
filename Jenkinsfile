#!/usr/bin/env groovy

// This file defines the Jenkins build pipeline for this project.


//=====================================================
// Constants and Parameters Definitions :: START
//=====================================================

env.SONAR_URL = 'http://devops-Je-SonarQub-2A0PMN0PDK9O-407290823.us-west-2.elb.amazonaws.com/'




//=====================================================
// Constants and Parameters Definitions :: END
//=====================================================



//=====================================================
// Jenkins Build Pipeline script :: START
//=====================================================

try {
    currentBuild.result = 'SUCCESS'

    node ('master') {

    	//=============================================================================================
	    // Stage "Compile", "Static Analysis", "Tests" will:
	    //		1. Pull the latest code from BitBucket and compile the source code.
	    //		2. Execute static analysis with SonarQube.
	    //		3. Execute JUnit Tests.
	    //=============================================================================================

	    stage ('Compile') {
            echo "Compile :: START"
            checkout scm
            sh "sudo chmod -R 755 buildenv/* && dos2unix ./buildenv/*.sh && ./buildenv/jenkins-compile.sh"
            // NTUC sh "sudo mkdir -p $ARTIFACT_LOCATION && sudo cp -R ./build-env $ARTIFACT_LOCATION && sudo cp -R ./cloud-formation $ARTIFACT_LOCATION  && sudo chown -R jenkins $ARTIFACT_LOCATION"
			//&& sudo cp -R ./app/src/main/resources/apps $ARTIFACT_LOCATION/apps

            //added to tag git commit for upper environment deployment
            // NTUC gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
			// NTUC shortCommit = gitCommit.take(6)

            echo "Compile :: END"

        }
		stage ('Static Analysis') {

            echo "Static Analysis :: START"
            sh "./buildenv/jenkins-test-static-analysis.sh"
            //runSonarScan(env.SONAR_URL)

            echo "Static Analysis :: END"
        }
        stage ('Tests') {
            echo "Tests :: START"
        	//Provision access for AWS IAM role with RT Cross Account credentials file.
            //sh "/build/obtain-cross-account-credentials.sh ${AWS_RT_IAM_CROSS_ACCOUNT}"
			// NTUC sh "/build/obtain-cross-account-credentials.sh ${AWS_RT_IAM_CROSS_ACCOUNT_CONFIG_DT}"

            //Unit Tests need access to AWS Elastic Search.
      	    sh "./buildenv/jenkins-test-unit-test.sh"

            echo "Tests :: END"
       	}

        stage ('Deployment') {
            echo "Deployment :: START"
          //Provision access for AWS IAM role with RT Cross Account credentials file.
            //sh "/build/obtain-cross-account-credentials.sh ${AWS_RT_IAM_CROSS_ACCOUNT}"
      // NTUC sh "/build/obtain-cross-account-credentials.sh ${AWS_RT_IAM_CROSS_ACCOUNT_CONFIG_DT}"

            //Unit Tests need access to AWS Elastic Search.
            sh "./buildenv/jenkins-deployment.sh"

            echo "Deployment :: END"
        }

    }
}
catch (err) {
    currentBuild.result = 'FAILURE'
    throw err
}
