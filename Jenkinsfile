pipeline{
    agent none
    stages{
       stage('elog-build'){
           agent any
           steps{
               echo 'Packaging worker app with docker'
               script{
                   docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
                       def workerImage = docker.build("stone1972/eglogd-build:v${env.BUILD_ID}", "./buildcontainer")
                       workerImage.push()
                       workerImage.push("latest")
                   }
               }
           }
       }
       stage('elog-copy-stuff'){
           agent {
               docker {
                   image 'stone1972/eglogd-build:latest'
                   args '--mount type=bind,source="/home/eddgest/PycharmProjects/eglog/elogcontainer",target=/elogd-static'
               }
            }
            steps{
                echo 'Copying binary and resources to a local directory.'
                sleep 3
            }
       }
       stage('elog-image-creation'){
            agent any
            steps{
                echo 'Packaging worker app with docker'
                sleep 3
             }
        }
    }
    post{
        always{
            echo 'the job is complete'
        }
    }
}
