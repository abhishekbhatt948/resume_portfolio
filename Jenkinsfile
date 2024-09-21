pipeline {
    agent any
    //     docker {
    //         image 'python:3.9'  // Use a Python Docker image
    //         args '-v /var/run/docker.sock:/var/run/docker.sock'  // Mount Docker socket
    //     }
    // }

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

        stage('Run Tests') {
            steps {
                sh 'python -m unittest discover -s tests'  // Run tests
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
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
            sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"
            echo 'CI Pipeline finished.'
        }
    }
}
