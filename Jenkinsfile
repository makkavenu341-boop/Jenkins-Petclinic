pipeline {
<<<<<<< HEAD
    agent any

    tools {
        maven 'Maven'
=======
    agent { labels 'SPC'}

    triggers {
        pollSCM('H/5 * * * *')
>>>>>>> 5249e39 (updated-jenkins)
    }

    stages {

        stage('git checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

<<<<<<< HEAD
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
=======
        stage('scan') {
            steps {
                withSonarQubeEnv('SONAR') {

                    withCredentials([
                        string(credentialsId: 'sonar-id', variable: 'SONAR_TOKEN')
                    ]) {

                        sh """
                            mvn clean verify sonar:sonar \
                            -DskipTests \
                            -Dsonar.projectKey=makkavenu341-boop_spring-petclinic \
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
>>>>>>> 5249e39 (updated-jenkins)
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
