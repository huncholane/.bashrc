# Highlight the current directory for all commands
shopt -s extdebug
highlight() {
    if [ "$BASH_LOADED" = false ]; then
        return 0 # Return 0 lets the command run how it normally would
    fi
    results=$(eval "$BASH_COMMAND")
    status=$?
    echo -e "$results" | sed "s|^.*$(pwd).*$|$(printf '\033[0;34m')\0$(printf '\033[0m')|g"

    if [ $status -ne 0 ]; then
        return $status
    else
        return 69 # 69 becomes your new success code
    fi
}
trap highlight DEBUG
