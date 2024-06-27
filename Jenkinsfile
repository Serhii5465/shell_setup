@Library(['PrepEnvForBuild', 'DeployWinAgents']) _

node('master') {
    def config = [
        git_repo_url : "shell_setup_repo:Serhii5465/shell_setup.git",
        git_branch : "git_windows",
        stash_includes : ".*",
        stash_excludes : ".gitattributes",
        command_deploy : "robocopy . C:\\Users\\raisnet\\",
        func_deploy : ""
    ]

    DeployArtifactsPipelineWinAgents(config)
}