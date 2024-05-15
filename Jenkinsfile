def CheckAgent(String label){
    online_nodes = nodesByLabel label: "${label}", offline: false
    if (online_nodes) {
        echo "${label} online"
    } else {
       currentBuild.result = 'ABORTED'
       error("${label} offline. Aborting building")
    }
}

def CheckGitCred(String data){
    if ("${data}".isEmpty()) {
        currentBuild.result = 'ABORTED'
        error("Enter GitHub credentials...")
    }
}

pipeline{
    agent {
        label 'master'
    }
    
    options { 
        skipDefaultCheckout() 
    }

    parameters {
        choice choices: ['Win10_MSI', 'Win10-Dell'], description: 'Choose an agent for deployment', name: 'AGENT'
        credentials credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey', defaultValue: '', name: 'GIT_REPO_CRED', required: true
    }

    stages {
        stage('Check status agent/git cred'){
            steps{
                CheckAgent("${params.AGENT}")
                CheckGitCred("$params.GIT_REPO_CRED")
            }
        }

        stage('Git checkout'){
            steps {
                git branch: 'cygwin', 
                credentialsId: "${params.GIT_REPO_CRED}", 
                poll: false, 
                url: 'git@github.com:Serhii5465/shell_setup.git'

                stash includes: '.*, scripts/backup_env/**/*, scripts/vbox_sync/*', name: 'configs'
            }
        }

        stage ('Deploy'){
            agent {
                label "${params.AGENT}"
            }
            steps {
                unstash 'configs'
                
                bat returnStatus: true, script: 'dir'
                bat returnStatus: true, script: 'robocopy /E /copyall . D:\\system\\applications\\cygwin64\\home\\raisnet'
            }
        }
    }
}