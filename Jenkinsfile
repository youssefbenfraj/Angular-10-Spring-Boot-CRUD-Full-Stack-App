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
            sh 'docker tag empp-back wetmonkey/emppback:1'
            sh 'docker tag empp-angular wetmonkey/emppfront:1'
            sh 'docker push wetmonkey/emppback:1'
            sh 'docker push wetmonkey/emppfront:1'
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
