pipeline {
    agent any // Use any available Jenkins agent (assuming Docker is installed on the agent)

    environment {
        DOCKER_IMAGE = 'abhishekbhatt948/resume_portfolio' // Your Docker image name
        DOCKER_PASS  = 'abhi948@docker'
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
                    // Hardcoded Docker Hub username and password
                    sh "docker login -u 'abhi948docker' -p ${DOCKER_PASS}"
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
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
