pipeline{
    agent none
    stages{
       stage('elog-build'){
           agent any
           steps{
               echo 'Packaging worker app with docker.'
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
                   args '--name elogd-copy --mount type=bind,source="/home/eddgest/PycharmProjects/eglog/elogcontainer",target=/elogd-static'
               }
            }
            steps{
                echo 'Copying binary and resources to a local directory.'
                sh 'cp /elogd /elogd-static/elogd-static'
                sh 'cp /elog-resources.tar /elogd-static/elog-resources.tar'
            }
       }
       stage('elog-image-creation'){
            agent any
            steps{
                echo 'Packaging worker app with docker.'
               script{
                   docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
                       def workerImage = docker.build("stone1972/eglogd:v${env.BUILD_ID}", "./elogcontainer")
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
