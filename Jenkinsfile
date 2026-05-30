pipeline {
    agent any

    tools {
        sonarQubeScanner 'sonar-scanner'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

        stage('Sonar Scan') {
            steps {
                withSonarQubeEnv('sonar') {
                    withCredentials([
                        string(credentialsId: 'sonar-id', variable: 'SONAR_TOKEN')
                    ]) {
                        sh '''
                        sonar-scanner \
                          -Dsonar.projectKey=makkavenu341-boop-spring-petclinic \
                          -Dsonar.organization=makkavenu341-boop \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=https://sonarcloud.io \
                          -Dsonar.token=$SONAR_TOKEN
                        '''
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
