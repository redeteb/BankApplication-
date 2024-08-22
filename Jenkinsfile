pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                python3.7 -m venv venv
                source venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }
        
        stage('Test') {
            steps {
                sh '''
                chmod +x system_resources_test.sh
                ./system_resources_test.sh
                '''
            }
        }
        
        stage('Deploy') {
            steps {
                sh '''
                source venv/bin/activate
                eb create Bank_Application_main --single
                '''
            }
        }
    }
}
