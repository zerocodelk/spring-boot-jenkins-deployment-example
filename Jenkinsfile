pipeline {
    agent any  // Use any available agent for the entire pipeline

    options {
        // Set a timeout for the entire pipeline to prevent infinite runs
        timeout(time: 30, unit: 'MINUTES')
        // Discard old builds
        buildDiscarder(logRotator(numToKeepStr: '5'))
        // Don't run concurrent builds of the same branch
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code with timeout and retry for network issues
                timeout(time: 5, unit: 'MINUTES') {
                    retry(3) {
                        git branch: 'master', url: 'https://github.com/zerocodelk/spring-boot-jenkins-deployment-example.git'
                    }
                }
            }
        }

        stage('List Files') {
                steps {
                    sh 'ls -la'
                    sh 'pwd'
                }
        }

        stage('Build with Maven') {
            agent {
                docker {
                    image 'maven:3.8.7-eclipse-temurin-17'
                    reuseNode true
                    args '-v $HOME/.m2:/root/.m2 -e MAVEN_OPTS="-Xmx1024m"'
                }
            }
            steps {
                // Maven build with timeout
                timeout(time: 10, unit: 'MINUTES') {
                    sh 'mvn clean install -DskipTests'
                }
            }
            post {
                // Archive the JAR file for later use
                success {
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
            }
        }

        stage('Clean Docker Environment') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    sh 'docker-compose down --volumes --remove-orphans || true'
                    // Optional: prune unused Docker resources if space is an issue
                    // sh 'docker system prune -f'
                }
            }
        }

        stage('Build and Deploy with Docker Compose') {
            agent {
                 docker { image 'docker:latest' }
            }
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    // Build the Docker images
                    sh 'docker-compose build --no-cache'

                    // Run the containers in detached mode with force-recreate
                    sh 'docker-compose up -d --force-recreate'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    // Wait for application to be available - adjust URL as needed
                    sh 'for i in $(seq 1 30); do curl -s http://localhost:8080/actuator/health && break || sleep 5; done'
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        failure {
            // On failure, ensure we don't leave hanging Docker containers
            sh 'docker-compose down --volumes --remove-orphans || true'
        }
        success {
            echo 'Deployment completed successfully!'
        }
    }
}