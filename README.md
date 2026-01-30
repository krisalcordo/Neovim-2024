# Dotfiles Setup

This repo contains my configs for:
- Neovim: `nvim/`
- Alacritty: `alacritty/`
- Zellij: `zellij/`
- Bazecor (Dygma): `bazecor/`

## Install

Clone the repo:
```
git clone git@github.com:krisalcordo/Neovim-2024.git ~/dotfiles
```

Create symlinks:
```
mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/alacritty ~/.config/alacritty
ln -s ~/dotfiles/zellij ~/.config/zellij
ln -s ~/dotfiles/bazecor ~/.config/bazecor
```

## Notes
- If you already have configs in `~/.config`, back them up before linking.
- Bazecor is optional; only link it if you use Dygma hardware.
