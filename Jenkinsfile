pipeline {
    agent any

    tools {
        // Define the Maven tool configuration
        maven 'apache_maven_3.6.3'
    }

    stages {
        stage('Build') {
            steps {
                // Compile the code using Maven
                sh "mvn clean compile"
            }
        }

        stage('Test') {
            steps {
                // Run tests using Maven
                sh "mvn test"
            }
            post {
                always {
                    // Archive test results and generate reports
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the application using Maven
                sh "mvn deploy"
            }
            post {
                always {
                    // Archive artifacts from the deploy stage (optional)
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                }
            }
        }
    }

    post {
        success {
            // Actions to take if the build succeeds
            echo 'Build and deployment successful!'
        }
        failure {
            // Actions to take if the build fails
            echo 'Build or deployment failed.'
        }
    }
}
