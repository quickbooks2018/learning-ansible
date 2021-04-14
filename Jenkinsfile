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
                    
                    echo "
                        - hosts: dev
                          become: True
                          tasks:
                            - name: Install python pip
                              yum:
                                name: python-pip
                                state: present
                            - name: Install docker
                              yum:
                                name: docker
                                state: present
                            - name: start docker
                              service:
                                name: docker
                                state: started
                                enabled: yes
                            - name: Install docker-py python module
                              pip:
                                name: docker-py
                                state: present
                            - name: Start the container
                              docker_container:
                                name: testappforjenkins
                                image: "quickbooks2018/testappforjenkins:$TAG"
                                state: started
                                published_ports:
                                  - 0.0.0.0:80:80
                              " > deploy-docker.yml
                    
                    
                    
                    ansible-playbook -i dev.inv --private-key=$SERVER_CREDS deploy-docker.yml
                    
                    '''
                    
            }
        }
    }
}
