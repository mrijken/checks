cd_pre_hook_dotenv() {
    # Load .env file
    env_file="$(realpath ${1})/.env"
    if [ -f "$env_file" ]; then
        echo "Loading variables from $env_file"

        # Read the file and process each line
        while IFS= read -r line || [ -n "$line" ]; do # this ensures the last line is read even without a newline at the end

            # Skip comments and empty lines
            [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue

            # Extract key and value
            key=$(echo "$line" | cut -d '=' -f 1 | xargs)
            value=$(echo "$line" | cut -d '=' -f 2- | xargs)

            # Export the environment variable if valid
            if [[ "$key" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
                export "$key=$value"
            else
                echo "Warning: Invalid variable name '$key'"
            fi
        done <"$env_file"
    fi

}
