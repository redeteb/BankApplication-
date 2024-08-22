pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                python3.7 -m venv venv
                . venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                pip install awsebcli  # Install the EB CLI within the virtual environment
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
                . venv/bin/activate
                eb create Bank_Application_main --single
                '''
            }
        }
    }
}

