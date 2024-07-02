@Library('PrepEnvForBuild') _

def agents_online = [];

def UnstashOnAgent(String label, String cmd){
    return {
        node(label){
            stage('Unstash on ' + label){
                script{
                    unstash 'src'

                    sh returnStatus: true, script: cmd
                }
            }
        }
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
        activeChoice choiceType: 'PT_CHECKBOX', 
        description: 'Select agents to run the build', filterLength: 1, filterable: false, 
        name: 'NODES', script: groovyScript(fallbackScript: [classpath: [], oldScript: '', sandbox: false, script: ''], 
        script: [classpath: [], oldScript: '', sandbox: false, 
        script: '''
            def GetNodesByLabel(String label){
                def nodes = []

                jenkins.model.Jenkins.get().computers.each { c ->
                if (c.node.labelString.contains("${label}")) {
                    nodes.add(c.node.selfLabel.name)
                }}

                return nodes
            }

            return GetNodesByLabel("linux_agents_vb")'''
            ])
    }

    stages {
        stage('Ping agent'){
            steps{
                script {
                    if(params.NODES.isEmpty()){
                        error("Select at least one host")
                    } else {
                        agents_online = params.NODES.split(',')
                        for (item in agents_online) {
                            CheckAgent(item)
                        }
                    }   
                }
            }
        }

        stage('Checkout git'){
            steps {
                git branch: 'ubuntu', 
                poll: false, 
                url: 'shell_setup_repo:Serhii5465/shell_setup.git'

                stash includes: 'src/*.*, src/**/scripts/*', excludes: 'src/scripts/backup_home_dir', name: 'src'
            }
        }

        stage('Deploy'){
            steps {
                script {
                    def cmd = "rsync --recursive --perms  --times --group --owner \
                                --specials --human-readable --stats --progress \
                                --verbose --out-format=\'%t %f %b\' src/ ~"

                    def tasks = [:]

                    for (item in agents_online){
                        def label = item
                        tasks[label] = UnstashOnAgent(label, cmd)
                    }

                    parallel tasks
                }
            }
        }
    }
}