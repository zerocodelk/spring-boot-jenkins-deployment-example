pipeline {
    agent any

    stages {

        stage('Verify Tools') {
            steps {
                // Verify that host tools are correctly mounted and accessible
                sh 'java -version'
                sh 'mvn -version'
                sh 'docker -v'
                echo "Build number: ${BUILD_NUMBER}"
                sh "pwd"
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                url: 'https://github.com/zerocodelk/spring-boot-jenkins-deployment-example.git'
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
