@Library('mylibrary') _

import com.awsec2.TerragruntPipeline 


pipeline {
    agent any

    parameters {
        string(name: 'TERRAGRUNT_CONFIG', defaultValue: 'path/to/terragrunt.hcl', description: 'Path to the Terragrunt configuration file')
    }

    stages {
        // stage('Checkout') {
        //     steps {
        //         checkout scm // Checkout the source code
        //     }
        // }

        stage('Initialize') {
            steps {
                script {
                    def terragrunt = new TerragruntPipeline(params.TERRAGRUNT_CONFIG)
                    terragrunt.init()
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    def terragrunt = new TerragruntPipeline(params.TERRAGRUNT_CONFIG)
                    terragrunt.plan()
                }
            }
        }

        stage('Apply') {
            steps {
                script {
                    def terragrunt = new TerragruntPipeline(params.TERRAGRUNT_CONFIG)
                    terragrunt.apply()
                }
            }
        }

        stage('Output') {
            steps {
                script {
                    def terragrunt = new TerragruntPipeline(params.TERRAGRUNT_CONFIG)
                    terragrunt.output() // Display outputs after apply
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}