pipeline {
    agent {
        docker {
            image 'python:3.9'  // Use a Python Docker image
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // Mount Docker socket to run Docker commands inside the container
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
                // Pull code from GitHub
                git url: "${GIT_REPO}", branch: 'main'
            }
        }
        
        // stage('Install Dependencies') {
        //     steps {
        //         // Install dependencies from requirements.txt
        //         sh '''
        //         python -m venv venv  # Create virtual environment
        //         . venv/bin/activate   # Activate the virtual environment
        //         pip install -r requirements.txt  # Install dependencies
        //         '''
        //     }
        // }

        stage('Run Tests') {
            steps {
                // Run unit tests with unittest
                sh 'python3 -m unittest discover -s tests'
            }
        }
        stage('Docker Installation') {
            steps {
                script {
                    // Update package list and install Docker
                    sh '''
                    apt-get update
                    apt-get install sudo
                    sudo apt-get install -y docker.io
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Use Docker credentials to log in and push the image
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images to free up space
            sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"
            echo 'CI Pipeline finished.'
        }
    }
}
