pipeline {
    agent {
        label 'SPCJAVA'
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Git Checkout') {
            steps {
                git(
                    url: 'https://github.com/makkavenu341-boop/Jenkins-Petclinic.git',
                    branch: 'main'
                )
            }
        }

        stage('Build') {
            steps {
                dir('petclinic') {
                    sh 'mvn clean install -DskipTests'
                }
            }
        }

        stage('Sonar Scan') {
            steps {
                dir('petclinic') {
                    withCredentials([
                        string(credentialsId: 'sonar_id', variable: 'SONAR_TOKEN')
                    ]) {

                        withSonarQubeEnv('sonar') {

                            sh """
                            mvn sonar:sonar \
                            -Dsonar.projectKey=makkavenu341-boop_jenkins-petclinic \
                            -Dsonar.organization=makkavenu341-boop \
                            -Dsonar.host.url=https://sonarcloud.io \
                            -Dsonar.token=$SONAR_TOKEN
                            """
                        }
                    }
                }
            }
        }

        stage('Upload Artifact') {
            steps {
                rtUpload(
                    serverId: 'JFROG_ID',
                    spec: '''{
                        "files": [
                            {
                                "pattern": "petclinic/target/*.jar",
                                "target": "javaspc/"
                            }
                        ]
                    }'''
                )

                rtPublishBuildInfo(
                    serverId: 'JFROG_ID'
                )
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}