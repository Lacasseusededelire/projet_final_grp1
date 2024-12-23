pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'marieemko/ic-webapp:v1.0'
        DOCKER_USERNAME = 'marieemko'
	DOCKER_PASSWORD = 'ndomemouto'
        GIT_URL = 'https://github.com/Lacasseusededelire/projet_final_grp1.git'
        GIT_BRANCH = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git branch: "${GIT_BRANCH}", url: "${GIT_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker image...'
                sh '''
                docker build -t ${DOCKER_IMAGE} .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login non interactif
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    // Push de l'image Docker
                    sh 'docker push marieemko/ic-webapp:v1.0'
                }
            }
	}   
        stage('Deploy Application') {
            steps {
                echo 'Deploying the application...'
                sh '''
                # Arrêter et supprimer le conteneur existant, s'il existe
                docker stop ic-webapp || true
                docker rm ic-webapp || true

                # Extraire l'image la plus récente et lancer un nouveau conteneur avec les variables d'environnement
                docker pull ${DOCKER_IMAGE}
                docker run -d --name ic-webapp -p 8087:8080 \
                -e ODOO_URL=https://www.odoo.com/ \
                -e PGADMIN_URL=https://www.pgadmin.org/ \
                ${DOCKER_IMAGE}
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Application deployed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
