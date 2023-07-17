pipeline{
  agent any
  stages{
    stage('build spring'){
      steps{
        sh 'docker build -t emppspring ./springboot-backend/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'docker build -t emppangular ./angular-frontend/'
        }
      }
    stage('push to hub'){
      steps{
          withDockerRegistry(credentialsId: 'DHToken', url: 'https://index.docker.io/v1/') {
            sh 'docker tag emppspring wetmonkey/emppback-aks:14'
            sh 'docker tag emppangular wetmonkey/emppfront-aks:14'
            sh 'docker push wetmonkey/emppback-aks:14'
            sh 'docker push wetmonkey/emppfront-aks:14'
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
