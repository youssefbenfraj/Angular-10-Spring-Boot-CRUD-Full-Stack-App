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
                  def terraformCertifOutput = sh(returnStdout: true, script: 'terraform output cluster_ca_certificate')
                    writeFile(file: 'ca_certificate_output.txt', text: terraformCertifOutput)
                  def terraformHostOutput = sh(returnStdout: true, script: 'terraform output host')
                    writeFile(file: 'host_output.txt', text: terraformHostOutput)
                }
            }
        }
     stage('Get AKS Cluster Credentials') { 
       steps{
         script { 
         def kubeConfigContent = readFile('terraform_output.txt').trim()
         def CaCertifContent = readFile('ca_certificate_output.txt').trim()
         def HostContent = readFile('host_output.txt').trim()
          }
         withKubeConfig([
                    caCertificate:  readFile('ca_certificate_output.txt').trim(),
                    serverUrl: HostContent,
                    contextName: kubeConfigContent
                    ]){
                   sh ('kubectl apply -f deployment.yaml')
                      }
       }
    }
  }
}
