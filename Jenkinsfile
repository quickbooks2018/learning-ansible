pipeline{
    agent any
    environment {
    SERVER_CREDS = credentials('dev-server')
}
    stages{
        stage('SCM Checkout'){
            steps{
                git branch: 'ansible-cicd', url: 'https://github.com/quickbooks2018/learning-ansible.git'
            }
        }
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Docker Build'){
            steps{
                sh '''
                    echo 'Creating a docker image with GitHub Tags Option ....'
                   
                    # This will give the latest commit ID
                    
                    COMMIT_ID=`git rev-list --tags --date-order | head -n1`
                    
                    # Latest TAG
                    
                    TAG=`git show-ref --tags | grep "$COMMIT_ID" | awk -F / '{print $NF}'`
                    echo $COMMIT_ID
                    echo $TAG
                    docker build -t quickbooks2018/testappformjenkins:$TAG .
                    
                    '''
            }
        }
        stage('Docker Push Image'){
            steps{
                sh '''
                    echo 'Pushing a docker image with GitHub Tags Option ....'
                   
                    # This will give the latest commit ID
                    
                    COMMIT_ID=`git rev-list --tags --date-order | head -n1`
                    
                    # Latest TAG
                    
                    TAG=`git show-ref --tags | grep "$COMMIT_ID" | awk -F / '{print $NF}'`
                    echo $COMMIT_ID
                    echo $TAG
                    docker push quickbooks2018/testappformjenkins:$TAG
                    
                    '''
            }
        }
        stage('Deploy on dev with Ansible'){
            steps{
                sh '''
                    echo 'Deploy on dev with Ansible ....'
                   
                    # This will give the latest commit ID
                    
                    COMMIT_ID=`git rev-list --tags --date-order | head -n1`
                    
                    # Latest TAG
                    
                    TAG=`git show-ref --tags | grep "$COMMIT_ID" | awk -F / '{print $NF}'`
                    echo $COMMIT_ID
                    echo $TAG
                    
                    
                    
                    ansible-playbook -i dev.inv --private-key=$SERVER_CREDS deploy-docker.yml
                    
                    '''
                    
            }
        }
    }
}
