pipeline {
    agent any // Use any available Jenkins agent (assuming Docker is installed on the agent)

    environment {
        DOCKER_IMAGE = 'abhishekbhatt948/resume_portfolio' // Your Docker image name
        DOCKER_CREDENTIALS_ID = 'DOCKER_CREDENTIALS_ID'  // Your Docker Hub credentials ID
        GIT_REPO = 'https://github.com/abhishekbhatt948/resume_portfolio.git' // Your Git repository
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull code from GitHub
                git url: "${GIT_REPO}", branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Docker command directly on the Jenkins agent
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
