#!/bin/sh

main () {
    # Find module installers and run them
    find modules -name install.sh |
    while read installer;
    do
        sh -c "${installer}";
    done
}

main "$@"
