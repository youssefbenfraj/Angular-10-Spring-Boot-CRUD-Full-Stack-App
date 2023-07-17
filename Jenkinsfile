pipeline{
  agent any
  stages{
    stage('build spring'){
      steps{
        sh 'sudo docker build -t emppspring ./springboot-backend/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'sudo docker build -t emppangular ./angular-frontend/'
        }
      }
    stage('push to hub'){
      steps{
          withDockerRegistry(credentialsId: 'DHToken', url: 'https://index.docker.io/v1/') {
            sh 'sudo docker tag emppspring wetmonkey/emppback-aks:14'
            sh 'sudo docker tag emppangular wetmonkey/emppfront-aks:14'
            sh 'sudo docker push wetmonkey/emppback-aks:14'
            sh 'sudo docker push wetmonkey/emppfront-aks:14'
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
