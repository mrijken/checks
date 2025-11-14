# Activate Python venv when changing into directory containing .venv/bin/activate
# deactivate Python venv when leaving directory containing .venv/bin/activate.
#
# Handle edge case, where present and new directory contain .venv/bin/activate,
# i.e. switching from one venv into the next.
#
# This works for Bash only, place at the end of ~/.bashrc.
#
# Based on https://unix.stackexchange.com/a/170282
function cd_pre_hook_venv() {
    venv_dir="$(realpath ${1})/.venv"
    venv_bin="${venv_dir}/bin/activate"
    if test -f "${venv_bin}"; then
        # change into a directory containing a venv
        if test -n "${VENV_DIR// /}" && test "${VENV_DIR}" != "${venv_dir}"; then
            # changing from dir with venv into dir with venv:
            # unload current venv
            echo "venv: unloading"
            deactivate
            unset VENV_DIR
        fi
        if test "${VENV_DIR}" != "${venv_dir}"; then
            # only source venv, if directory has been changed,
            # i.e. don't source same venv again
            echo "venv: loading ${venv_bin}"
            source "${venv_bin}"
            VENV_DIR=${venv_dir}
        fi
    elif test -n "${VENV_DIR// /}"; then
        # leaving venv dir, i.e. changing into non-venv dir
        echo "venv: unloading"
        deactivate
        unset VENV_DIR
    fi
}

# trigger hook for initial directory
cd_pre_hook_venv .
