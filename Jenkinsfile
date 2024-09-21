pipeline {
    agent {
        docker {
            image 'docker:latest' // Docker-in-Docker
            args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount Docker socket
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
        
         stage('Install Python') {
            steps {
                    sh '''
                    apk add --no-cache python3 py3-pip
                    ln -sf python3 /usr/bin/python  # Create a symlink if needed
                    '''
                }
         }
        stage('Run Tests') {
            steps {
                // Run unit tests with unittest
                sh 'python3 -m unittest discover -s tests'
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
            sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER} || true"
            echo 'CI Pipeline finished.'
        }
    }
}
