pipeline{
  agent any
  stages{
    stage('Terraform init') {
            steps {
                sh 'terraform init -chdir=./terraform'
            }
        }
    stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve '
            }
        }
    stage('Deployment AKS'){
      steps{ 
         sh 'kubectl apply -f deployment.yaml'
      }
    }
  }
}
