@Library('PrepEnvForBuild') _

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

                stash includes: '.*', name: 'configs'
                stash includes: 'scripts/backup_env/**/*', name: 'script_backup_env'
                stash includes: 'scripts/vbox_sync/*', name: 'script_vbox_sync'
            }
        }

        stage ('Deploy'){
            agent {
                label "${params.AGENT}"
            }
            steps {
                unstash 'configs'
                unstash 'script_backup_env'
                unstash 'script_vbox_sync'

                bat returnStatus: true, script: 'dir'
                bat returnStatus: true, script: 'robocopy /E /copyall . D:\\system\\applications\\cygwin64\\home\\raisnet'
            }
        }
    }
}