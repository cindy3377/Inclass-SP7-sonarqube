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
        SONARQUBE_SERVER = 'SonarQube'  // The name of the SonarQube server configured in Jenkins
        SONAR_TOKEN = 'sqa_89410aae23f6e5d65088b544a3698b099411c681' // Store the token securely
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

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        sonar-scanner ^
                        -Dsonar.projectKey=devops-demo ^
                        -Dsonar.sources=src ^
                        -Dsonar.projectName=DevOps-Demo ^
                        -Dsonar.host.url=http://localhost:9000 ^
                        -Dsonar.login=${env.SONAR_TOKEN} ^
                        -Dsonar.java.binaries=target/classes
                    """
                }
            }
        }

    }
}