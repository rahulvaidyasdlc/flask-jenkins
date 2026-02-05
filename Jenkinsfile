pipeline {
    agent any

    stages {
        stage('Setup Environment') {
            steps {
                // Creates a clean virtual environment in the workspace
                sh 'python3 -m venv venv'
            }
        }

        stage('Install Dependencies') {
            steps {
                // You must use the pip inside the venv
                sh './venv/bin/pip install --upgrade pip'
                sh './venv/bin/pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                // Ensure pytest is in your requirements.txt or install it here
                sh './venv/bin/python -m pytest'
            }
        }
    }

    post {
        always {
            // Cleans up the workspace (including the venv folder) after build
            cleanWs()
        }
    }
}
