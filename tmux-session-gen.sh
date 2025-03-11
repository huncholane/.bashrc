#!/bin/bash
# set window_is_new for new windows
# make this executable in home directory
# then you just do ./session.sh from root to open

is_new_window=true

function new_pane() {
    if [ "$is_new_window" = false ]; then
        tmux split-window
        tmux select-layout tiled
    fi

    tmux send-keys "source ~/.fb_bashrc" C-m
    tmux send-keys 'printf "\033]2;'"$1"'\033\\"' C-m
    tmux send-keys "clear" C-m
    tmux send-keys "$2" C-m
    is_new_window=false
}

tmux new-session -d -s fb -n portforwarding
new_pane "RDS Port Forwarding" 'autossh -L 9101:$RDS_HOST:5432 fb'
new_pane "Metabase Port Forwarding" "autossh -L 9006:127.0.0.1:9006 fb"

tmux new-window -n libraries
is_new_window=true
new_pane "Flyingbytes Root" "cd ~/code/flyingbytes"
new_pane "Django Server" "cd ~/code/flyingbytes/flyingbytes"
new_pane "Turbobid" "cd ~/code/flyingbytes/rustlib/turbobid"
new_pane "Rlib Auth" "cd ~/code/flyingbytes/rustlib/auth"
new_pane "Rlib Fedex" "cd ~/code/flyingbytes/rustlib/fedex"
new_pane "Rlib Live Logger" "cd ~/code/flyingbytes/rustlib/live_logger"
new_pane "Rlib Utils" "cd ~/code/flyingbytes/rustlib/utils"
new_pane "Rlib User Calendar" "cd ~/code/flyingbytes/rustlib/user_calendar"

tmux new-window -n connections
is_new_window=true
new_pane "Local Server" "cd $FB_ROOT
docker compose down --remove-orphans
docker compose up -d
docker compose logs -f --tail 1000 web"
new_pane "Dev Server" 'autossh fbdev
cd flyingbytes/server
docker compose logs -f --tail 100 web'
new_pane "Production Server" 'autossh fb
cd flyingbytes/servers/main
docker compose logs -f --tail 100 web'
new_pane "Local Database" 'psql $LOCAL_DB_URL'
new_pane "Dev Database" 'psql $DEV_DB_URL'
new_pane "Production Database" 'psql $PROD_DB_URL'

tmux new-window -n playground
is_new_window=true
new_pane "FB Root 1" 'cd code/flyingbytes'
new_pane "FB Root 2" 'cd code/flyingbytes'
new_pane "FB Root 3" 'cd code/flyingbytes'
new_pane "Home 1" ""
new_pane "Home 2" ""
new_pane "Home 3" ""

tmux attach -t "fb:1"
