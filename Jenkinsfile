pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    sh '''#!/bin/bash
                    python3.7 -m venv venv
                    source venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh '''#!/bin/bash
                    chmod +x system_resources_test.sh
                    ./system_resources_test.sh
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh '''#!/bin/bash
                    source venv/bin/activate
                    eb create BankPipeline9 --single
                    '''
                }
            }
        }
    }
}
