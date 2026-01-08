# LAYOUT_NAME is one of
# - the name (without extension) of the layout in ~/.config/layouts
# - the path (so including extension) of the layout with a kdl extension
# - http url with a kdl extension
# When not given its set to a default name
# - `ide_rust` when a Cargo.toml is found
# - `ide_python` when apyproject.toml is found
# - `ide` otherwise

# Usage
# z <SESSION_NAME> [<LAYOUT_NAME]
# z
# In the last situation, it checks for an .zellij/env file, if it is found it uses the SESSION_NAME and LAYOUT_NAME from there
# otherwise it will check for Cargo.toml or pyproject.toml and use the default names for the LAYOUT_NAME and the name
# of the cwd as SESSION_NAME
function z() {
    LAYOUT_NAME=""
    if [ "$1" ]; then
        SESSION_NAME=$1
        if [ "$2" ]; then
            LAYOUT_NAME=$2
        fi
    elif [ -f ".zellij/env" ]; then
        # get the SESSION_NAME and LAYOUT_NAME from the settings
        source .zellij/env
        if ! [ "$LAYOUT_NAME" ]; then
            echo "LAYOUT_NAME is not set in .zellij/env"
        fi
        if ! [ "$SESSION_NAME" ]; then
            echo "SESSION_NAME is not set in .zellij/env"
        fi
    else
        # no config file found, so list all sessions and let the user choose
        SESSION_NAME=$(zellij ls -n -s| fzf --prompt="󱊄 Select a session: (ctrl-d to delete)" --height=20% --min-height=10 --layout=reverse --border  --bind "ctrl-d:execute(zellij delete-session {1} --force)+reload(zellij ls -n -s)")
        if [ -z "$SESSION_NAME" ]; then
            echo "󰂭  No session selected!"
            return 1
        fi
    fi

    echo "Open zellij with session $SESSION_NAME and layout $LAYOUT_NAME"

    if zellij list-sessions -s | grep ^${SESSION_NAME}$; then
        zellij a ${SESSION_NAME}
    else
        # session can not be opened, so create a new one
        if [ ${LAYOUT_NAME} ]; then
            zellij -s ${SESSION_NAME} -n ${LAYOUT_NAME}
        else
            zellij -s ${SESSION_NAME}
        fi
    fi
}
