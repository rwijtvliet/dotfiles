#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
"linux")
  info "Installing app"
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt update
  sudo apt install python3 python3-pip python-is-python3 python3.12
  sudo apt install python3.14 python3.14-venv python3.14-dev
  #install pakcage managers
  curl -LsSf https://astral.sh/uv/install.sh | sh
  pip3 install poetry
  ;;

"windows")
  scoop install python
  pip install poetry
  ;;

"macos")
  info "Installing app"
  brew install python
  # The aliases python=python3 and pip=pip3 should already be available. But just in case we use pip3 here
  pip3 install poetry
  ;;

*) ;;
esac
