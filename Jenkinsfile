pipeline {
  agent any
  environment {
      AWS_ACCOUNT_ID="337901474843"
      AWS_DEFAULT_REGION="us-east-1"
      IMAGE_REPO_NAME="equitas-it"
      IMAGE_TAG="emp-ui-app"
      // IMAGE_TAG="emp-ui-app_${env.BUILD_ID}"
      REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
  }


  stages {

   stage ('Initialize') {
        steps {
            sh '''
                echo "PATH = ${PATH}"
                echo "sonar_srvr_url = ${sonar_srvr_url}"
                echo "sonar_token = ${sonar_token}"
            '''
        }
    }



   stage('Docker Build') {
      steps {
      	script{
      	  sh "docker build -t ${REPOSITORY_URI}:$IMAGE_TAG ."
      	}
      }
    }

   stage('Logging into AWS ECR') {
        steps {
            script {
              sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
            }
        }
   }

       // Uploading Docker images into AWS ECR
   stage('Pushing to ECR') {
    steps{
        script {
               sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
       }
     }

    stage ('Deploy') {
      steps {

       echo 'image deployed test message'
      }
    }
  }
}
