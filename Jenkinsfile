pipeline{
    agent any
    
    stages{
        
        stage("Data from Github"){
            steps{
                sh 'rm -Rf sumo'
                sh 'git clone https://github.com/SUSIGUGH/sumo.git'
                sh 'ls -ltr sumo'
            }
        }
            
        stage("Copy Terraform Folder to Terraform EC2"){
            steps{
                sh 'cd sumo && scp -r terraform ec2-user@172.31.4.239:/home/ec2-user/'
            }
        }

        stage("Execute Terraform"){
            steps{
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform init && terraform apply -auto-approve"'
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform output | grep workerprvip01 | cut -d"=" -f2 > /tmp/wrkip.txt"'
                sh 'ssh ec2-user@172.31.4.239 "cd terraform && terraform output | grep workerprvip02 | cut -d"=" -f2 >> /tmp/wrkip.txt "'
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
                sh 'echo "Joining in Worker"'
            }
        }

    }
}
