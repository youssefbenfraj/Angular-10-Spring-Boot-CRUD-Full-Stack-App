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
            }
        }
     stage('Get AKS Cluster Credentials') {
          steps {
              sh'az login'
              sh 'az aks get-credentials --resource-group Terraform-Demo --name Terraform-cluster'
              sh 'kubectl apply -f deployment.yaml'
      }
    }
  }
}
