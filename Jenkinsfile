pipeline{
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
				bat "docker-compose up -d hub chrome firefox"
			}
		}
		stage("Run Test"){
			steps{
				//sh
				bat "docker-compose up search-module book-flight-module"
			}
		}
	}
	post{
		always{
			archiveArtifacts artifacts: 'output/**'
			bat "docker-compose down"
			//sh "sudo rm -rf output/"
			bat "rmdir /s/q output/"
		}
	}
}