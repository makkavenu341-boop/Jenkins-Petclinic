pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK17'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Sonar Scan') {
            steps {
                script {
                    def scannerHome = tool('sonar-scanner')

                    withSonarQubeEnv('sonar') {
                        withCredentials([
                            string(credentialsId: 'sonar-id', variable: 'SONAR_TOKEN')
                        ]) {
                            sh """
                            ${scannerHome}/bin/sonar-scanner \
                              -Dsonar.projectKey=makkavenu341-boop-spring-petclinic \
                              -Dsonar.organization=makkavenu341-boop \
                              -Dsonar.sources=. \
                              -Dsonar.java.binaries=target/classes \
                              -Dsonar.host.url=https://sonarcloud.io \
                              -Dsonar.token=$SONAR_TOKEN
                            """
                        }
                    }
                }
            }
        }
    }
}
