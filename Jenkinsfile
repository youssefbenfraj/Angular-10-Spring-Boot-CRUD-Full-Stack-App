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
            sh 'docker tag angular-empp wetmonkey/spring-empp'
            sh 'docker tag angular-empp wetmonkey/angular-empp'
            sh 'docker push wetmonkey/spring-empp:latest'
            sh 'docker push wetmonkey/angular-empp:latest'
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
