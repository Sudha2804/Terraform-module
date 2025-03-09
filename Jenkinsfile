pipeline {
    agent any

    environment {
        TERRAFORM_VERSION = "1.6.0"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    sh 'echo "Checking out the repository..."'
                    checkout scm
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'

                }
            }
        }

        stage('Approval') {
            when {
                expression { return true } // Modify condition if needed
            }
            steps {
                script {
                    sh 'echo "Waiting for approval..."'
                }
            }
        }

        stage('Apply') {
            when {
                expression { return true } // Modify condition if needed
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Run Ansible Playbook') {
            when {
                expression { return true } // Modify condition if needed
            }
            steps {
                script {
                    sh 'ansible-playbook -i inventory playbook.yml'
                }
            }
        }

        stage('Destroy') {
            when {
                expression { return false } // Modify condition if needed
            }
            steps {
                script {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            sh 'echo "Pipeline execution completed successfully!"'
        }
        failure {
            sh 'echo "Pipeline execution failed!"'
        }
    }
}
