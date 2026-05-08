pipeline {
    agent any

    environment {
        IMAGE_NAME = "nodejs-app"
        CONTAINER_NAME = "nodejs-container"

        SONAR_TOKEN = credentials('sonar-token')

        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKERHUB_USERNAME = 'deepakml2000'
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/DEEPAKML676/Assignment.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    cd app
                    npm install
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    cd app
                    npm test || true
                '''
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
                sh '''
                    docker build -t $IMAGE_NAME ./app
                '''
            }
        }

        stage('Security Scan') {
            steps {
                sh '''
                    trivy image --severity HIGH,CRITICAL \
                    $IMAGE_NAME || true
                '''
            }
        }

        stage('Docker Hub Login') {
            steps {
                sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login \
                    -u $DOCKERHUB_CREDENTIALS_USR \
                    --password-stdin
                '''
            }
        }

        stage('Docker Push') {
            steps {
                sh '''
                    docker tag $IMAGE_NAME \
                    $DOCKERHUB_USERNAME/$IMAGE_NAME:latest

                    docker push \
                    $DOCKERHUB_USERNAME/$IMAGE_NAME:latest
                '''
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
                sh '''
                    docker ps
                '''
            }
        }
    }

    post {

        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}