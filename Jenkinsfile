pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'Sonarqube' // Jenkins SonarQube server config name
        DOCKER_IMAGE = 'cindy3377/devops-demo'
    }

    tools {
        maven 'Maven3' // Ensure this matches the name in Jenkins Global Tool Configuration
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
                    withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                        sh 'mvn sonar:sonar -Dsonar.projectKey=devops-demo -Dsonar.token=$SONAR_TOKEN -Dsonar.java.binaries=target'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            environment {
                PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
            }
            steps {
                sh 'echo "Checking Docker version..."'
                sh 'which docker'
                sh 'docker --version'
                sh 'docker build -t cindy3377/devops-demo .'
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
