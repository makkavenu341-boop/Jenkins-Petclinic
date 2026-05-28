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
                    url: 'https://github.com/kalyan8406/spring-petclinic.git'
            }
        }

        stage('Build and Scan') {
            steps {

                withSonarQubeEnv('sonar') {

                    withCredentials([string(credentialsId: 'sonarq-id', variable: 'SONAR_TOKEN')]) {

                        sh """
                            mvn clean verify sonar:sonar -e \
                            -DskipTests \
                            -Dsonar.projectKey=kalyan8406_petclinic \
                            -Dsonar.organization=kalyan8406 \
                            -Dsonar.host.url=https://sonarcloud.io \
                            -Dsonar.token=$SONAR_TOKEN
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
}
