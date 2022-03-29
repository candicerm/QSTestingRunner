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
				bat "docker compose up smoke-chrome"
				bat "checkerrors.bat"
			}
		}
	}
	environment {
        EMAIL_TO = 'quickschools_board_635908823_614f5cfb1a5327bcff0f__4844336@use1.mx.monday.com'
    }
	post{
		always{
			script {
				if (currentBuild.currentResult == 'FAILURE') {
					emailext body: 'Check console output at $BUILD_URL to view the results. \n\n ${CHANGES} \n\n -------------------------------------------------- \n${BUILD_LOG, maxLines=100, escapeHtml=false}', 
                    to: "${EMAIL_TO}", 
                    subject: 'Build FAILURE in Jenkins: H4_R_20220329_SSC'
				}
				else {
					emailext body: 'Attach test result report here.', 
                    to: "${EMAIL_TO}", 
                    subject: 'Build SUCCESS in Jenkins: H4_R_20220329_SSC'
				}
			}
			archiveArtifacts artifacts: 'output/**'
			bat "docker-compose down"
			//sh "sudo rm -rf output/"
			//bat "rmdir /s/q output"
		}
	}
}