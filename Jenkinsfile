
   
pipeline {
   agent { label 'aws-jenkins-slave' }
    triggers {
          pollSCM('4 4 4 * *')
    }
    environment {
          VER_NUM = "1.0.${BUILD_NUMBER}";
          REL_NUM = "1.0.${BUILD_NUMBER}.RELEASE";
          mavenHome =  tool name: "maven", type: "maven"
          namespace = "default"
     }
    tools{
          maven 'maven'
     }
    stages {
           stage ('Git Checkout') {
                 steps {
                     echo "Heloo!!!!";
                     git credentialsId: 'github-credentials' , url: 'https://github.com/bathuru/simpleapp.git',  branch: 'master'   
                }
           }

         stage ('Maven Build') {
                        steps {
                             echo "Hello 222";
                            //sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
                            sh "${mavenHome}/bin/mvn clean package "
                       }
          }

          stage('Docker Build & Push') {    
                  steps {
                          script{        // To add Scripted Pipeline sentences into a Declarative
                                    try{
                                            sh "pwd"
                                             //sh "docker rm -f simpleapp || true"
                                             //sh "docker rmi bathurudocker/simpleapp || true"       //sh 'docker rmi $(docker images bathurudocker/simpleapp)''
                                          }catch(error){
                                          //  do nothing if there is an exception
                                          }
                            }
                          sh "docker build -t bathurudocker/devops-simpleapp:latest ."
                          withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                                 sh "docker login -u bathurudocker -p ${dockerpwd}"
                         }
                          sh "docker push bathurudocker/devops-simpleapp:latest" 
                          sh "docker rmi bathurudocker/devops-simpleapp" 
                 } 
          }
            stage('Deploy Into DEV') {
       steps {   
           sh "pwd"
           sshagent(['aws-private-key-mumbai']) {
               sh "ssh -o StrictHostKeyChecking=no ec2-user@docker.bathur.xyz  sudo docker rm -f devops-simpleapp || true"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@docker.bathur.xyz  sudo docker run  -d -p 80:8080 --name devops-simpleapp bathurudocker/devops-simpleapp:latest"
          }
       }
     }   
    }
    post { success { echo 'Pipeline Sucessfully Finished' }
           failure { echo 'Pipeline Failure' }
                     always {
               mail bcc: '', 
                body: """ Hi Team, 
                Your project Build and Deployed successfully.

Please find the details as below,
	   Job Name: ${env.JOB_NAME}
	   Job URL : ${env.JOB_URL}
      Build Number: ${env.BUILD_NUMBER} 
      Build URL: ${env.BUILD_URL}

Thanks
DevOps Team""", 
                          cc: '', 
                          from: '', 
                          replyTo: '', 
                          subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Sucess !!!", 
                          to: 'srinivas.bathuru@gmail.com'
           } 
         }
}
