#!/bin/bash

source "/usr/lib/git-core/git-sh-prompt"

ansi_color() {
    local type="$1"
    local color="$2"

    # Function to handle different color formats
    parse_color() {
        local type="$1" # "38" for foreground, "48" for background
        local color="$2"

        if [[ "$color" =~ ^[0-9]+$ ]] && [ "$color" -ge 0 ] && [ "$color" -le 255 ]; then
            # 256-color mode
            echo "\033[${type};5;${color}m"
        elif [[ "$color" =~ ^[0-9]+,[0-9]+,[0-9]+$ ]]; then
            # RGB mode
            IFS=',' read -r r g b <<<"$color"
            echo "\033[${type};2;${r};${g};${b}m"
        else
            # Named colors (same as basic function)
            case "$color" in
            "black") echo "\033[$([ "$type" = "38" ] && echo "30" || echo "40")m" ;;
            "red") echo "\033[$([ "$type" = "38" ] && echo "31" || echo "41")m" ;;
            "green") echo "\033[$([ "$type" = "38" ] && echo "32" || echo "42")m" ;;
            "yellow") echo "\033[$([ "$type" = "38" ] && echo "33" || echo "43")m" ;;
            "blue") echo "\033[$([ "$type" = "38" ] && echo "34" || echo "44")m" ;;
            "magenta") echo "\033[$([ "$type" = "38" ] && echo "35" || echo "45")m" ;;
            "cyan") echo "\033[$([ "$type" = "38" ] && echo "36" || echo "46")m" ;;
            "white") echo "\033[$([ "$type" = "38" ] && echo "37" || echo "47")m" ;;
            *) echo "" ;;
            esac
        fi
    }

    if [ "$type" -eq "fg"]; then
        echo -e "$(parse_color "$color" "38")"
    fi

    # Parse background color
    if [ -n "$type" = "bg" ]; then
        echo -e "$(parse_color "$color" "48")"
    fi
}

function ps1_powerline {
    RETCODE=$? # save return code
    NUM_JOBS=$(jobs -rp | wc -l)
    GIT_BRANCH=$(__git_ps1)

    local GREY="\[\e[48;5;240m\]\[\e[38;5;250m\]"
    local GREY=""
    local GREY_END="\[\e[48;5;2m\]\[\e[38;5;240m\]"

    local GREEN="\[\e[48;5;2m\]\[\e[38;5;255m\]"
    local GREEN_END="\[\e[48;5;27m\]\[\e[38;5;2m\]"

    local ORANGE="\[\e[48;5;208m\]\[\e[38;5;255m\]"
    local ORANGE_END="\[\e[48;5;236m\]\[\e[38;5;208m\]"
    local ORANGE_RET_END="\[\e[48;5;160m\]\[\e[38;5;208m\]" # when next segment is prompt with return code

    local BLUE="\[\e[48;5;27m\]\[\e[38;5;255m\]"
    local BLUE_END="\[\e[48;5;208m\]\[\e[38;5;27m\]"     # when next segment is git
    local BLUE_END_JOBS="\[\e[48;5;93m\]\[\e[38;5;27m\]" # when next segment is jobs
    local BLUE_END_ALT="\[\e[48;5;236m\]\[\e[38;5;27m\]" # when next segment is prompt
    local BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]" # when next segment is prompt with return code

    local JOBS="\[\e[48;5;93m\]\[\e[38;5;255m\] ⏎"
    local JOBS_END="\[\e[48;5;236m\]\[\e[38;5;93m\]"        # when next segment is prompt
    local JOBS_NO_RET_END="\[\e[48;5;208m\]\[\e[38;5;93m\]" # when next segment is git
    local JOBS_NO_GIT_END="\[\e[48;5;160m\]\[\e[38;5;93m\]" # when next segment is prompt with return code

    local RET="\[\e[48;5;160m\]\[\e[38;5;255m\]"
    local RET_END="\[\e[0m\]\[\e[38;5;160m\]\[\e[0m\] "

    local PROMPT="\[\e[48;5;236m\]\[\e[38;5;255m\]"
    local PROMPT_END="\[\e[0m\]\[\e[38;5;236m\]\[\e[0m\] "

    if [ ! -w "$PWD" ]; then
        # Current directory is not writable
        BLUE_END="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;208m\]\[\e[38;5;160m\]"
        BLUE_END_JOBS="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;93m\]\[\e[38;5;160m\]"
        BLUE_END_ALT="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  \[\e[48;5;236m\]\[\e[38;5;160m\]"
        BLUE_END_RET="\[\e[48;5;160m\]\[\e[38;5;27m\]\[\e[38;5;255m\]  "
    fi

    TIME_START="$GREY"
    TIME_END="$END_GREY"
    HOST_START="$GREEN"
    HOST_END="$END_GREEN"
    VIRTUALENV_START="$GREY"
    VIRTUALENV_END="$END_GREY"

    PS1_PROMPT="$TIMES_START \t $TIME_END"

    PS1_PROMPT="$PS1_PROMPT$HOST_START @\h $HOST_END"

    if [ "$VIRTUAL_ENV_PROMPT" ]; then
        PS1_PROMPT="$PS1_PROMPT $VIRTUALENV_START $VIRTUAL_ENV_PROMPT $VIRTUALENV_END"
    fi

    if [ -z "$GIT_BRANCH" ]; then
        # Is not a git repo
        if [ "$RETCODE" -eq 0 ]; then
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs or ret code
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_ALT$PROMPT \$ $PROMPT_END"
            else
                # no ret code but jobs
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_END$PROMPT \$ $PROMPT_END"
            fi
        else
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs but ret code is there
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_RET$RET \$ ⚑ $RETCODE $RET_END"
            else
                # Both jobs and ret code
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_GIT_END$RET \$ ⚑ $RETCODE $RET_END"
            fi
        fi
    else
        # Is a git repo
        local NUM_MODIFIED=$(git diff --name-only --diff-filter=M | wc -l)
        local NUM_STAGED=$(git diff --staged --name-only --diff-filter=AM | wc -l)
        local NUM_CONFLICT=$(git diff --name-only --diff-filter=U | wc -l)
        local GIT_STATUS="\[\e[48;5;255m\]\[\e[38;5;208m\]\[\e[38;5;27m\] ✚$NUM_MODIFIED \[\e[38;5;208m\]\[\e[38;5;2m\] ✔$NUM_STAGED \[\e[38;5;208m\]\[\e[38;5;9m\] ✘$NUM_CONFLICT "
        if [ "$RETCODE" -eq 0 ]; then
            GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;236m\]"
        else
            GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;160m\]"
        fi

        if [ "$RETCODE" -eq 0 ]; then
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs or ret code
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END$ORANGE $GIT_BRANCH $GIT_STATUS$PROMPT \$ $PROMPT_END"
            else
                # no ret code but jobs
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE $GIT_BRANCH $GIT_STATUS$PROMPT \$ $PROMPT_END"
            fi
        else
            if [ "$NUM_JOBS" -eq 0 ]; then
                # No jobs but ret code is there
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END$ORANGE $GIT_BRANCH $GIT_STATUS$RET \$ ⚑ $RETCODE $RET_END"
            else
                # Both jobs and ret code
                PS1="$PS1_PROMPT$GREEN @\h $GREEN_END$BLUE \W $BLUE_END_JOBS$JOBS$NUM_JOBS $JOBS_NO_RET_END$ORANGE $GIT_BRANCH $GIT_STATUS$RET \$ ⚑ $RETCODE $RET_END"
            fi
        fi

    fi
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="ps1_powerline; $PROMPT_COMMAND"
fi
