#!/bin/bash

if test ! "$(which brew)"; then
  echo "install homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
