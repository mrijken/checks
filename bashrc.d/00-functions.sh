function all_ansi_colors() {
    for ((i = 0; i < 256; i++)); do
        echo -n '  '
        tput setab $i
        tput setaf $((((i > 231 && i < 244) || ((i < 17) && (i % 8 < 2)) || (\
        i > 16 && i < 232) && ((i - 16) % 6 * 11 + (i - 16) / \
        6 % 6 * 14 + (i - 16) / 36 * 10) < 58) ? 7 : 16))
        printf " %3d " $i
        tput op
        ((((i < 16 || i > 231) && ((i + 1) % 8 == 0)) || ((i > 16 && i < 232) && ((i - 15) % 6 == 0)))) &&
            printf "\n"
    done
}

# Colorful logging helper: INFO (green) level
function info() {
    echo -e "\e[32m* ${*}\e[39m"
}

# Colorful logging helper: WARN (orange) level
function warn() {
    echo -e "\e[33m* ${*}\e[39m"
}

# Colorful logging helper: ERROR (red) level
function error() {
    echo -e "\e[31m* ${*}\e[39m"
}

# Colorful logging helper: just a new line
function nln() {
    echo ""
}
