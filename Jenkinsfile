pipeline {
    agent any
    environment {
        createnetwork = "Create Network"
        flaskappimage = "flask_app_image"
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

        stage('Create Network') {
            steps {
                sh "echo 'creating network'"
                sh 'docker network create flasknetwork || true'
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
                sh "docker run -d --network flasknetwork --name flask-app flask-app"
            }
        }

        stage('Run NGINX Container') {
            steps {
                echo "Running NGINX container"
                sh "docker run -d -p 80:80 --network flasknetwork --name mynginx mynginx"
            }
        }

        stage('Trivy Time') {
            steps {
                echo "Running Trivy"
                sh "trivy fs -f json -o results.json . "
            }
            post{
                always {
                        archiveArtifacts artifacts: 'results.json', onlyIfSuccessful: true
                }
            }       
        }

        stage('test') {
            steps {
                echo 'Running Tests'
                script {
                    catchError(buildResult:"UNSTABLE", stageResult:"UNSTABLE") {
                        sh '''
                        # Set up the virtual environment
                        python3 -m venv .venv

                        # Activate the virtual environment
                        . .venv/bin/activate

                        # Install dependencies
                        pip install -r requirements.txt

                        # Run tests
                        python3 -m unittest test_flask.py

                        # Deactivate the virtual environment
                        deactivate
                        '''
                        } 
                    }
                }
            }
        }
    }

