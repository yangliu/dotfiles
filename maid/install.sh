#!/bin/bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

if test ! "$(type rvm)"; then
  echo "install rvm..."
  if test ! "$(which gpg)"; then
    brew install gpg
  fi
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

gem install maid

if test ! $(which cpulimit); then
  brew install cpulimit
fi

mkdir -p $HOME/.maid
ln -s "$SCRIPTDIR/rules.rb" $HOME/.maid/rules.rb

RUNSH="$SCRIPTDIR/run.sh"
if [ ! -e "$RUNSH" ]; then
  echo "Generating run.sh"
  PATHTORUBY=$(which ruby)
  PATHTOMAID=$(which maid)
  PATHCPULIMIT=$(which cpulimit)
  cat "$SCRIPTDIR/run.sh.temp" | sed "s|PATHCPULIMIT|$PATHCPULIMIT|" | sed "s|PATHTORUBY|$PATHTORUBY|" | sed "s|PATHTOMAID|$PATHTOMAID|" | sed "s|HOMEPATH|$HOME|" > $RUNSH
  chmod +x $RUNSH
fi

launchctl list | grep -q -E 'com.yangliu.maid'
if [[ $? != 0 ]]; then
	echo "Maid adding launch agent"

	cat "$SCRIPTDIR/com.yangliu.maid.plist.temp" | sed "s|PATHTO|$SCRIPTDIR|" > ~/Library/LaunchAgents/com.yangliu.maid.plist
	launchctl load ~/Library/LaunchAgents/com.yangliu.maid.plist
fi

