pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker {
<<<<<<< HEAD
          image 'maven:3.9.11-eclipse-temurin-21-alpine'
          args '-v m2:/home/jenkins/.m2'
=======
          image 'maven:3.9.6-eclipse-temurin-17-alpine'
>>>>>>> parent of b01c495 (Updating maven image to match architecture of building node)
        }

      }
      steps {
        echo 'Building'
        sh 'mvn compile -X'
      }
    }

    stage('Test') {
      agent {
        docker {
<<<<<<< HEAD
          image 'maven:3.9.11-eclipse-temurin-21-alpine'
          args '-v m2:/home/jenkins/.m2'
=======
          image 'maven:3.9.6-eclipse-temurin-17-alpine'
>>>>>>> parent of b01c495 (Updating maven image to match architecture of building node)
        }

      }
      steps {
        echo 'Testing'
        sh 'mvn clean test'
      }
    }

    stage('Package') {
      agent {
        docker {
<<<<<<< HEAD
          image 'maven:3.9.11-eclipse-temurin-21-alpine'
          args '-v m2:/home/jenkins/.m2'
=======
          image 'maven:3.9.6-eclipse-temurin-17-alpine'
>>>>>>> parent of b01c495 (Updating maven image to match architecture of building node)
        }

      }
      steps {
        echo 'Packaging'
        sh '''GIT_SHORT_COMMIT=$(echo $GIT_COMMIT | cut -c 1-7)
mvn versions:set -DnewVersion="$GIT_SHORT_COMMIT"
mvn versions:commit
mvn package -DskipTests'''
        archiveArtifacts '**/target/*.jar'
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