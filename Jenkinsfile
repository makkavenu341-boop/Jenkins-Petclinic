pipeline{
    agent{label 'SPCJAVA'}
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('git checkout') {
            steps {
                git url: "https://github.com/makkavenu341-boop/Jenkins-Petclinic.git" ,
                branch: "main"
            }
        }
        stage('scan') {
            steps {
                withCredentials([string(credentialsId: 'sonar_id', variable: 'SONAR_TOCKEN')]) {
                 withSonarQubeEnv('SONAR') {
                    sh """mvn clean verify sonar:sonar \
                          -Dsonar.projectKey=longflewtinku_spring-petclinic \
                          -Dsonar.organization=longflewtinku-2 \
                          -Dsonar.host.url=https://sonarcloud.io/ \
                          -Dsonar.login=SONAR_TOKEN"""
                    }
                }
            }
        }
            stage('upload binaryfile') {
                step {
                    rtUpload (
                        serverId: 'JFROG_ID',
                        spec: '''{
                           "files": [
                           {
                             "pattern": "target/*.jar",
                             "target": "javaspc/"
                            }
                            ]
                        }'''
                    )
                    rtPublishBuildInfo(serverId: 'JFROG_ID')
                }
            }
    }
}