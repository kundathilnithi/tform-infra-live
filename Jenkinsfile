pipeline {
    agent { label 'kubeagent'}

    environment {
      
        TERRAGRUNT_WORKING_DIR = 'tform-infra-live/prod/ec2' // Update with the path to your Terragrunt directory
    }

    stages {
        stage('Checkout') {
            steps {
             sh "git clone https://github.com/kundathilnithi/tform-infra-live.git "
               sh 'pwd'
            }
        }

        stage('Debug') {
            steps {
                dir(TERRAGRUNT_WORKING_DIR) {
                    sh 'pwd'
                    sh ' ls -la'
                  
                    
                    
                }
            }
        }

    stage('Terragrunt Init') {
            steps {
                dir(TERRAGRUNT_WORKING_DIR ) {
                 
                    echo "Running Terragrunt init in ${TERRAGRUNT_WORKING_DIR}"
                    sh "pwd"
                
                  
                }
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


    
