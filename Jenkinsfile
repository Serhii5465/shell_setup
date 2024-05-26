@Library('PrepEnvForBuild') _

pipeline {
    agent {
        label 'master'
    }

    options { 
        skipDefaultCheckout()
        timestamps()
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
            }
        }

        stage('Deploy'){
            steps {
                sshPublisher failOnError: true, publishers: [sshPublisherDesc(configName: "${params.SSH_DOMAIN}", sshRetry: [retries: 3, retryDelay: 1000], 
                transfers: [sshTransfer(cleanRemote: false, excludes: '', 
                execCommand: 'cd .jenkins_workspace; rsync --recursive --perms  --times --group --owner --specials --human-readable --stats --progress --verbose --out-format="%t %f %b" . ~ ; rm -rf ~/.jenkins_workspace', 
                execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.jenkins_workspace', remoteDirectorySDF: false, removePrefix: 'src', sourceFiles: 'src/*.*, src/scripts/zero_space')], 
                usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)]
            }
        }
    }
}