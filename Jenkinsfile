pipeline {
    agent { label 'kubeagent'}

    environment {
        TERRAGRUNT_WORKING_DIR = 'tform-infra-live/' // Update with the path to your Terragrunt directory
    }

    stages {
        stage('Checkout') {
            steps {
               sh "git clone https://github.com/kundathilnithi/tform-infra-live.git "
               sh 'pwd'
            }
        }

        stage('Terragrunt Init') {
            steps {
                dir(TERRAGRUNT_WORKING_DIR) {
                    sh 'pwd'
                    sh 'cd tform-infra-live/prod/ec2'
                    sh 'ls -la /home/jenkins/agent/workspace/myec2-pipeline/tform-infra-live/prod/ec2'
                    sh 'terragrunt init'
                    
                }
            }
        }

        stage('Terragrunt Plan') {
            steps {
              //  dir(TERRAGRUNT_WORKING_DIR) {
                    sh 'terragrunt plan -out=planfile.tfplan'
                }
            }
        }

        // stage('Approval') {
        //     steps {
        //         input message: "Approve to apply the Terragrunt plan?", ok: "Apply"
        //     }
        // }

        // stage('Terragrunt Apply') {
        //     steps {
        //         dir(TERRAGRUNT_WORKING_DIR) {
        //             sh 'terragrunt apply planfile.tfplan'
        //         }
        //     }
        // }
    }

    post {
        always {
            cleanWs()  // Cleans the workspace after completion
        }
    }
