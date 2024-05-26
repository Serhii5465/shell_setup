FROM ubuntu:22.04

ENV USER=vscode
ARG PATH_SSH_KEYS=/home/${USER}/.ssh
ARG REL_PATH_DEP_KEYS=/deploy_keys_github/unix_shell_setup

ARG SCRIPT_INST_KUBECTL=/tmp/inst_kubectl
ARG SCRIPT_INST_HELM=/tmp/inst_helm

RUN apt update && apt install -y --no-install-recommends udev curl ca-certificates \
    git bash-completion sudo rsync gedit openssh-server \
    && rm -rf /var/lib/apt/lists/* && apt-get clean \
    # Setting non-root user
    && adduser --disabled-password --gecos '' --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && usermod --append --groups sudo ${USER} \
    # Fix permissions of SSH folders
    && mkdir -p ${PATH_SSH_KEYS}${REL_PATH_DEP_KEYS} \
    && find ${PATH_SSH_KEYS} -type d -exec chown ${USER}:${USER} {} \; -exec chmod 700 {} \;

COPY scripts/inst_kubectl ${SCRIPT_INST_KUBECTL}
COPY scripts/inst_helm ${SCRIPT_INST_HELM}

RUN chmod +x ${SCRIPT_INST_KUBECTL} && .${SCRIPT_INST_KUBECTL} && rm ${SCRIPT_INST_KUBECTL} \
    && chmod +x ${SCRIPT_INST_HELM} && .${SCRIPT_INST_HELM} && rm ${SCRIPT_INST_HELM}

USER ${USER}