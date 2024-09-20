pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'abhishekbhatt948/resume_portfolio'  // Your Docker image name
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials'     // Jenkins credentials ID for Docker Hub
        GIT_REPO = 'https://github.com/abhishekbhatt948/resume_portfolio.git'  // GitHub repository URL
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'
            }
        }
    pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'abhishekbhatt948/resume_portfolio'  // Your Docker image name
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials'     // Jenkins credentials ID for Docker Hub
        GIT_REPO = 'https://github.com/abhishekbhatt948/resume_portfolio.git'  // GitHub repository URL
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${GIT_REPO}", branch: 'main'
            }
        }

        // stage('Python and Pip Installation Check') {
        //     steps {
        //         sh '''
        //         sudo apt-get update
        //         sudo apt-get install -y python3
        //         sudo apt-get install -y python3-pip
        //         '''
        //     }
        // }
        
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'  // Python dependencies
            }
        }
        
        stage('Test') {
            steps {
                sh 'python3 -m unittest discover -s tests'  // Running tests
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
        // stage('Python and Pip Installation Check') {
        //     steps {
        //         sh '''
        //         sudo apt-get update
        //         sudo apt-get install -y python3
        //         sudo apt-get install -y python3-pip
        //         '''
        //     }
        // }
        
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'  // Python dependencies
            }
        }
        
        stage('Test') {
            steps {
                sh 'python3 -m unittest discover -s tests'  // Running tests
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
