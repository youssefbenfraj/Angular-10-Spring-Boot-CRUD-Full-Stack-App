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
               sh 'sudo KUBE_CONFIG_CONTENT=$(terraform output kube_config)'
              sh 'sudo echo "${KUBE_CONFIG_CONTENT}" > kubeconfig'
            }
        }
     stage('Get AKS Cluster Credentials') {
       environment {
        KUBECONFIG = "${env.WORKSPACE}/kubeconfig"
            }  
       steps{
              sh 'kubectl apply -f deployment.yaml'
      }
    }
  }
}
