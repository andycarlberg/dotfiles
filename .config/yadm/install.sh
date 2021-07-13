#!/bin/sh

is_root() {
  return $(id -u)
}

detect_system_type() {
  [ -z $system_type ] && {
    system_type=$(uname -s)
  }
}

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

main() {
  detect_system_type

  yadm clone --bootstrap https://gitlab.com/andycarlberg/dotfiles
}

if is_root; then
  "Don't run this as root!"
  exit 1
fi

main "$@"
