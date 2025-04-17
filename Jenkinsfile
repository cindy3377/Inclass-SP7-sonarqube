pipeline {
    agent any
    tools {
        maven 'Maven3'
        jdk 'JDK 21'
    }

    environment {
        DOCKERHUB_CREDENTIALS_ID = 'Docker_Hub'
        DOCKERHUB_REPO = 'cindy3377/Inclass-SP7-sonarqube'
        DOCKER_IMAGE_TAG = 'latest_v1'
        // Set PATH explicitly for Jenkins
        PATH = "/usr/local/bin:$PATH"
        SONARQUBE_SERVER = 'Sonarqube'  // The name of the SonarQube server configured in Jenkins
        SONAR_TOKEN = 'sqa_1355975db9cb9e1684e315e6acbe9c745611ef75'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/cindy3377/Inclass-SP7-sonarqube.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('Sonarqube') {
                    sh '''
                        /Users/trang/Applications/sonar-scanner-7.0.2.4839-macosx-x64/bin/sonar-scanner \
                        -Dsonar.projectKey=devops-demo \
                        -Dsonar.projectName=DevOps-Demo \
                        -Dsonar.sources=src \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.login=${SONAR_TOKEN}
                    '''
                }
            }
        }
    }
}