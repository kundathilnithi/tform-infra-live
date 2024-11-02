
@Library('mylibrary') _
pipeline {
    agent { label 'kubeagent'}
      parameters {
        choice(
            name: 'action',
            choices: ['deploy', 'dryrun','destroy'],
            description: 'Select the Action'
        )

         
         string(defaultValue: "2", description: 'Instance Count', name: 'server_count') ;
         }


    environment {

        TF_VAR_server_count = params.server_count.toInteger()
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
   
          stage('Generate Backend Configuration') {
            steps {

                 script {  
                    backend = generateConfig(
                    bucket : 'my-sai-terraform-states',
                    key: 'ec2/prod/terraform.tfstate',
                    region: 'us-east-1'
                )
                writeFile file: 'backend.hcl', text: backend 
                sh "terragrunt  init --terragrunt-config ${env.WORKSPACE}/backend.hcl"                

            }
        }
          }


        stage('Terragrunt Init') {
            
            steps {
                   
                    script {
                    sh "terragrunt  init   --terragrunt-config ${env.WORKSPACE}/${TERRAGRUNT_WORKING_DIR}/terragrunt.hcl"
                    }
                
            }
       
         }
   
           stage('Terragrunt Plan') {   
            when {
                expression { params.action == 'dryrun' }
            }

            steps {
                   
                    script {
                    sh "echo Running Terragrunt Plan"
                    sh "terragrunt plan  "

                    }
            }
    }

       stage('Terragrunt Apply') {   
            when {
                expression { params.action == 'deploy' }
            }

            steps {
               
                    script {
                    sh "echo Running Terragrunt Plan"
                    sh "terragrunt apply  -auto-approve"

                    }
            }
    }


      stage('Terragrunt Destroy') {   
            when {
                expression { params.action == 'destroy' }
            }

            steps {
               
                    script {
                    sh "echo Running Terragrunt Destroy"
                    sh "terragrunt  destroy --auto-approve"

                    }
            }
    }


}
}
        
      

    
