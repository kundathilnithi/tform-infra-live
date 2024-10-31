@Library('mylibrary') _

import com.awsec2.TerragruntPipeline 


pipeline {
    agent { label 'kubeagent'}

    parameters {
        string(name: 'TERRAGRUNT_CONFIG', defaultValue: 'path/to/terragrunt.hcl', description: 'Path to the Terragrunt configuration file')
    }

    stages {
        stage('Checkout') {
            steps {
                 
               sh "git clone https://github.com/kundathilnithi/tform-infra-live.git"
            }
        }

        stage('Initialize') {
            steps {
                sh "pwd"
                script {
                    
                    def terragrunt = new TerragruntPipeline()
                    terragrunt.init()
                }
            }
        }

    //     stage('Plan') {
    //         steps {
    //             script {
    //                 def terragrunt = new TerragruntPipeline()
    //                 terragrunt.plan()
    //             }
    //         }
    //     }

    //     stage('Apply') {
    //         steps {
    //             script {
    //                 def terragrunt = new TerragruntPipeline()
    //                 terragrunt.apply()
    //             }
    //         }
    //     }

    //     stage('Output') {
    //         steps {
    //             script {
    //                 def terragrunt = new TerragruntPipeline()
    //                 terragrunt.output() // Display outputs after apply
    //             }
    //         }
    //     }
    // }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}