@Library(['PrepEnvForBuild', 'DeployWinAgents']) _

node('master') {
    def config = [
        platform: "linux",
        git_repo_url : "git@github.com:Serhii5465/shell_setup.git",
        git_branch : "ubuntu",
        git_cred_id : "github_cred",
        stash_includes : "src/*.*, src/**/scripts/*",
        stash_excludes : "src/scripts/backup_home_dir",
        command_deploy : "rsync --recursive --perms  --times --group --owner --specials --human-readable --stats --progress \
                                --verbose --out-format=\'%t %f %b\' src/ ~",
        func_deploy : ""
    ]

    DeployArtifactsPipelineOnAgents(config)
}