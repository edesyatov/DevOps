pipeline {
    agent {
        label 'OneS'
    }
    environment {
        envString = 'true'
    }
    post {
        always {
            allure includeProperties: false, jdk: '', results: [[path: 'out/syntax-check/allure']]
            junit allowEmptyResults: true, testResults: 'out/syntax-check/junit/junit.xml'        
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
        stage("Синтаксический контроль") {
            steps {
                script {
                    try {
                        bat "chcp 65001\n vrunner syntax-check"
                    } catch(Exception Exc) {
                        currentBuild.result = 'UNSTABLE'
                    }
                }
            }
        }
    }
    
}