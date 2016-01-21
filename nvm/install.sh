#!/bin/bash

# adopted from https://github.com/songchenwen/dotfiles
# great thanks to the original author!

# SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

brew install nvm
if test ! -f "$HOME/.zsh.after/nvm.zsh"; then
  touch "$HOME/.zsh.after/nvm.zsh"
  chmod +x "$HOME/.zsh.after/nvm.zsh"
  echo "export NVM_DIR=~/.nvm" >> "$HOME/.zsh.after/nvm.zsh"
  echo "source $(brew --prefix nvm)/nvm.sh" >> "$HOME/.zsh.after/nvm.zsh"
fi
