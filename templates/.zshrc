# ##############################
# # Location: ~/.zshrc
# # This file contains personal Zsh shell settings.
# # Place this file in your home directory.
# ##############################

export PATH=/opt/homebrew/opt/python@3.11/bin:$PATH
export PYTHONPATH=~/Dev/GitHub
export python=python3
export pip=pip3

# Alias to display interface name along with associated IP address
alias showip='ifconfig | awk "/^[a-z]/ { iface=\$1; } /inet / { print iface, \$2 }" | sed "s/://"'

# API keys
export OPENAI_API_KEY=secret