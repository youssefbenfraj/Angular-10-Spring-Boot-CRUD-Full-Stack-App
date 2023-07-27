pipeline{
  agent any
  stages{
    stage('Terraform init') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -var="managed_identity_id=f6e1f0e2-80cf-45ee-8610-3702bba3d9ec"'
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
