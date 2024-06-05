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
    }

    stages {
        stage('Check status agent'){
            steps{
                CheckAgent("${params.AGENT}")
            }
        }

        stage('Git checkout'){
            steps {
                checkout scmGit(branches: [[name: 'cygwin']],
                                extensions: [], 
                                userRemoteConfigs: [[url: 'shell_setup_repo:Serhii5465/shell_setup.git']])

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