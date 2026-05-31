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

        stage('Check Files') {
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

        stage('Sonar Scan') {
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
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Upload Binary File') {
            steps {
                rtUpload(
                    serverId: 'artifactory',
                    spec: '''{
                        "files": [
                            {
                                "pattern": "target/*.jar",
                                "target": "javaspc/"
                            }
                        ]
                    }'''
                )

                rtPublishBuildInfo(
                    serverId: 'artifactory'
                )
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}
