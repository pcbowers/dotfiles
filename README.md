# My Dotfiles

These dotfiles are managed using [chezmoi](https://www.chezmoi.io/).

## Getting Started

Check out the [Quick Start](https://www.chezmoi.io/quick-start/) page.

### Install

On any machine, you can install chezmoi and these dotfiles with the following command:

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- -b $HOME/.local/bin init --apply pcbowers
```

### Update

On any machine, you can pull and apply the latest changes from your repo with the following command:

```
chezmoi update -v
```

### Assumptions

A script is run right before install that adds necessary packages to the system. The following assumptions are made:

- `bash` is installed
- A flavor of `Debian` (along with the `apt` package manager) is the Linux flavor of choice

### TODO

- Add vim plugins and setup?
- Add nvim?
- Add One Password to use same SSH keys across machines?
- Add terminal settings for kitty and Windows Terminal?
- Add VSCode settings?
- Add google drive mount?
- Add Cisco Anyconnect for work?
- Add NPM/Nexus for work?
- Add docker for work?
- Add Gradle for work?
- Add tnsnames for work?
- Add Slack and Chrome application files for work?
- Change NVM defaults for work?
- Change SDKMAN! defaults for work?
