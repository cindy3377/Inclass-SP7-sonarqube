pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'Sonarqube' // Jenkins SonarQube server config name
        DOCKER_IMAGE = 'cindy3377/devops-demo'
    }

    tools {
        maven 'Maven' // Ensure this matches the name in Jenkins Global Tool Configuration
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/cindy3377/Inclass-SP7-sonarqube.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh 'sonar-scanner -Dsonar.projectKey=devops-demo -Dsonar.sources=. -Dsonar.java.binaries=target'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs.'
        }
    }
}
