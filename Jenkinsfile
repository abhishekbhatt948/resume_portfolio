pipeline {
    agent {
        docker {
            image 'python:3.9'  // Python Docker image with pip installed
        }
    }

    environment {
        DOCKER_IMAGE = 'abhishekbhatt948/resume_portfolio'
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials'
        GIT_REPO = 'https://github.com/abhishekbhatt948/resume_portfolio.git'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'
            }
        }

	stage('Set Up Virtual Environment') {
	    steps {
	            sh '''
		            python3 -m venv venv  # Create virtual environment
			            source venv/bin/activate  # Activate virtual environment
				            pip install -r requirements.txt  # Install dependencies in virtual environment
					            '''
						        }
							}


        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'  // Install Python dependencies
            }
        }

        stage('Test') {
            steps {
                sh 'python -m unittest discover -s tests'  // Running tests
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image and tag it
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                        
                        // Push Docker image to Docker Hub
                        sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace and Docker environment after build
            sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"
            echo 'CI Pipeline finished.'
        }
    }
}
