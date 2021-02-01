#!/bin/bash

asUser() {
    bash -c "$1"
}

obf() {
    project=$(jq --arg name "$1" -r '.[$name]' projects.json)

    if [ "$project" == "null" ]; then
        echo "Please provide a valid project name. Try using: paramorphism add <name> <directory>"
        exit 1
    fi

    java -jar ./paramorphism.jar "$project/paramorphism.json"
}

# add() {

# }

# remove() {

# }

install() {
    echo "--------------------------------------------"
    echo "Update apt"
    echo "--------------------------------------------"
    sudo apt -y update
    echo "--------------------------------------------"
    if which jq >/dev/null; then
        echo "JQ is already installed, skipping..."
        echo "--------------------------------------------"
    else
        echo "JQ isn't installed. Setting up JQ."
        sudo apt -y install jq
        echo "--------------------------------------------"

    fi

    if which wget >/dev/null; then
        echo "Wget is already installed, skipping..."
        echo "--------------------------------------------"
    else
        echo "Wget isn't installed. Setting up Wget."
        sudo apt -y install wget
        echo "--------------------------------------------"

    fi

    if [ ! -d "${HOME}/.para" ]; then
        echo "Creating script home."

        mkdir "${HOME}/.para"
        touch "${HOME}/.para/projects.json"

        wget https://raw.githubusercontent.com/Xenfo/paramorphism-script/main/sent-env.sh -P "$pwd" -q
        source "set-env.sh"

        # TODO: ask if YML or JSON
        wget https://raw.githubusercontent.com/Xenfo/paramorphism-script/main/default-config.json -P "${HOME}/.para" -q
        echo "--------------------------------------------"
    else
        echo "Script home is already made, skipping..."
        echo "--------------------------------------------"
    fi

    echo "Finished installing!"
    echo "--------------------------------------------"
}

# uninstall() {

# }

# repair() {

# }

case "$1" in
obf)
    obf "$2"
    ;;
add)
    add "$2" "$3"
    ;;
remove)
    remove "$2" "$3"
    ;;
install)
    install
    ;;
uninstall)
    uninstall
    ;;
*)
    echo "Usage: $0 [obf|add|remove|install|uninstall|repair]"
    exit 1
    ;;
esac

exit 0
