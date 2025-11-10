function cd() {
    # Loop over all functions starting with "cd_pre_hook"
    for fn in $(declare -F | awk '{print $3}' | grep '^cd_pre_hook_'); do
        "$fn" "$1" # call the function
    done

    builtin cd "$1"
}
