pipeline{
    agent none
    stages{
       stage('elog-build'){
           agent {
             dockerfile {
               filename 'Dockerfile'
               dir 'buildcontainer'
               args '-t stone1972/eglogd-build:v1'
              }
            }
            steps{
                echo 'Building from latest tar-ball.'
                sleep 3
            }
       }
       stage('elog-copy-stuff'){
            agent any
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
