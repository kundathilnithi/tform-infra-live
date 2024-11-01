pipeline {
    agent { label 'kubeagent'}
      {
        choice(
            name: 'action',
            choices: ['deploy', 'dryrun'],
            description: 'Select the Action'
        )
         string(defaultValue: "2", description: 'Instance Count', name: 'server_count') ;
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
            when {
                expression { params.action == 'dryrun' }
            }

            steps {
                   
                    script {
                    sh "echo Running Terragrunt Plan"
                    sh "terragrunt plan "

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


}
}
        
      

    
