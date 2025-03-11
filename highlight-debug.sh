# Highlight the current directory for all commands
# WARNING: This changes the success status code to 69
shopt -s extdebug
highlight() {
    if [ "$BASH_LOADED" = false ] || [ "$BASH_COMMAND" = "uh" ] || [ "$BASH_COMMAND" = "hh" ] || [[ "$BASH_COMMAND" =~ "trap" ]]; then
        return 0 # Return 0 lets the command run how it normally would
    fi
    results=$(eval "$BASH_COMMAND" 2>&1)
    status=$?
    if [ -n "$results" ]; then # Prevent highlighting if no results
        echo -e "$results" | sed "s|^.*$(pwd).*$|$(printf '\033[0;34m')\0$(printf '\033[0m')|g"
    fi

    if [ $status=0 ]; then
        return 69 # 69 becomes your new success code
    fi
    echo "status: $status"
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
# trap highlight DEBUG # Set the highlight trap by default
