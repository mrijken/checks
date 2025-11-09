#!/bin/bash

source "/usr/lib/git-core/git-sh-prompt"

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

    PS1_PROMPT="$(w \\t gray black)"
    PS1_PROMPT="$PS1_PROMPT$(w \\u@\\h white green true)"

    if [ "$VIRTUAL_ENV_PROMPT" ]; then
        PS1_PROMPT="$PS1_PROMPT$(w $VIRTUAL_ENV_PROMPT white blue true)"
    fi

    if [ ! "$RETCODE" -eq -0 ]; then
        ret_prompt="⚑ $RETCODE"
        ret_prompt=$(w "$ret_prompt" white red true)
        PS1_PROMPT="$PS1_PROMPT$ret_prompt"
    fi

    PS1_PROMPT="$PS1_PROMPT$(w \\W white cyan true)"

    if [ "$GIT_BRANCH" ]; then
        local NUM_MODIFIED=$(git diff --name-only --diff-filter=M | wc -l)
        local NUM_STAGED=$(git diff --staged --name-only --diff-filter=AM | wc -l)
        local NUM_CONFLICT=$(git diff --name-only --diff-filter=U | wc -l)
        local GIT_STATUS="\[\e[48;5;255m\]\[\e[38;5;208m\]\[\e[38;5;27m\] ✚$NUM_MODIFIED \[\e[38;5;208m\]\[\e[38;5;2m\] ✔$NUM_STAGED \[\e[38;5;208m\]\[\e[38;5;9m\] ✘$NUM_CONFLICT "
        if [ "$RETCODE" -eq 0 ]; then
            GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;236m\]"
        else
            GIT_STATUS+="\[\e[38;5;255m\]\[\e[48;5;160m\]"
        fi

        # TODO: add git status

        git_prompt="$GIT_BRANCH"
        git_prompt=$(w "$git_prompt" white magenta true)
        PS1_PROMPT="$PS1_PROMPT$git_prompt"
    fi

    PS1_PROMPT="$PS1_PROMPT$(ansi bg-black)$(ansi white)\$ "
    PS1="$PS1_PROMPT"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="ps1_powerline; $PROMPT_COMMAND"
fi
