pipeline {
	// master executor should be set to 0
	agent any
	stages{
		stage("Pull Latest Image"){
			steps{
				//sh
				bat "docker pull candicerm/qsuitest"
			}
		}
		stage("Start Grid"){
			steps{
				//sh
				bat "docker compose up -d hub chrome"
			}
		}
		stage("Run Test"){
			steps{
				//sh
				//bat "docker compose up smoke-chrome login-quick-chrome oms-chrome"
				//bat "docker compose up guitest-chrome emailtest-chrome"
				bat "docker compose up guitest-chrome"
				bat "checkerrors.bat"
			}
		}
	}
	environment {
		//EMAIL_TO = 'quickschools_board_635908823_614f5cfb1a5327bcff0f__4844336@use1.mx.monday.com'
		EMAIL_TO = 'candice@quickschools.com'
		TIMESTAMP = bat(script: '''@echo off 
						timestamp.bat
						''', returnStdout: true).trim()
    }
	post{
		always{
			script {
				if (currentBuild.currentResult != 'ABORTED') {
					// Print Report to PDF
					// Build in the parent directory
					dir ("../../") {
						bat "docker build -f workspace/QSUITEST_RUNNER/Dockerfile -t candicerm/printreport ."
					}
					bat "docker compose run printreport-output"
					// Send Email
					emailext attachmentsPattern: 'output/pdf/*', 
					body: 'Please see attached Test Results Report', 
					to: "${EMAIL_TO}", 
					subject: "QSTesting Build #${BUILD_NUMBER} $currentBuild.currentResult in Jenkins: SSC_${TIMESTAMP}"
				} else {
					// Send Email without PDF Report
					emailext body: 'Build aborted.', 
					to: "${EMAIL_TO}", 
					subject: "QSTesting Build #${BUILD_NUMBER} $currentBuild.currentResult in Jenkins: SSC_${TIMESTAMP}"
				}
			}
			archiveArtifacts artifacts: 'output/**'			
			bat "docker-compose down"
			//sh "sudo rm -rf output/"
			bat "rmdir /s/q output"
		}
	}
}