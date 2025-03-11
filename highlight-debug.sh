# Highlight the current directory for all commands
shopt -s extdebug
highlight() {
    if [ "$BASH_LOADED" = false ]; then
        return 0
    fi
    eval "$BASH_COMMAND" | sed "s|^.*$(pwd).*$|$(printf '\033[0;34m')\0$(printf '\033[0m')|g"
    return 1
}
trap highlight DEBUG
