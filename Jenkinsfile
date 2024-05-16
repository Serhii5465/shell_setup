@Library('PrepEnvForBuild') _

def CheckStatusSSH(String id){
    sshPublisher(publishers: [sshPublisherDesc(configName: "${id}", sshRetry: [retries: 4, retryDelay: 750], 
    transfers: [sshTransfer(cleanRemote: false, excludes: '', 
    execCommand: 'whoami; uname -r;', 
    execTimeout: 120000, 
    flatten: false, 
    makeEmptyDirs: false, 
    noDefaultExcludes: false, 
    patternSeparator: '[, ]+', 
    remoteDirectory: '', 
    remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], 
    usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])

    if(currentBuild.result == 'UNSTABLE'){
        error("${id} offline...")
    }
}

pipeline {
    agent {
        label 'master'
    }

    options { 
        skipDefaultCheckout() 
    }

    parameters {
        choice choices: ['ubuntu-ser_vb', 'k8s-node1_vb', 'k8s-master_vb', 'xubuntu_vb'], 
                description: 'Select the domain of the SSH server for deployment', 
                name: 'SSH_DOMAIN'

        credentials credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey', 
                    defaultValue: '', 
                    name: 'GIT_REPO_CRED', 
                    required: true
    }

    stages {
        stage('Check status SSH server'){
            steps {
                CheckStatusSSH("${params.SSH_DOMAIN}")
            }
        }

        stage('Check git cred'){
            steps {
                CheckGitCred("${params.GIT_REPO_CRED}")
            }
        }

        stage('Git checkout'){
            steps {
                git branch: 'ubuntu', 
                credentialsId: 'cred_repo-shell_setup', 
                poll: false, 
                url: 'git@github.com:Serhii5465/shell_setup.git'

                stash includes: 'src/*.*', name: 'user_config'
                stash includes: 'src/scripts/*', name: 'user_scripts'
            }
        }

    }
}