
@Library('mylibrary') _
pipeline {
    agent { label 'kubeagent'}
      parameters {
        choice(
            name: 'action',
            choices: ['deploy', 'dryrun'],
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
                    key: 'terraform/terraform.tfstate',
                    region: 'us-east-1'
                )
                echo "${backend}"
                writeFile file: 'backend.tf', text: backend , encoding="UTF-8"

                sh "terraform init -backend-config=backend.tf"
            }
        }
          }


        // stage('Terragrunt Init') {
            
        //     steps {
                   
        //             script {
        //             echo "Running Terragrunt init in ${TERRAGRUNT_WORKING_DIR}"
        //             sh "terragrunt init --terragrunt-config ${env.WORKSPACE}/${TERRAGRUNT_WORKING_DIR}/terragrunt.hcl"

        //             }
                
        //     }
       
        //  }
    // stage('Terraform Bacend Init') {
    //         steps {
    //             // Call the shared library function with configuration parameters
    //             terraformS3Backend(
    //                 bucket: 'my-sai-terraform-states',
    //                 key: "${APP_NAME}/${ENVIRONMENT}/terraform.tfstate",
    //                 region: 'us-east-1',
                    
    //             )
    //         }
    //     }
    //        stage('Terragrunt Plan') {   
    //         when {
    //             expression { params.action == 'dryrun' }
    //         }

    //         steps {
                   
    //                 script {
    //                 sh "echo Running Terragrunt Plan"
    //                 sh "terragrunt plan  "

    //                 }
    //         }
    // }

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


}
}
        
      

    
