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
        stage("step") {
            steps {
              bat "echo Message from step"
              bat "echo Message from step"
              script {
                scannerHome = tool "sonar-scanner"
              }
             }
        }
    }
}