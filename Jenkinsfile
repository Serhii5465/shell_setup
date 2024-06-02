@Library('PrepEnvForBuild') _

def String [] pick_hosts;

pipeline {
    agent {
        label 'master'
    }

    options { 
        skipDefaultCheckout()
        timestamps()
    }

    parameters {
        activeChoice choiceType: 'PT_SINGLE_SELECT', 
                description: 'Select a group of hosts',
                filterLength: 1, 
                filterable: false, 
                name: 'GROUPS_SSH_HOSTS', 
                randomName: 'choice-parameter-20358126523315', 
                script: groovyScript(fallbackScript: [classpath: [], oldScript: '', sandbox: false, script: ''], 
                script: [classpath: [], oldScript: '', sandbox: true, 
                script: 'return ["k8s", "general"]'])

        
        reactiveChoice choiceType: 'PT_CHECKBOX', 
                    description: 'Select SSH hosts for deployment', 
                    filterLength: 1, 
                    filterable: false, 
                    name: 'SSH_HOSTS', 
                    randomName: 'choice-parameter-20358135599748', 
                    referencedParameters: 'GROUPS_SSH_HOSTS', 
                    script: groovyScript(fallbackScript: [classpath: [], oldScript: '', sandbox: false, script: ''], 
                    script: [classpath: [], oldScript: '', sandbox: true, 
                    script: '''if (GROUPS_SSH_HOSTS.equals("k8s")) {
                                    return ["k8s-master_vb", "k8s-node1_vb", "k8s-node2_vb"]
                                } else if (GROUPS_SSH_HOSTS.equals("general")) {
                                    return ["xubuntu_vb", "ubuntu-ser_vb"]
                            }'''
                    ])
        

        credentials credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey', 
            defaultValue: '', 
            name: 'GIT_REPO_CRED', 
            required: true
    }
    
    stages {
        stage('Check status SSH servers'){
            steps{
                script{
                    if(params.SSH_HOSTS.isEmpty()){
                        error("Select at least one host")
                    } else {
                        pick_hosts = params.SSH_HOSTS.split(',')
                        for (item in pick_hosts){
                            CheckStatusSSH(item)
                        }
                    }
                }
            }
        }
        
        stage('Check git cred'){
            steps {
                CheckGitCred(params.GIT_REPO_CRED)
            }
        }
        
        stage('Git checkout'){
            steps {
                git branch: 'ubuntu', 
                credentialsId: 'cred_repo-shell_setup', 
                poll: false, 
                url: 'git@github.com:Serhii5465/shell_setup.git'
            }
        }
        
        stage('Deploy'){
            steps {
                script{
                   for (item in pick_hosts){
                        sshPublisher failOnError: true, publishers: [sshPublisherDesc(configName: item, sshRetry: [retries: 1, retryDelay: 1000], 
                        transfers: [sshTransfer(cleanRemote: false, excludes: '', 
                        execCommand: 'cd .jenkins_workspace; rsync --recursive --perms  --times --group --owner --specials --human-readable --stats --progress --verbose --out-format="%t %f %b" . ~ ; rm -rf ~/.jenkins_workspace', 
                        execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.jenkins_workspace', remoteDirectorySDF: false, removePrefix: 'src', sourceFiles: 'src/*.*, src/scripts/zero_space')], 
                        usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)]
                    } 
                }
            }
        }
    }
}