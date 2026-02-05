pipeline {
    agent any

    stages {
        stage('Setup Environment') {
            steps {
                // Install python3-venv if pip is missing
                sh 'python3 -m venv venv'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Use the pip inside the virtual environment
                sh './venv/bin/pip install --upgrade pip'
                sh './venv/bin/pip install -r requirements.txt'
            }
        }

        stage('Run Tests & Coverage') {
            steps {
                // Run tests using the venv python
                sh './venv/bin/python -m pytest'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
