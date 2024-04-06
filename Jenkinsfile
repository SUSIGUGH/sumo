pipeline{
    agent any
    
    stages{
        
        stage("Data from Github"){
            steps{
                sh 'rm -Rf sumo'
                sh 'git clone https://github.com/SUSIGUGH/sumo.git'
                sh 'ls -ltr sumo'
                sh 'chmod 600 sumo/linkedtoworld.pem'
            }
        }
            
        stage("Copy Terraform Folder to Terraform EC2"){
            steps{
                sh 'cd sumo && scp -r terraform ec2-user@172.31.4.239:/home/ec2-user/'
                sh 'chmod 600 sumo/linkedtoworld.pem'
                sh 'cd sumo && scp -r linkedtoworld.pem ec2-user@172.31.4.239:/home/ec2-user/'
            }
        }

        stage("Execute Terraform"){
            steps{
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform init && terraform apply -auto-approve"'
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform output | grep masterpubip | cut -d"=" -f2 > /tmp/mstip.txt"'
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform output | grep workerpubip01 | cut -d"=" -f2 > /tmp/wrkip1.txt"'
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform output | grep workerpubip02 | cut -d"=" -f2 >> /tmp/wrkip2.txt "'
                // sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform destroy -auto-approve"'
            }
        }

	stage("Waiting for warm Up"){
		steps{
			sh 'sleep 120'
		}
	}	

        stage("Join Worker to Cluster"){
            steps{
              script {
                def MASTERIP = sh(returnStdout: true, script: 'ssh ec2-user@172.31.4.239 "cat /tmp/mstip.txt"')
                def WORKERIP1 = sh(returnStdout: true, script: 'ssh ec2-user@172.31.4.239 "cat /tmp/wrkip1.txt"')
                echo "MASTER IP is ${MASTERIP}"
                echo "WORKER IP 1 is ${WORKERIP1}"
                }
sh 'echo "In Worker"'

                sh 'echo"Master IP is ${MASTERIP} "'
            }
        }

    }
}
