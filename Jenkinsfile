pipeline {
    agent {
        // This runs your steps inside a Python container
        docker { 
            image 'python:3.9-slim' 
        }
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'pip install --upgrade pip'
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests & Coverage') {
            steps {
                // Adjust this to your actual test command (e.g., pytest)
                sh 'python -m pytest'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}