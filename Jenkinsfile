@Library(['PrepEnvForBuild', 'DeployWinAgents']) _

node('master') {
    def config = [
        git_repo_url : "git@github.com:Serhii5465/shell_setup.git",
        git_branch : "git_windows",
        git_cred_id : "github_cred",
        stash_includes : ".*",
        stash_excludes : ".gitattributes",
        command_deploy : "robocopy . C:\\Users\\raisnet\\",
        func_deploy : ""
    ]

    DeployArtifactsPipelineWinAgents(config)
}