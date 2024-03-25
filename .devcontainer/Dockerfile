FROM ubuntu:22.04

ARG USER_NAME=user1234

RUN apt update && apt -y install --no-install-recommends bash-completion git sudo rsync python3 gedit openssh-server udev curl ca-certificates \
    && rm -rf /var/lib/apt/lists/* && apt-get clean \
    && adduser --disabled-password --gecos '' --shell /bin/bash ${USER_NAME} \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && usermod --append --groups sudo ${USER_NAME}

WORKDIR /home/${USER_NAME}

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

USER ${USER_NAME}