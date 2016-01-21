#!/bin/bash
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

if test ! -d "$HOME/.yadr"; then
  echo "install yadr..."
  cd $HOME || exit
  sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"

fi

echo "config yadr..."
# gitconfig user
if test ! -f "$HOME/.gitconfig.user"; then
  echo "config gitconfig.user..."
  touch $HOME/.gitconfig.user
  cat "$SCRIPTDIR/gitconfig.user" >> "$HOME/.gitconfig.user"
  vim $HOME/.gitconfig.user
  if test -f "$SCRIPTDIR/gitconfig.user.sourcetree"; then
    cat "$SCRIPTDIR/gitconfig.user.sourcetree" >> "$HOME/.gitconfig.user"
  fi
fi

# set prompt to sorin
echo "prompt sorin" > $HOME/.zsh.after/prompt.zsh
chmod +x $HOME/.zsh.after/prompt.zsh

#iTerm2 shell integration
/usr/bin/curl -L https://iterm2.com/misc/zsh_startup.in >> $HOME/.iterm2_shell_integration.zsh
chmod +x $HOME/.iterm2_shell_integration.zsh
echo "source ~/.iterm2_shell_integration.zsh" > $HOME/.zsh.after/iterm2.zsh
chmod +x $HOME/.zsh.after/iterm2.zsh

#setup path
if test ! -f "$HOME/.zsh.after/path.zsh"; then
  touch "$HOME/.zsh.after/path.zsh"
  chmod +x $HOME/.zsh.after/path.zsh
  echo "PATH=\"$HOME/bin:${PATH}\"" >> $HOME/.zsh.after/path.zsh
  echo "export PATH" >> $HOME/.zsh.after/path.zsh
fi
