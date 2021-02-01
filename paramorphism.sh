#!/bin/bash

obf() {
    project=$(jq --arg name "$1" -r '.[$name]' projects.json)

    if [ "$project" == "null" ]; then
        echo "Please provide a valid project name. Try using: paramorphism add <name> <directory>"
        exit 1
    fi

    java -jar ./paramorphism.jar "$project/paramorphism.json"
}

add() {

}

remove() {

}

install() {
    mkdir 
}

uninstall() {

}

case "$1" in
obf)
    obf "$2"
    ;;
add)
    add $2 $3
    ;;
remove)
    remove $2 $3
    ;;
install)
    install
    ;;
uninstall)
    uninstall
    ;;
*)
    echo "Usage: $0 [obf|add|remove|install|uninstall]"
    exit 1
    ;;
esac

exit 0
