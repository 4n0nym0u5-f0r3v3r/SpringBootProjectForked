pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building'
        sh 'mvn compile'
      }
    }

    stage('Test') {
      steps {
        echo 'Testing'
        sh 'mvn clean test'
      }
    }

    stage('Package') {
      parallel {
        stage('Package') {
          steps {
            echo 'Packaging'
            sh '''GIT_SHORT_COMMIT=$(echo $GIT_COMMIT | cut -c 1-7)
mvn versions:set -DnewVersion="$GIT_SHORT_COMMIT"
mvn versions:commit
mvn package -DskipTests'''
            archiveArtifacts '**/target/*.jar'
          }
        }

        stage('DockerPublish') {
          steps {
            script {
              docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                def commitHash = env.GIT_COMMIT.take(7)
                def dockerImage = docker.build("graves869/firstevercontainer:${commitHash}", "./")
                dockerImage.push()
              }
            }

          }
        }

      }
    }

  }
  tools {
    maven 'Maven 3.9.11'
  }
  post {
    always {
      echo 'this pipeline has completed...'
    }

  }
}