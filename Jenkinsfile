pipeline {
    agent any

    environment {
        IMAGE_NAME    = "nodejs-app"
        CONTAINER_NAME = "nodejs-container"
        SONAR_TOKEN   = credentials('sonar-token')
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/DEEPAKML676/Assignment.git'
            }
        }

        stage('SonarQube Scan') {
            steps {
                sh '''
                    docker run --rm \
                    -e SONAR_HOST_URL="http://34.234.211.36:9000" \
                    -e SONAR_TOKEN=$SONAR_TOKEN \
                    -v $(pwd):/usr/src \
                    sonarsource/sonar-scanner-cli \
                    -Dsonar.projectKey=assignment-project \
                    -Dsonar.projectName=assignment-project \
                    -Dsonar.sources=app
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME ./app'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker run -d \
                    --name $CONTAINER_NAME \
                    -p 3000:3000 \
                    $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'docker ps'
            }
        }
    }
}