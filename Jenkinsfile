pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK17'
    }

    triggers {
        pollSCM('H/5 * * * *')
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

        stage('Build and Sonar Scan') {
            steps {
                withSonarQubeEnv('sonar') {

                    withCredentials([
                        string(credentialsId: 'sonar-id', variable: 'SONAR_TOKEN')
                    ]) {

                        sh """
                            mvn clean verify sonar:sonar \
                            -DskipTests \
                            -Dsonar.projectKey=makkavenu341-boop-spring-petclinic \
                            -Dsonar.organization=makkavenu341-boop \
                            -Dsonar.host.url=https://sonarcloud.io \
                            -Dsonar.login=$SONAR_TOKEN
                        """
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}