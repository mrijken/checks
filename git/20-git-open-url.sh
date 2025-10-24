gg() {
    # Get the remote.origin.url from git config
    local git_url=$(git config --get remote.origin.url)

    # Check if git_url is empty
    if [[ -z "$git_url" ]]; then
        echo "Error: No remote origin URL found."
        return 1
    fi

    # Remove .git extension if present
    git_url=${git_url%.git}

    # Open the URL in the default browser
    open "$git_url"
}
