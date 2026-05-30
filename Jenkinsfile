pipeline {
    agent any

    tools {
        maven 'Maven'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

        stage('Build-And-SonarScan') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                        pwd
                        ls -la

                        mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=petclinic \
                        -Dsonar.projectName=petclinic \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.token=$SONAR_AUTH_TOKEN
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build and SonarQube Scan Completed Successfully'
        }

        failure {
            echo 'Build or SonarQube Scan Failed'
        }
    }
}
