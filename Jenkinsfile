pipeline {
    agent {
        label 'SPC'
    }

    triggers {
        pollSCM('H/5 * * * *')
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

        stage('Verify Project Structure') {
            steps {
                sh '''
                    echo "Current Directory:"
                    pwd

                    echo "Workspace Files:"
                    ls -la

                    echo "Searching for pom.xml..."
                    find . -name pom.xml
                '''
            }
        }

        stage('Build & Sonar Scan') {
            steps {
                withSonarQubeEnv('SONAR') {
                    withCredentials([
                        string(credentialsId: 'sonar-id', variable: 'SONAR_TOKEN')
                    ]) {
                        sh '''
                            mvn clean verify sonar:sonar \
                            -DskipTests \
                            -Dsonar.projectKey=makkavenu341-boop_spring-petclinic \
                            -Dsonar.organization=makkavenu341-boop \
                            -Dsonar.host.url=https://sonarcloud.io \
                            -Dsonar.login=$SONAR_TOKEN
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

        stage('JFrog Upload') {
            steps {
                rtUpload(
                    serverId: 'artifactory',
                    spec: '''{
                        "files": [{
                            "pattern": "target/*.jar",
                            "target": "libs-release-local/"
                        }]
                    }'''
                )

                rtPublishBuildInfo(
                    serverId: 'artifactory'
                )
            }
        }
    }

    post {
        always {
            cleanWs()
        }

        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check console output.'
        }
    }
}
