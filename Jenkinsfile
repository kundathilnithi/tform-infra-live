
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
   
          stage('Generate Configuration') {
            steps {

                 script {
                // Call the shared library function with parameters
                // Log the parameters before calling the function
            echo "Calling generateConfig with appName: 'MyApp', environment: 'dev', region: 'us-west-2'"
                backend = generateConfig(
                    bucket : 'my-sai-terraform-states',
                    key: 'test/terraform.tfstate',
                    region: 'us-east-1'
                )
                echo "${backend}"
                writeFile file: 'backend.hcl', text: backend , encoding: "UTF-8"
                    sh "pwd"
        
                sh 'ls -la'
                sh "terragrunt  init --terragrunt-config ${env.WORKSPACE}/backend.hcl"
                
                sh "pwd"

                sh 'ls -la'
            }
        }
          }


        stage('Terragrunt Init') {
            
            steps {
                   
                    script {
                    echo "Running Terragrunt init in ${TERRAGRUNT_WORKING_DIR}"
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
                    sh "terragrunt  run-all destroy "

                    }
            }
    }


}
}
        
      

    
