pipeline {
    agent any
    environment {
        flaskappimage= "flask_app_image"
        nginximage = "nginx_image"
        flaskappcont = "flask_app_container"
        nginxcont = "nginx_container"
    }
    stages {
        stage('Cleanup') {
            steps {
                echo "Running cleanup script"
                sh 'chmod +x cleanup.sh'
                sh './cleanup.sh'
            }
        }
        stage('Build Flask App Image') {
            steps {
                echo "Building Flask app image"
                script {
                    docker.build("${flask-app}", "-f Dockerfile .")
                }
            }
        }
        stage('Build NGINX Image') {
            steps {
                echo "Building NGINX image"
                script {
                    docker.build("${nginx}", "-f Dockerfilenginx .")
                }
            }
        }
        stage('Run Flask App Container') {
            steps {
                echo "Running Flask app container"
                sh "docker run -d --name ${flask-app} ${flask-app}"
            }
        }
        stage('Run NGINX Container') {
            steps {
                echo "Running NGINX container"
                sh "docker run -d --name ${nginx} ${nginx}"
            }
        }
    }
}
