pipeline{
    agent none
    stages{
       stage('elog-build'){
            agent any
            steps{
                echo 'Building from latest tar-ball.'
                script{
                }
            }
       }
       stage('elog-copy-stuff'){
            agent any
            steps{
                echo 'Copying binary and resources to a local directory.'
                script{
                }
            }
       }
       stage('elog-image-creation'){
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
