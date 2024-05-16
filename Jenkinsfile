@Library('PrepEnvForBuild') _

pipeline {
    agent {
        label 'master'
    }

    options { 
        skipDefaultCheckout() 
    }

    parameters {
        credentials credentialType: 'com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey', 
                    defaultValue: '', 
                    name: 'GIT_REPO_CRED', 
                    required: true
    }

    stages {
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