#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )

    # Scoop
    powershell "iwr -useb get.scoop.sh | iex"
    powershell "Set-ExecutionPolicy RemoteSigned -scope CurrentUser" 
    scoop update

    # Choco
    policy=$(powershell Get-ExecutionPolicy)
    if [ $policy = "Restricted" ]; then
      echo $(powershell Set-ExecutionPolicy AllSigned)
    fi
    powershell "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    choco update chocolatey
    ;;

  "macos" )
    
    /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ;;
    
  * )
    ;;
esac
