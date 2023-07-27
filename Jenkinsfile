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
                sh 'terraform apply --auto-approve -var="managed_identity_id=da1c0cdf-8f41-4998-acd8-0f3559ec47ff"'
            }
        }
    stage('Deployment AKS'){
      steps{ 
         sh 'kubectl apply -f deployment.yaml'
      }
    }
  }
}
