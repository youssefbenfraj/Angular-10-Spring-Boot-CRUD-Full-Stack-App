pipeline{
  agent any
  stages{
    stage('build spring'){
      steps{
        sh 'docker build -t empp-spring ./springboot-backend/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'docker build -t empp-angular ./angular-frontend/'
        }
      }
    stage('push to hub'){
      steps{
          withDockerRegistry(credentialsId: 'DHToken', url: 'https://index.docker.io/v1/') {
            sh 'docker tag empp-spring wetmonkey/emppback-aks:8'
            sh 'docker tag empp-angular wetmonkey/emppfront-aks:8'
            sh 'docker push wetmonkey/emppback-aks:8'
            sh 'docker push wetmonkey/emppfront-aks:8'
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
