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

A script is run after install that adds necessary packages to the system. The following assumptions are made:

- `bash` is installed
- `zsh` is installed and is currently default
- `Debian` (along with `apt`) is the Linux flavor of choice
