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
               sh 'KUBE_CONFIG_CONTENT=$(terraform output kube_config)'
              sh 'cat <<EOF > kubeconfig\n${KUBE_CONFIG_CONTENT}\nEOF'
            }
        }
     stage('Get AKS Cluster Credentials') { 
       steps{
                script {
                    env.KUBECONFIG = "${env.WORKSPACE}/kubeconfig"
                }
               sh ' cat kubeconfig'
              sh 'kubectl apply -f deployment.yaml'
      }
    }
  }
}
