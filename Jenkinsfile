pipeline{
  agent any
  stages{
     stage('build spring'){
      steps{
        sh 'docker build -t emppp-spring ./springboot-backend/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'docker build -t emppp-angular ./angular-frontend/'
        }
      }
    stage('push to hub'){
      steps{
          withDockerRegistry(credentialsId: 'DHub', url: 'https://index.docker.io/v1/') {
            sh 'docker tag emppp-spring wetmonkey/emppback-aks:41'
            sh 'docker tag emppp-angular wetmonkey/emppfront-aks:41'
            sh 'docker push wetmonkey/emppback-aks:41'
            sh 'docker push wetmonkey/emppfront-aks:41'
          }
      }
    }
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
     stage('Deploy AKS Cluster ') { 
       steps{
         withKubeConfig(credentialsId: 'Terra-AKS' ){
              sh ('kubectl apply -f deployment.yaml')
            }
       }
    }
  }
}
