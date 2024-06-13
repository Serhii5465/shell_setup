@Library(['PrepEnvForBuild', 'DeployWinAgents']) _

node('master') {
    def raw = libraryResource 'configs/shell_setup_repo.json'
    def config = readJSON text: raw
    DeployArtifactsPipelineWinAgents(config)
}