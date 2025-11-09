#!/bin/bash

source "/usr/lib/git-core/git-sh-prompt"

# Default powerline. Set in subsequent script a customized one
export PS1_PARTS="time user_host venv cwd git_branch git_status retcode"

function ps1_powerline {
    RETCODE=$? # save return code
    NUM_JOBS=$(jobs -rp | wc -l)
    GIT_BRANCH=$(__git_ps1)

    function w() {
        local text="$1"
        local fg="$2"
        local bg="$3"
        local arrow="$4"

        if [ "$arrow" ]; then
            echo "$(ansi bg-$bg)$(ansi ${fg})$text$(ansi $bg)"
        else
            echo "$(ansi bg-$bg)$(ansi ${fg})$text$(ansi $bg)"
        fi
    }

    PS1_PROMPT=""
    SHOW_ARROW=""

    for PART in $PS1_PARTS; do
        case $PART in
        time)
            PS1_PROMPT="$PS1_PROMPT$(w \\t gray black $SHOW_ARROW)"
            ;;

        user_host)
            PS1_PROMPT="$PS1_PROMPT$(w \\u@\\h white green $SHOW_ARROW)"
            ;;

        host)
            PS1_PROMPT="$PS1_PROMPT$(w \\h white green $SHOW_ARROW)"
            ;;

        user)
            PS1_PROMPT="$PS1_PROMPT$(w \\u white green $SHOW_ARROW)"
            ;;

        venv_prompt)
            if [ "$VIRTUAL_ENV_PROMPT" ]; then
                PS1_PROMPT="$PS1_PROMPT$(w $VIRTUAL_ENV_PROMPT white blue true)"
            fi
            ;;

        venv)
            if [ "$VIRTUAL_ENV" ]; then
                venv_basename=$(basename $VIRTUAL_ENV)
                PS1_PROMPT="$PS1_PROMPT$(w $venv_basename white blue true)"
            fi
            ;;

        cwd)
            PS1_PROMPT="$PS1_PROMPT$(w \\W white cyan true)"
            ;;

        retcode)
            if [ ! "$RETCODE" -eq -0 ]; then
                ret_prompt="⚑ $RETCODE"
                ret_prompt=$(w "$ret_prompt" white red true)
                PS1_PROMPT="$PS1_PROMPT$ret_prompt"
            fi
            ;;

        git_branch)
            if [ "$GIT_BRANCH" ]; then
                git_prompt="$GIT_BRANCH"
                git_prompt=$(w "$git_prompt" white magenta true)
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

        esac

        SHOW_ARROW="true"
    done

    PS1_PROMPT="$PS1_PROMPT$(ansi bg-black)$(ansi white)\$ "
    PS1="$PS1_PROMPT"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="ps1_powerline; $PROMPT_COMMAND"
fi
