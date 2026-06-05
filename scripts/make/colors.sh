#!/bin/bash

if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
  RED=$'\033[31m'
  GREEN=$'\033[32m'
  YELLOW=$'\033[33m'
  BLUE=$'\033[34m'
  MAGENTA=$'\033[35m'
  CYAN=$'\033[36m'
  RESET=$'\033[0m'
else
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  RESET=''
fi
