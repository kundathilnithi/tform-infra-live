pipeline {
    agent { label 'kubeagent'}

    environment {
      
        TERRAGRUNT_WORKING_DIR = 'tform-infra-live/prod/ec2' // Update with the path to your Terragrunt directory
    }

    stages {
        stage('Checkout') {
            steps {
             sh "git clone https://github.com/kundathilnithi/tform-infra-live.git "
            }
        }


        stage('Terragrunt Init') {
            
            steps {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'jenkins-aws-creds', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    script {
                    echo "Running Terragrunt init in ${TERRAGRUNT_WORKING_DIR}"
                    sh "terragrunt init --terragrunt-config ${env.WORKSPACE}/${TERRAGRUNT_WORKING_DIR}/terragrunt.hcl"
                    sh 'terragrunt plan -out=planfile.tfplan'
                    }
                
            }
        }
        }
 





    }
    }

        
      

    
