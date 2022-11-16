pipeline {
    agent {label "docker-slave" }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.6'
                    reuseNode true
                }
            }
            steps {
                sh 'mvn clean package -Dcheckstyle.skip'
            }
        }
        stage('Adding a Build Number'){
            steps{
                sh "mv target/spring-petclinic*.jar target/spring-petclinic-build-number-${BUILD_NUMBER}.jar"
                
                archiveArtifacts artifacts: '**/target/*.jar'
            }
        }
        stage('Copy') {
            steps {
                sh "cp target/*.jar /home/jenkins/PetclinicArtifactsDir"
            }
        }
        stage('Build image and Deployment'){
            steps{
                sh "docker-compose -f docker-compose.jenkins.yml up --build -d"
            }
        }
    }
    post {
         success {
             emailext body: 'PETCLINIC BUILD SUCCESS', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Jenkins Petclinic Build Number-${BUILD_NUMBER}'
            }
                
         failure {
             emailext body: 'PETCLINIC BUILD FAILED!!!', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Jenkins Petclinic Build Nubmer-${BUILD_NUMBER}'
           }
    }
}
