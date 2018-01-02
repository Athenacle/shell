#/bin/sh

function check_shell_type()
{
    grep "bash" /proc/$$/cmdline >> /dev/null
    if [[ $? -eq 0 ]]; then
        echo "bash"
    else
        grep "zsh" /proc/$$/cmdline >> /dev/null
        if [[ $? -eq 0 ]]; then
            echo "zsh"
        fi
    fi
}

export SHELL_TYPE=$(check_shell_type)
