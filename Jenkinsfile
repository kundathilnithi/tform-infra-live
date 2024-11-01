pipeline {
    agent { label 'kubeagent'}

     parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
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
                   
                    script {
                    echo "Running Terragrunt init in ${TERRAGRUNT_WORKING_DIR}"
                    sh "terragrunt init --terragrunt-config ${env.WORKSPACE}/${TERRAGRUNT_WORKING_DIR}/terragrunt.hcl"

                    }
                
            }
       
         }

           stage('Terragrunt Plan') {        
            steps {
                   
                    script {
                    sh "echo Running Terragrunt Plan"
                    sh "terragrunt plan"

                    }
            }
    }

stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }



}
}
        
      

    
