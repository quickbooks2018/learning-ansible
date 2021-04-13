pipeline{
    agent any
    stages{
        stage('SCM Checkout'){
            steps{
                git branch: 'ansible-cicd', url: 'https://github.com/quickbooks2018/learning-ansible.git'
            }
        }
    }
}
        
