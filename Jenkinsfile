
   
pipeline {
   //agent { label 'aws-jenkins-slave' }     
   agent any
   
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
                     echo "$USER"
                     echo "$HOME"
                     git credentialsId: 'github-credentials' , url: 'https://github.com/sbathuru/app-java-simpleapp.git',  branch: 'master'   
                    
                }
           }

         stage ('Maven Build') {
                        steps {
                            //sh "${mavenHome}/bin/mvn clean versions:set -Dver=${VER_NUM} package "
                            sh "${mavenHome}/bin/mvn clean package "
                       }
          }

     stage ('SonarQube Analysis') {
        steps {
              withSonarQubeEnv('sonar_server') {
                   sh '${mavenHome}/bin/mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=simpleapp'
                 //sh "${mavenHome}/bin/mvn sonar:sonar"
              }
            }
      }
          stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "jfrog_server",
                    url: "https://sbathuru.jfrog.io/artifactory",
                    credentialsId: "jfrog_cred"
                )
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "jfrog_server",
                    releaseRepo: "simpleapp-libs-release-local",
                    snapshotRepo: "simpleapp-libs-snapshot-local"
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
          
          stage('Docker Build & Push') {    
                  steps {
                          script{        // To add Scripted Pipeline sentences into a Declarative
                                    try{
                                        sh "pwd"
                                        //sh "docker rm -f simpleapp || true"
                                        //sh "docker rmi sbathuru/simpleapp || true"       //sh 'docker rmi $(docker images sbathuru/simpleapp)''
                                        }catch(error){
                                         //  do nothing if there is an exception
                                    }
                            }
                          
                          withCredentials([string(credentialsId: 'dockerHubPwd', variable: 'dockerpwd')]) {
                                 sh "docker login -u sbathuru -p ${dockerpwd}"
                         }
                          sh "docker build -t sbathuru/java-maven-application:${VER_NUM} ."
                          sh "docker tag sbathuru/java-maven-application:${VER_NUM}  sbathuru/java-maven-application:latest"
                          sh "docker push sbathuru/java-maven-application:${VER_NUM}" 
                          //sh "docker rmi sbathuru/java-maven-application" 
                 } 
          }
/*    
        stage('Deploy Into DEV (Docker)') {
           steps {   
               sh "pwd"
               sshagent(['aws-private-key-mumbai']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@docker.bathuru.shop  sudo docker rm -f java-maven-application|| true"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@docker.bathuru.shop  sudo docker run  -d -p 80:8080 --name java-maven-application sbathuru/java-maven-application:latest"
                }
            }
         }
*/
        stage('Deploy Into PROD (K8S)') {
           steps {   
               //sh "kubectl apply -f simpleapp-deploy-k8s.yaml"

               kubernetesDeploy(
                configs: 'simpleapp-deploy-k8s.yaml',
                kubeconfigId: 'k8s_cluster_kubeconfig',
                enableConfigSubstitution: true
                )
            }
         }

/*
         stage('Build Helm Charts') {
            steps {
              dir('charts') {
                       sh "helm package simpleapp"
					   sh "helm push-artifactory --username sbathuru --password Sridevi@116   simpleapp-helm-0.0.3.tgz https://sbathuru.jfrog.io/artifactory/simpleapp-helm-local"
					  }
          }
        } 

     	  stage ('Deploy Into PROD - Helm Charts')  {
	      steps {
           sh "helm version"
           dir("charts/simpleapp"){
             sshagent(['aws-ap-south-pem']) {
                    sh 'pwd'
                    sh "scp -o StrictHostKeyChecking=no Chart.yaml  ec2-user@k8s-bootstrap.bathur.xyz:/home/ec2-user/"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@k8s-bootstrap.bathur.xyz   helm repo add simpleapp-helm  https://sbathuru.jfrog.io/artifactory/simpleapp-helm-local --username sbathuru  --password Sridevi@116"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@k8s-bootstrap.bathur.xyz   helm repo update"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@k8s-bootstrap.bathur.xyz   helm upgrade simpleapp-helm  --install  --force ."
                }
                }
        }
      }
*/
    }

    post { success { echo 'Pipeline Sucessfully Finished' }
           failure { echo 'Pipeline Failure' }
           always {
                    mail bcc: '', 
                    body: """ Hi Team, 
                          Your project got Build and Deployed successfully!!!

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
                    subject: "Sucess !!! - ${env.JOB_NAME} - Build # ${env.BUILD_NUMBER}", 
                    to: 'srinivas.bathuru@gmail.com'
           } 
         }
}
