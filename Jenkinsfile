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
         script { 
         def kubeConfigContent = readFile('terraform_output.txt').trim()
         withKubeConfig(contextName: kubeConfigContent ) {
           sh ('kubectl config current-context')
           sh ('kubectl apply -f deployment.yaml' --context current-context )}
          }
       }
    }
  }
}
