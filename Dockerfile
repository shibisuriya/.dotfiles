FROM ubuntu:focal AS base

ARG TAGS

# The directory /root/.dotfiles will not exist at this point in time, it will
# be created when I git clone my dotfiles repo to `/root/.dotfiles`.  
WORKDIR /root/.dotfiles  

ARG DEBIAN_FRONTEND=noninteractive

# The command `apt-add-repository` is part of the
# `software-properties-common` package...
# So, install `software-properties-common` before
# running the `apt-add-repository` command.

RUN apt update && apt install -y software-properties-common curl git # Installing curl here itself to install nix package manager.

RUN curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes  

RUN apt-add-repository -y ppa:ansible/ansible 

# Ideally, only install Ansible here and use Ansible
# to install other programs.

RUN apt update && apt install -y ansible 

FROM base AS prod

# The `nix-shell` command will not be available until the shell is restarted, install 
# git before running this.
RUN git clone --recurse-submodules https://github.com/shibisuriya/.dotfiles ~/.dotfiles 

# I am cloning my dotfiles repo from github instead of copying it from the
# current directory to prevent leaking of personal information.
# I am assuming that my github dotfiles repo doesn't contain any personal information.

# COPY . .

RUN ansible-playbook ./local.yml
CMD ["zsh"]

FROM base AS dev

