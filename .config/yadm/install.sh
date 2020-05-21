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

detect_package_manager() {
  [ -z $package_manager ] && {
    command_exists apt && [ $system_type != "Darwin" ] && {
      package_manager="apt"
      return 0
    }

    command_exists apt-get && {
      package_manager="apt-get"
      return 0
    }

    command_exists pacman && {
      package_manager="pacman"
      return 0
    }

    command_exists brew && {
      package_manager="brew"
      return 0
    }

    echo "Cannot find package manager!"
  }
}

update_package_repos() {
  (is_root || [ $system_type = "Darwin" ]) && sudo="" || sudo="sudo "

  [ -z $package_repos_updated ] && {
    case $package_manager in
      "apt")
        $sudo$package_manager update -y
        package_repos_updated=0
        ;;
      "apt-get")
        $sudo$package_manager update -y
        package_repos_updated=0
        ;;
      *)
        echo "Unable to update package repositories for ${package_manager}."
        ;;
    esac
  }
  return 0
}

# Install a package using the preferred system package manager.
#
# @arg $1
#   executable name
# @arg $2
#   package name (optional, if different from $1)
install_package() {
  (is_root || [ $system_type = "Darwin" ]) && sudo="" || sudo="sudo "
  executable=$1
  package=${2:-$executable}

  update_package_repos

  command_exists $executable || {
    $sudo$package_manager install $package -y
  }
}

install_homebrew() {
  command_exists brew || {
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  }
}

main() {
  detect_system_type
  detect_package_manager

  install_package git

  (is_root || [ $system_type = "Darwin" ]) && sudo="" || sudo="sudo "
  ${sudo}curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
  ${sudo}chmod a+x /usr/local/bin/yadm

  yadm clone --bootstrap https://gitlab.com/andycarlberg/dotfiles
}

if is_root; then
  "Don't run this as root!"
  exit 1
fi

main "$@"
