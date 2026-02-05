pipeline {
    agent any

    environment {
        // Centralize your Sonar settings for easy updates
        SONAR_PROJECT_KEY = "flask-student-demo"
        SONAR_HOST_URL    = "http://localhost:9000"
        SONAR_TOKEN       = "sqp_e70065d2e97f245e58ce20f43dcb24904607586f"
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins automatically checks out code, but this ensures a clean start
                checkout scm
            }
        }

        stage('Setup & Install') {
            steps {
                sh '''
                    python3 -m venv venv
                    ./venv/bin/pip install --upgrade pip
                    ./venv/bin/pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                // Runs pytest; || true ensures the pipeline continues to Sonar scan even if tests fail
                sh './venv/bin/python -m pytest || true'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // This uses the Docker CLI installed in your custom Jenkins image
                // It connects to the host's Docker engine via /var/run/docker.sock
                sh """
                docker run --rm \
                    -v "${WORKSPACE}:/usr/src" \
                    --network="host" \
                    -e SONAR_HOST_URL="${SONAR_HOST_URL}" \
                    -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.exclusions=**/.pytest_cache/**" \
                    -e SONAR_TOKEN="${SONAR_TOKEN}" \
                    sonarsource/sonar-scanner-cli
                """
            }
        }
    }

    post {
        always {
            // Keep the workspace clean after the build
            cleanWs()
        }
        success {
            echo 'Build and Sonar Analysis completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for errors.'
        }
    }
}
