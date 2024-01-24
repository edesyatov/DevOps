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
              bat "Сообщение из Этапа"
              bat "echo Переменная envString =${envString}"
              script{
                scannerHome = tool "sonar-scanner"
              }

            }
        }
           }
}