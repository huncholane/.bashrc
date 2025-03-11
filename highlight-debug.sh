# Highlight the current directory for all commands
highlight() {
    eval "$BASH_COMMAND" | sed "s|^.*$(pwd).*$|$(printf '\033[0;34m')\0$(printf '\033[0m')|g"
    return 1
}
shopt -s extdebug
trap highlight DEBUG
