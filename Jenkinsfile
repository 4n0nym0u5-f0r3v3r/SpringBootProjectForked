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
      steps {
        echo 'Packaging'
        sh '''mvn versions:set -DnewVersions="$(echo $GIT_COMMIT | cut -c 1-7 )"
mvn versions:commit'''
        sh 'mvn  package -DskipTests'
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