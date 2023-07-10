pipeline{
  agent any
  stages{
    stage('delete old containers'){
      steps{
        sh 'docker stop EmppMysql || true'
        sh 'docker rm EmppMysql || true'
        sh 'docker stop EmppSpring || true'
        sh 'docker rm EmppSpring || true'
        sh 'docker stop EmppAngular || true'
        sh 'docker rm EmppAngular || true'
        sh 'docker network rm -f EmppNetwork || true'
      }
    }
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
    stage('create network'){
      steps{
              sh 'docker network create EmppNetwork || true'
      }
    }
     stage('deploy mysql'){
       steps {
         sh'docker pull mysql:latest'
         sh'docker run -d --network EmppNetwork -p 3306:3306 --name EmppMysql -e MYSQL_ROOT_PASSWORD=root mysql:latest'
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
