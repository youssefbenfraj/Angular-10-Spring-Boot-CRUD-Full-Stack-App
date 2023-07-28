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
              def ca_certificate = sh(
                        script: "grep -oP '(?<=certificate-authority-data: ).*' kube_config_output.txt | base64 -d",
                        returnStdout: true
                    ).trim()
              def cluster_name = sh(
                        script: "grep -oP '(?<=name: ).*' kube_config_output.txt",
                        returnStdout: true
                    ).trim()
              echo "CA_CERTIFICATE: $ca_certificate"
              echo "CLUSTER_NAME: $cluster_name" }
              withKubeConfig(caCertificate: ca_certificate, clusterName: cluster_name, contextName: '', credentialsId: '', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
         sh ('kubectl apply -f deployment.yaml')}
      }
    }
  }
}
