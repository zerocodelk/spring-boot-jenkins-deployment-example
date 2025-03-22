pipeline {
    agent any

    tools {
        // References to the tools configured in Jenkins
        jdk 'HostJDK'
        maven 'HostMaven'
    }

    stages {

        stage('Verify Tools') {
            steps {
                // Verify that host tools are correctly mounted and accessible
                sh 'java -version'
                sh 'mvn -version'
                sh 'docker -v'
                echo "Build number: ${BUILD_NUMBER}"
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/zerocodelk/spring-boot-jenkins-deployment-example.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh 'docker-compose build'
                sh 'docker-compose up -d'
            }
        }
    }
}
