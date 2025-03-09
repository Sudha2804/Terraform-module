pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = "ap-south-1"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    sh "rm -rf Terraform-module || true" // Ensure fresh clone
                    sh "git clone https://github.com/Sudha2804/Terraform-module.git"
                }
            }
        }

        stage('Plan') {
            when { not { equals expected: true, actual: params.destroy } }
            steps {
                dir('Terraform-module/assignment_terraform/ec2_instance') {
                    sh """
                        terraform init
                        terraform workspace select ${params.environment} || terraform workspace new ${params.environment}
                        terraform plan -input=false -out=tfplan
                        terraform show -no-color tfplan > tfplan.txt
                    """
                }
            }
        }

        stage('Approval') {
            when { 
                not { equals expected: true, actual: params.autoApprove }
                not { equals expected: true, actual: params.destroy }
            }
            steps {
                dir('Terraform-module/assignment_terraform/ec2_instance') {
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                }
            }
        }

        stage('Apply') {
            when { not { equals expected: true, actual: params.destroy } }
            steps {
                dir('Terraform-module/assignment_terraform/ec2_instance') {
                    sh "terraform apply -input=false tfplan"
                }
            }
        }

        stage('Ansible Playbook') {
            when { not { equals expected: true, actual: params.destroy } }
            steps {
                dir('Terraform-module/ansible') {  // Adjust path based on repo structure
                    sh """
                        ansible-playbook -i inventory.ini playbook.yml
                    """
                }
            }
        }

        stage('Destroy') {
            when { equals expected: true, actual: params.destroy }
            steps {
                dir('Terraform-module/assignment_terraform/ec2_instance') {
                    sh "terraform destroy --auto-approve"
                }
            }
        }
    }
}
