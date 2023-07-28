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
        script {
              // Read the contents of the file using the readFile step
                    def kubeConfigContent = readFile(file: 'kube_config_output.txt')

                    // Extract the values from the kubeConfigContent variable using regex
                    def ca_certificate = (kubeConfigContent =~ /(?<=certificate-authority-data: ).*/)[0]
                    def cluster_name = (kubeConfigContent =~ /(?<=name: ).*/)[0]

              echo "CA_CERTIFICATE: $ca_certificate"
              echo "CLUSTER_NAME: $cluster_name" 
                } 
          withKubeConfig(caCertificate: ca_certificate, clusterName: cluster_name, contextName: '', credentialsId: '', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
         sh ('kubectl apply -f deployment.yaml')}
      }
    }
  }
}
