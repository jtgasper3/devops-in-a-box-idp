pipeline {
    agent { 
        label 'docker'
    }
    environment {
        REGISTRY = 'admin-swarm.local'
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
                    //docker.withRegistry("https://${REGISTRY}", 'credentials-id') {
                    docker.withRegistry("https://${REGISTRY}") {
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
            environment {
                DOCKER_TLS_VERIFY = 1
                DOCKER_HOST = 'tcp://iam-swarm-mngr-1.local:2376'
            }
            steps {
                withCredentials([dockerCert(credentialsId: 'iam-swarm',
                        variable: 'DOCKER_CERT_PATH')]) {
                    sh "docker service update --with-registry-auth --image ${REGISTRY}/${IMAGE}:${env.BUILD_NUMBER} idp"
                }
            }
        }
    }
}
