pipeline {
    agent {
        label 'SPC'
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('git checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git'
            }
        }

        stage('scan') {
            steps {
                withCredentials([string(credentialsId: 'sonar_id', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('SONAR') {
                        sh """
                        mvn clean verify sonar:sonar \
                          -Dsonar.projectKey=longflewtinku_spring-petclinic \
                          -Dsonar.organization=longflewtinku-2 \
                          -Dsonar.host.url=https://sonarcloud.io \
                          -Dsonar.login=\$SONAR_TOKEN
                        """
                    }
                }
            }
        }

        stage('upload binaryfile') {
            steps {
                rtUpload(
                    serverId: 'jfrog',
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
                    serverId: 'jfrog'
                )
            }
        }
    }
}