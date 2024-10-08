FROM debian:12

ENV USER=debian
ARG PATH_SSH_KEYS=/home/${USER}/.ssh
ARG REL_PATH_DEP_KEYS=/deploy_keys_github/shell_setup

ARG SCRIPT_INST_KUBECTL=/tmp/inst_kubectl
ARG SCRIPT_INST_HELM=/tmp/inst_helm
ARG SCRIPT_INST_DOCKER_CE_CLI=/tmp/inst_docker_ce_cli
ARG SCRIPT_INST_KIND=/tmp/inst_kind

RUN apt update && apt install -y --no-install-recommends udev curl ca-certificates \
    git bash-completion sudo rsync gedit openssh-server timeshift cron \
    && rm -rf /var/lib/apt/lists/* && apt-get clean \
    # Setting non-root user
    && useradd --shell /bin/bash --create-home --user-group ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && usermod --append --groups sudo ${USER} \
    # Fix permissions of SSH folders
    && mkdir -p ${PATH_SSH_KEYS}${REL_PATH_DEP_KEYS} \
    && find ${PATH_SSH_KEYS} -type d -exec chown ${USER}:${USER} {} \; -exec chmod 700 {} \;

COPY scripts/inst_kubectl ${SCRIPT_INST_KUBECTL}
COPY scripts/inst_helm ${SCRIPT_INST_HELM}
COPY scripts/inst_docker_ce_cli ${SCRIPT_INST_DOCKER_CE_CLI}
COPY scripts/inst_kind ${SCRIPT_INST_KIND}

RUN chmod +x ${SCRIPT_INST_KUBECTL} && .${SCRIPT_INST_KUBECTL} && rm ${SCRIPT_INST_KUBECTL} \
    && chmod +x ${SCRIPT_INST_HELM} && .${SCRIPT_INST_HELM} && rm ${SCRIPT_INST_HELM} \
    && chmod +x ${SCRIPT_INST_DOCKER_CE_CLI} && .${SCRIPT_INST_DOCKER_CE_CLI} && rm ${SCRIPT_INST_DOCKER_CE_CLI} \
    && chmod +x ${SCRIPT_INST_KIND} && .${SCRIPT_INST_KIND} && rm ${SCRIPT_INST_KIND}

USER ${USER}