#!/bin/sh
KPID=$(hyprctl -j activewindow | jq -r '.pid')
SHELL_PID=$(pgrep -P "$KPID" -x bash 2>/dev/null || pgrep -P "$KPID" -x zsh 2>/dev/null || pgrep -P "$KPID" -x fish 2>/dev/null)
DIR=$(readlink /proc/$SHELL_PID/cwd 2>/dev/null)
if [ -n "$DIR" ] && [ -d "$DIR" ]; then
    exec kitty -d "$DIR"
else
    exec kitty
fi   
