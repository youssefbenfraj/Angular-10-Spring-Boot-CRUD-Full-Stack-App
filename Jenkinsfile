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
            sh 'docker tag emppp-spring wetmonkey/emppback-aks:21'
            sh 'docker tag emppp-angular wetmonkey/emppfront-aks:21'
            sh 'docker push wetmonkey/emppback-aks:21'
            sh 'docker push wetmonkey/emppfront-aks:21'
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
