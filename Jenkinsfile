pipeline {
    agent any

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

        stage('Debug') {
            steps {
                sh '''
                    echo "Current Directory:"
                    pwd

                    echo "Workspace Files:"
                    ls -la

                    echo "Checking Sonar Scanner..."
                    which sonar-scanner || true

                    echo "Sonar Scanner Version..."
                    sonar-scanner --version || true
                '''
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
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
