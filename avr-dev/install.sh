#!/bin/bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )

if test ! "$(which avr-gcc)"; then
  sh "$SCRIPTDIR/../brew/install.sh"
  echo "install avr-libc with homebrew..."
  brew tap osx-cross/avr
  brew install avr-libc
fi

if test ! "$(which dfu-programmer)"; then
  echo "install dfu-programmer with homebrew..."
  brew install dfu-programmer
fi

if test ! "$(which avrdude)"; then
  echo "install avrdude with homebrew..."
  brew install avrdude
fi
