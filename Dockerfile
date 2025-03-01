FROM ubuntu:focal AS base

ARG TAGS

WORKDIR /root/.dotfiles 

ARG DEBIAN_FRONTEND=noninteractive

# The command `apt-add-repository` is part of the
# `software-properties-common` package...
# So, install `software-properties-common` before
# running the `apt-add-repository` command.

RUN apt update && apt install -y software-properties-common

RUN apt-add-repository -y ppa:ansible/ansible 

# Ideally, only install Ansible here and use Ansible
# to install other programs.

RUN apt update && apt install -y ansible 

FROM base AS prod
COPY . .
RUN ansible-playbook ./local.yml
CMD ["zsh"]

FROM base AS dev

