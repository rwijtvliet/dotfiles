#!/bin/bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    # install
    policy=$(powershell Get-ExecutionPolicy)
    if [ $policy = "Restricted" ]; then
      echo $(powershell Set-ExecutionPolicy AllSigned)
    fi
    
    powershell "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

    choco update chocolatey
    ;;

  "macos" )
    skip
    ;;
    
  * )
    ;;
esac
