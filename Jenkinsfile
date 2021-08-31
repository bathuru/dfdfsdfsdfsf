pipeline {
    agent { label 'docker-maven-slave' } 
    triggers {
          pollSCM('4 4 4 * *')
    }
    environment {
          VER_NUM = "1.0.${BUILD_NUMBER}";
          REL_NUM = "1.0.${BUILD_NUMBER}.RELEASE";
          mavenHome =  tool name: "maven", type: "maven"
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

         stage ('Multiple Builds') {
              parallel {
                  stage ("Maven Build") {
                        steps {
                             echo "Hello 222";
                            //sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
                            sh "${mavenHome}/bin/mvn clean package "
                       }
                  }
                  stage ("Gradel Build") {
                        steps {
                            echo "Gradel Build !!!!!!!"
                       }
                  }
              }
          }
    stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "jfrog_server",
                    url: "https://bathuru.jfrog.io/artifactory",
                    credentialsId: "jfrog_cred"
                )
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "jfrog_server",
                    releaseRepo: "simpleapp-local",
                    snapshotRepo: "simpleapp-local"
                )
                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "jfrog_server",
                    releaseRepo: "default-maven-virtual",
                    snapshotRepo: "default-maven-virtual"
                )
                rtMavenRun (
                    tool: "maven", // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
                rtPublishBuildInfo (
                    serverId: "jfrog_server"
             )
         }
            }

     stage ('SonarQube Analysis') {
        steps {
              withSonarQubeEnv('sonar_server') {
                 //sh '${mavenHome}/bin/mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar'
                 sh '${mavenHome}/bin/mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=simpleapp'
                 //sh "${mavenHome}/bin/mvn sonar:sonar"
              }
            }
      }    
 
/*
          stage('Docker Build & Push') {    
                  steps {
                          script{        // To add Scripted Pipeline sentences into a Declarative
                                    try{
                                            sh "echo pwd"
                                             //sh "docker rm -f simpleapp || true"
                                             //sh "docker rmi bathurudocker/simpleapp || true"       //sh 'docker rmi $(docker images bathurudocker/simpleapp)''
                                          }catch(error){
                                          //  do nothing if there is an exception
                                          }
                            }
                          sh "docker build -t bathurudocker/simpleapp:${VER_NUM} ."
                          withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                                 sh "docker login -u bathurudocker -p ${dockerpwd}"
                         }
                          sh "docker push bathurudocker/simpleapp:${VER_NUM}" 
                 } 
          }
*/
/*
     stage('Deploy Into TEST') {
       steps {   
           sh "pwd"
           sshagent(['aws-ap-south-pem']) {
               sh "ssh -o StrictHostKeyChecking=no ec2-user@13.235.99.115 sudo docker rm -f simpleapp || true"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@13.235.99.115 sudo docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${VER_NUM}"
          }
       }
     }     
     */
     /*
        stage('Deploy Into PROD') {
             steps {  
           sh "pwd"
           sshagent(['aws-ap-south-pem']) {
               sh "scp -o StrictHostKeyChecking=no simpleapp-deploy-k8s.yaml simpleapp-playbook-k8s.yml ec2-user@3.6.86.168:/home/ec2-user/"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@3.6.86.168 ansible-playbook  -i /etc/ansible/hosts /home/ec2-user/simpleapp-playbook-k8s.yml"
          }
             }
     }*/

          /*
        stage('SonarQube Analysis') {
             steps {
                    withSonarQubeEnv('SonarQubeServer') {
                        sh "${mavenHome}/bin/mvn sonar:sonar"
                     }
             }
         }*/

          /*
          stage('Build & Push Docker Image') {    
                  steps {
                          script{        // To add Scripted Pipeline sentences into a Declarative
                                    try{
                                             sh "docker rm -f simpleapp || true"
                                             sh "docker rmi bathurudocker/simpleapp || true"       //sh 'docker rmi $(docker images bathurudocker/simpleapp)''
                                          }catch(error){
                                          //  do nothing if there is an exception
                                          }
                            }
                          sh "docker build -t bathurudocker/simpleapp:${VER_NUM} ."
                          /*withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                                 sh "docker login -u bathurudocker -p ${dockerpwd}"
                         }
                          sh "docker push bathurudocker/simpleapp:${VER_NUM}" */
                          //sh  "docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${VER_NUM}"
                 //} 
          //}
/*          
          stage('Deploy Into TEST') {
          steps {   
           sh "pwd"
           sshagent(['aws-ap-south-pem']) {
               sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.229.88 sudo docker rm -f simpleapp || true"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.229.88 sudo docker run  -d -p 8010:8080 --name simpleapp bathurudocker/simpleapp:${VER_NUM}"
          }
              }
     }     
     */
     /*
        stage('Deploy Into PROD') {
             steps {  
           sh "pwd"
           sshagent(['aws-ap-south-pem']) {
               sh "scp -o StrictHostKeyChecking=no simpleapp-deploy-k8s.yaml simpleapp-playbook-k8s.yml ec2-user@3.6.86.168:/home/ec2-user/"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@3.6.86.168 ansible-playbook  -i /etc/ansible/hosts /home/ec2-user/simpleapp-playbook-k8s.yml"
          }
             }
     }*/

    }
    post {
           success {
                echo 'Pipeline finished'
           }
           failure {
                echo 'Pipeline failure'
           }
    }
}
