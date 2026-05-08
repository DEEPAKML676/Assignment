pipeline {
    agent any

    environment {
        IMAGE_NAME = "nodejs-app"
        CONTAINER_NAME = "nodejs-container"

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
                withSonarQubeEnv('SonarQube') {

                    sh '''
                        docker run --rm \
                        -e SONAR_HOST_URL=$SONAR_HOST_URL \
                        -e SONAR_TOKEN=$SONAR_AUTH_TOKEN \
                        -v $(pwd):/usr/src \
                        -w /usr/src \
                        sonarsource/sonar-scanner-cli \
                        -Dsonar.projectKey=assignment-project \
                        -Dsonar.projectName=assignment-project \
                        -Dsonar.sources=app \
                        -Dsonar.working.directory=/usr/src/.scannerwork
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
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
                    trivy image --exit-code 1 \
                    --severity HIGH,CRITICAL \
                    $IMAGE_NAME
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

        stage('Deploy Container') {
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