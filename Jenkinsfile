pipeline{
  agent any
  stages{
    stage('delete old containers'){
      steps{
        sh 'docker stop EmppSpring || true'
        sh 'docker rm EmppSpring || true'
        sh 'docker stop EmppAngular || true'
        sh 'docker rm EmppAngular || true'
        sh 'docker network rm -f EmppNetwork || true'
      }
    }
    stage('build spring'){
      steps{
        sh 'docker build -t spring-empp ./springboot2-jpa-crud-example/'
      }
    } 
    stage('build angular'){
        steps{
          sh 'docker build -t angular-empp ./angular8-springboot-client/'
        }
      }
    stage('create network'){
      steps{
              sh 'docker network create EmppNetwork || true'
      }
    }
     stage('deploy spring'){
      steps {
        sh 'docker run -d --network EmppNetwork -p 8080:8080 --name EmppSpring spring-empp'
      }
    }
    stage('deploy angular'){
      steps{
        sh ' docker run -d --network EmppNetwork -p 4200:80 --name EmppAngular angular-empp'
      }
    }
  }
}
