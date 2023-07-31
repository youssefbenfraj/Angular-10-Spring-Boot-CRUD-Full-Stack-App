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
                  def terraformClientCertifOutput = sh(returnStdout: true, script: 'terraform output client_certificate')
                    writeFile(file: 'client_certificate_output.txt', text: terraformClientCertifOutput)
                  def terraformKeyOutput = sh(returnStdout: true, script: 'terraform output client_key')
                    writeFile(file: 'client_key_output.txt', text: terraformKeyOutput)
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
         def ClientCertifContent = readFile('client_certificate_output.txt').trim()
         def ClientKeyContent = readFile('client_key_output.txt').trim()
         def HostContent = readFile('host_output.txt').trim()
        withKubeConfig([
                    caCertificate: CaCertifContent,
                    serverUrl: HostContent,
                    contextName: kubeConfigContent
                    ]){
                   sh ('kubectl apply -f deployment.yaml')
                      }
          }
       }
    }
  }
}
