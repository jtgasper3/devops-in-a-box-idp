pipeline {
    agent { 
        label 'docker'
    }
    environment {
        REGISTRY = '10.211.56.10'
        IMAGE_NAME = 'iam/shibboleth-idp'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    //docker.withRegistry("${REGISTRY}", 'credentials-id') {
                    docker.withRegistry("${REGISTRY}") {
                        sh "docker image build --no-cache --pull --build-arg REGISTRY=${REGISTRY} --tag ${IMAGE_NAME}:${BUILD_NUMBER} ."
                        sh "docker image tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"

                        docker.image("${IMAGE_NAME}:latest").push()
                        docker.image("${IMAGE_NAME}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
