pipeline{
  agent any
  stages{
    stage('Terraform init') {
            steps {
                sh 'terraform init --upgrade'
                sh 'terraform plan'
            }
        }
    stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
                script {
                    def terraformOutput = sh(returnStdout: true, script: 'terraform output kube_config')
                    writeFile(file: 'terraform_output.txt', text: terraformOutput)
                }
            }
        }
     stage('Get AKS Cluster Credentials') { 
       steps{
               sh ' cat terraform_output.txt'
          withKubeConfig(contents: terraform_output.txt ) {
         sh ('kubectl apply -f deployment.yaml')}
      }
    }
  }
}
