pipeline{
  agent any
  stages{
    stage('build spring'){
      steps{
        sh 'docker build -t spring-empp ./springboot-backend/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'docker build -t angular-empp ./angular-frontend/'
        }
      }
    stage('push to hub'){
      steps{
          withDockerRegistry(credentialsId: 'DHToken', url: 'https://index.docker.io/v1/') {
            sh 'docker tag angular-empp wetmonkey/empp-back-aks'
            sh 'docker tag angular-empp wetmonkey/empp-front-aks'
            sh 'docker push wetmonkey/empp-back-aks:latest'
            sh 'docker push wetmonkey/empp-front-aks:latest'
          }
      }
    }
   stage('Deployment AKS'){
      steps{
      
         withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8S-Kubernet', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
         sh ('kubectl apply -f deployment.yaml')}
      }
    }
  }
}
