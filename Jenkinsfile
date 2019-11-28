pipeline{
    agent none
    stages{
       stage('docker-package'){
            agent any
            steps{
              echo 'Packaging worker app with docker'
              script{
                docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                    def workerImage = docker.build("stone1972/eglog:v${env.BUILD_ID}", ".")
                    workerImage.push()
                    workerImage.push("latest")
                    }
               }
             }
        }
    }
    post{
        always{
            echo 'the job is complete'
        }
    }
}
