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

        stage('Verify Workspace') {
            steps {
                sh '''
                    pwd
                    ls -la
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

        stage('Upload Artifact to JFrog') {
            steps {
                rtUpload(
                    serverId: 'artifactory',
                    spec: '''{
                        "files": [
                            {
                                "pattern": "target/*.jar",
                                "target": "SPC/"
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
