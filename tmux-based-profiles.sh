# Add bash profile based on tmux session name
if [ -n "$TMUX" ]; then
    TMUX_SESSION=$(tmux display-message -p '#S')
    case "$TMUX_SESSION" in
        "fb")
            source ~/.fb_bashrc
            ;;

        "hygo")
            source ~/.hygo_bashrc
            ;;

        *)
            echo "Unknown tmux session: $TMUX_SESSION"
            ;;
    esac
fi
