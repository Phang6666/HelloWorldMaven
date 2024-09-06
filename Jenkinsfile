pipeline { 
    agent any 
    stages { 
        stage('Checkout') { 
            steps { 
                git branch: 'master', url: 'https://github.com/kayjin03/HelloWorldMaven.git' 
            } 
        } 
        stage('Build') { 
            steps { powershell 'mvn clean package'} 
        } 
        stage('Test') { 
            steps { powershell 'mvn clean test'} 
        } 
        stage('Deploy') { 
            steps { powershell 'java -jar target/HelloWorldMaven-1.1.1-RELEASE-jar-with-dependencies.jar'}            
        }     
}
post { 
always { 
echo 'Cleaning up workspace' 
deleteDir() // Clean up the workspace after the build 
} 
success { 
echo 'Build succeeded!!!' 
// You could add notification steps here 
} 
failure { 
echo 'Build failed!' 
// You could add notification steps here 
} 
} 
} 
