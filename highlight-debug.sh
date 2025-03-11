# Highlight the current directory for all commands
shopt -s extdebug
highlight() {
    if [ "$BASH_LOADED" = false ]; then
        return 0 # Return 0 lets the command run how it normally would
    fi
    results=$(eval "$BASH_COMMAND")
    status=$?
    if [ -n "$results" ]; then # Prevent highlighting if no results
        echo -e "$results" | sed "s|^.*$(pwd).*$|$(printf '\033[0;34m')\0$(printf '\033[0m')|g"
    fi

    if [ $status=0 ]; then
        return 69 # 69 becomes your new success code
    fi
    return $status # Return original error code
}
uh() { # Unset the highlight trap
    echo -e "\033[31mUnsetting highlight trap\033[0m"
    trap - DEBUG
}
hh() { # Set the highlight trap
    echo -e "\033[32mSetting highlight trap\033[0m"
    trap highlight DEBUG
}
trap highlight DEBUG # Set the highlight trap by default
