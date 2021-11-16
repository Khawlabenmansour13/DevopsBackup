pipeline {
    agent any
    
    environment{
        registry = "khawlabenmansour13/timesheetimage"
        registryCredential= 'dockerHub'
        dockerImage=''

    }

 
    stages {
        stage('Checkout Github') {
            steps {
                echo 'download project'
                git branch:'main', url:'https://github.com/Khawlabenmansour13/DevopsBackup.git'
            }
        }
        stage('Build Project') {
            steps {
                echo "Build our project"
                bat 'mvn package '
            }
        }
        
        stage('Test JUnit') {
            steps {
                echo "Test project"
                bat 'mvn test'
            }
        }
        
        stage('SonarQube') {
            steps {
                echo 'Analzying quality code.'
                bat 'mvn sonar:sonar'
                echo 'Visit http://localhost:9000 to see test result '
            }
        }
        
        stage('Nexus') {
            steps {
                echo 'Our project is deploying on maven-releases'
                bat 'mvn clean package  deploy:deploy-file -DgroupId=tn.esprit.spring -DartifactId=Timesheet-spring-boot-core-data-jpa-mvc-REST-1 -Dversion=6.0 -DgeneratePom=true -Dpackaging=jar -DrepositoryId=deploymentRepo -Durl=http://localhost:8082/repository/maven-releases/  -Dfile=target/Timesheet-spring-boot-core-data-jpa-mvc-REST-1-6.0.war'
                echo 'Visit http://localhost:8082/repository/maven-releases/ to see test result '
            }
        }
        
          stage('Building our image') {
                steps {
                    script {
                        dockerImage= docker.build registry + ":$BUILD_NUMBER" 
                    }
                }
                
          }
          
           stage('Deploy  image') {
                steps {
                    script {
                    docker.withRegistry( '', registryCredential) {//bch yemchi l registery ta3 khawla w y7ot fih artefact 
                     dockerImage.push() // push image to docker hub
                }
                    }
                }
           }
        stage('Cleaning up :') {
            steps { 
                bat "docker rmi $registry:$BUILD_NUMBER" 
            }
        }
    }
           
     
        post { 
            always {

                mail bcc: '',         
                body: "${env.BUILD_URL} has result ${currentBuild.result}", 
                subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
                to: 'khawla.benmansour6@gmail.com'
            }
        }
    
}
 
    
