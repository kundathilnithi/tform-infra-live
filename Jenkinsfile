// @Library('mylibrary') _

// import com.awsec2.TerragruntPipeline 


pipeline {
    agent { label 'kubeagent'}

     environment {
        TERRAGRUNT_WORKING_DIR = '/home/jenkins/agent/workspace/myec2-pipeline/tform-infra-live/terragrunt.hcl'  // Change this to your directory path
    }

   stages {
        stage('Checkout') {
            steps {
                sh "git clone https://github.com/kundathilnithi/tform-infra-live.git"
            }
        }

   

        stage('Terragrunt Init') {
            steps {
                dir(TERRAGRUNT_WORKING_DIR) {
                    sh 'terragrunt init'
                }
            }
        }

    //     stage('Terragrunt Plan') {
    //         steps {
    //             dir(TERRAGRUNT_WORKING_DIR) {
    //                 sh 'terragrunt plan -out=planfile.tfplan'
    //             }
    //         }
    //     }

    //     stage('Approval') {
    //         steps {
    //             input message: "Do you want to apply the changes?", ok: "Yes, Apply"
    //         }
    //     }

    //     stage('Terragrunt Apply') {
    //         steps {
    //             dir(TERRAGRUNT_WORKING_DIR) {
    //                 sh 'terragrunt apply planfile.tfplan'
    //             }
    //         }
    //     }
    // }

    // post {
    //     always {
    //         cleanWs()  // Cleans the workspace after completion
    //     }
    // }
}
}


