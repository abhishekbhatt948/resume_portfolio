pipeline {
    agent {
        docker {
            image 'python:3.9'  // Use a Python Docker image with pip installed
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // Mount Docker socket for Docker commands
        }
    }

    environment {
        DOCKER_IMAGE = 'abhishekbhatt948/resume_portfolio'  // Your Docker image name
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials'     // Jenkins credentials ID for Docker Hub
        GIT_REPO = 'https://github.com/abhishekbhatt948/resume_portfolio.git'  // GitHub repository URL
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'  // Checkout code from the repository
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'  // Install Python dependencies
            }
        }

        stage('Run Tests') {
            steps {
                sh 'python -m unittest discover -s tests'  // Run tests
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."  // Build Docker image
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"  // Log in to Docker Hub
                        sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"  // Push Docker image to Docker Hub
                    }
                }
            }
        }
    }

    post {
        always {
            sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"  // Clean up Docker images
            echo 'CI Pipeline finished.'  // Final message
        }
    }
}
