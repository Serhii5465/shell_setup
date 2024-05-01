FROM ubuntu:22.04

ENV USER=vscode
ARG PATH_SSH_KEYS=/home/${USER}/.ssh
ARG REL_PATH_DEP_KEYS=/deploy_keys_github/unix_shell_setup

RUN apt update && apt install -y --no-install-recommends udev curl \
    git bash-completion sudo rsync gedit openssh-server \
    && rm -rf /var/lib/apt/lists/* && apt-get clean \
    
    # Install kubectl
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl \

    # Setting non-root user
    && adduser --disabled-password --gecos '' --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && usermod --append --groups sudo ${USER} \
    
    # Fix permissions of SSH folders
    && mkdir -p ${PATH_SSH_KEYS}${REL_PATH_DEP_KEYS} \
    && find ${PATH_SSH_KEYS} -type d -exec chown ${USER}:${USER} {} \; -exec chmod 700 {} \;

USER ${USER}