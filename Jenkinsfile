pipeline {
    agent {
        label 'OneS'
    }
    environment {
        envString = 'true'
    }
    post {
        always {
            bat "echo always"        
        }
        failure {
            bat "echo failure"
        }
        success {
            bat "echo success"
        }
    }
    stages {
        stage("Этап") {
            steps {
              bat "Message from step"
              bat "echo Variable envString =${envString}"
              script{
                scannerHome = tool "sonar-scanner"
              }

            }
        }
           }
}