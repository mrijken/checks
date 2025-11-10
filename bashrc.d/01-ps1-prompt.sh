#!/bin/bash

source "/usr/lib/git-core/git-sh-prompt"

# Default powerline. Set in subsequent script a customized one
export PS1_PARTS="time user_host venv cwd git_branch git_status prompt_sign retcode"

# TODO: use theming

function ps1_powerline {
    RETCODE=$? # save return code
    NUM_JOBS=$(jobs -rp | wc -l)
    GIT_BRANCH=$(__git_ps1)
    normal_fg="15"
    normal_bg="0"
    prompt_sign_fg="15"
    prompt_sign_bg="236"
    time_fg="0"
    time_bg="8"
    user_host_fg="15"
    user_host_bg="2"
    host_fg="15"
    host_bg="2"
    user_fg="15"
    user_bg="2"
    venv_fg="15"
    venv_bg="214"
    cwd_fg="0"
    cwd_bg="110"
    retcode_fg="15"
    retcode_bg="1"
    git_branch_fg="0"
    git_branch_bg="14"

    function w() {
        local text="$1"
        local fg="$2"
        local bg="$3"
        local arrow="$4"

        if [ "$arrow" ]; then
            echo "\[$(tput setab $bg)\]\[$(tput setaf ${fg})\]$text\[$(tput setaf $bg)\]"
        else
            echo "\[$(tput setab $bg)\]\[$(tput setaf ${fg})\]$text\[$(tput setaf $bg)\]"
        fi
    }

    PS1_PROMPT=""
    SHOW_ARROW=""

    for PART in $PS1_PARTS; do
        case $PART in
        time)
            PS1_PROMPT="$PS1_PROMPT$(w \\t $time_fg $time_bg $SHOW_ARROW)"
            ;;

        user_host)
            PS1_PROMPT="$PS1_PROMPT$(w \\u@\\h $user_host_fg $user_host_bg $SHOW_ARROW)"
            ;;

        host)
            PS1_PROMPT="$PS1_PROMPT$(w \\h $host_fg $host_bg $SHOW_ARROW)"
            ;;

        user)
            PS1_PROMPT="$PS1_PROMPT$(w \\u $user_fg $user_bg $SHOW_ARROW)"
            ;;

        venv_prompt)
            if [ "$VIRTUAL_ENV_PROMPT" ]; then
                PS1_PROMPT="$PS1_PROMPT$(w $VIRTUAL_ENV_PROMPT $venv_fg $venv_bg true)"
            fi
            ;;

        venv)
            if [ "$VIRTUAL_ENV" ]; then
                venv_basename=$(basename $VIRTUAL_ENV)
                PS1_PROMPT="$PS1_PROMPT$(w $venv_basename $venv_fg $venv_bg true)"
            fi
            ;;

        cwd)
            PS1_PROMPT="$PS1_PROMPT$(w \\W $cwd_fg $cwd_bg true)"
            ;;

        retcode)
            if [ ! "$RETCODE" -eq -0 ]; then
                ret_prompt="⚑ $RETCODE"
                ret_prompt=$(w "$ret_prompt" $retcode_fg $retcode_bg true)
                PS1_PROMPT="$PS1_PROMPT$ret_prompt"
            fi
            ;;

        git_branch)
            if [ "$GIT_BRANCH" ]; then
                git_prompt="$GIT_BRANCH"
                git_prompt=$(w "$git_prompt" $git_branch_fg $git_branch_bg true)
                PS1_PROMPT="$PS1_PROMPT$git_prompt"
            fi
            ;;

        git_status)
            if [ "$GIT_BRANCH" ]; then
                local NUM_MODIFIED=$(git diff --name-only --diff-filter=M | wc -l)
                local NUM_STAGED=$(git diff --staged --name-only --diff-filter=AM | wc -l)
                local NUM_CONFLICT=$(git diff --name-only --diff-filter=U | wc -l)
                local GIT_STATUS="\[\e[48;5;255m\]\[\e[38;5;208m\]\[\e[38;5;27m\] ✚ $NUM_MODIFIED \[\e[38;5;208m\]\[\e[38;5;2m\] ✔ $NUM_STAGED \[\e[38;5;208m\]\[\e[38;5;9m\] ✘ $NUM_CONFLICT "
                if [ "$RETCODE" -eq 0 ]; then
                    GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;236m\]"
                else
                    GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;160m\]"
                fi

                # TODO: fix git status
            fi
            ;;

        prompt_sign)
            PS1_PROMPT="$PS1_PROMPT$(w " \\$ " $prompt_sign_fg $prompt_sign_bg $SHOW_ARROW)"
            ;;
        esac

        SHOW_ARROW="true"
    done

    PS1_PROMPT="$PS1_PROMPT\[$(tput setab $normal_bg)\]\[$(tput setaf $normal_fg)\]"
    PS1="$PS1_PROMPT"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="ps1_powerline"
fi
