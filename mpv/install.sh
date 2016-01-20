#!/bin/bash

# adopted from https://github.com/songchenwen/dotfiles
# great thanks to the original author!

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

if test ! "$(which mpv)"; then
  sh "$SCRIPTDIR/../brew/install.sh"
  echo "install mpv with homebrew..."
  brew install mpv --with-bundle
  brew linkapps mpv
fi

if test ! "$(which subliminal)"; then
  echo "install subliminal with homebrew..."
  brew install subliminal
fi

echo "configure mpv..."
mkdir -p ~/.config
cd ~/.config || exit
ln -s "$SCRIPTDIR"
mkdir -p "$SCRIPTDIR/watch_later"
mkdir -p "$SCRIPTDIR/tmp"
touch "$SCRIPTDIR/tmp/icc-cache"

APPFILE=/Applications/mpv.app
if [ ! -e "$APPFILE" ]; then
  exit
fi

BUNDLEID=$(mdls -name kMDItemCFBundleIdentifier -r $APPFILE)
EXTS=( 3GP ASF AVI FLV M4V MKV MOV MP4 MPEG MPG MPG2 MPG4 RMVB WMV )

if test ! "$(which duti)"; then
  sh "$SCRIPTDIR/../brew/install.sh"
  echo "install duti..."
  brew install duti
fi

for ext in "${EXTS[@]}"
do
  lower=$(echo $ext | awk '{print tolower($0)}')
  duti -s $BUNDLEID $ext all
  duti -s $BUNDLEID $lower all
done
