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
                sh "echo 'Building Flask app image'" 
                sh 'docker build -t flask-app .'
                
            }
        }
        stage('Build NGINX Image') {
            steps {
                sh "echo 'Building nginx image'" 
                sh 'docker build -t mynginx -f Dockerfilenginx .'
                
            }
        }
        stage('Run Flask App Container') {
            steps {
                echo "Running Flask app container"
                sh "docker run -d --name flask-app flask-app"
            }
        }
        stage('Run NGINX Container') {
            steps {
                echo "Running NGINX container"
                sh "docker run -d -p 80:80 --name mynginx mynginx "
            }
        }
    }
}
