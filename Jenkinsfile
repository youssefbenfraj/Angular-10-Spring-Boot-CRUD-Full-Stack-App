pipeline{
  agent any
  stages{
    stage('build spring'){
      steps{
        sh 'sudo docker build -t emppl-spring ./springboot-backend/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'sudo docker build -t emppl-angular ./angular-frontend/'
        }
      }
    stage('push to hub'){
      steps{
          withDockerRegistry(credentialsId: 'DHub', url: 'https://index.docker.io/v1/') {
            sh 'sudo docker tag emppl-spring wetmonkey/emppback-aks:19'
            sh 'sudo docker tag emppl-angular wetmonkey/emppfront-aks:19'
            sh 'sudo docker push wetmonkey/emppback-aks:19'
            sh 'sudo docker push wetmonkey/emppfront-aks:19'
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
