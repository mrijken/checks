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
