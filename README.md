# .dotfiles

My dotfiles

# A note to myself

This is a public repo, make sure to not commit and push
sensitive information to it. Make sure to clean up the
commit history if you accidentally pushed sensitive
information to the remote.

## nix-darwin

1. Install nix for macOS. Do a multi user installation.

2. Clone the dotfiles repo,

```bash
nix-shell -p git --run "git clone --recurse-submodules https://github.com/shibisuriya/.dotfiles ~/.dotfiles"
```

3. Install nix-darwin

```bash
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix-darwin#care_taker_1
```

4. The `darwin-rebuild` command

Ones nix-darwin is installed, we will have access to the
`darwin-rebuild` command,

```bash
darwin-rebuild switch --flake ~/.dotfiles/nix-darwin#care_taker_1
```

5. Install TPM,

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Note: This step needs to be automated.

7. Install 'Apple Command Line Tools (CLT)'

```bash
xcode-select install
```

CLT is a subset of Xcode, the command above doesn't install full Xcode.

Note: This step can't be automated using nix & must be performed manually.

6. Symlink your dotfiles to appropriate locations on your
   machine using GNU Stow,

```bash
./stow.zsh # Uses GNU Stow under the hood.
```

I understand that 'nix home manager' can handle this more
gracefully, but for now I am satisfied with Stow.

7. Update you git configuration (this step needs to be
   automated, I am performing this step manually for now
   because I don't want my email, etc. to leak).

## Docker image

You can build a Ubuntu based docker image which has most of
the programs you need preinstalled and configured using your
dotfiles.

To build the docker image,

```bash
docker build --target prod -t dotfiles .
```

You can then create a container using this image and copy or
volume mount directories/files from your host. This is
extremely useful for tinkering/testing/learning new things
without worrying about random programs modifying your host’s
settings.

```bash
docker run -it --rm -v .:/root/directory_1 dotfiles
```

Currently I am using ansible playbook to install and
configure the programs that I need in the Docker
container... I am planning to replace ansible with nix... In
any cases, you might want to debug/change the build
process...

To create a Ubuntu based docker image that has Ansible and
Nix preinstalled,

```bash
docker build --target dev -t dotfiles:dev .
```

Spin up a container based on this image and volume
mount/copy your dotfiles into it.

```bash
docker run -it --rm -v .:/root/.dotfiles dotfiles:dev
```

Run the ansible playbook,

```bash
ansible-playbook /root/.dotfiles/local.yml
```

## Formatting .nix files

Code formatters to format .nix files such as 'alejandra', 'nixfmt', etc. for Neovim
are not supported in Apple Silicon.

.nix files can be formatted using the 'nix fmt' command,

```bash
cd ~/.dotfiles/nix-darwin
nix fmt
```
