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
         stage("Создание тестовой базы") {
            steps {
                bat "chcp 65001\n vrunner init-dev --dt C:\\DevOps\\dt\\demo.dt --db-user Администратор --src src/cf"
            }
        }
    }
}