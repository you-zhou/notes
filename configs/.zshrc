##############################
# Location: ~/.zshrc
# This file contains personal Zsh shell settings.
# Place this file in your home directory.
##############################

export PATH=/opt/homebrew/opt/python@3.11/bin:$PATH
export PYTHONPATH=~/Dev/GitHub

alias python=python3
alias pip=pip3
# Alias to activate virtual environment from project folder.
alias venv='source .venv/bin/activate'
# Alias to display interface name along with associated IP address
alias showip='ifconfig | awk "/^[a-z]/ { iface=\$1; } /inet / { print iface, \$2 }" | sed "s/://"'

# API keys
export OPENAI_API_KEY=secret

# Automatically activate a virtual environment when you cd into a project directory. 
cd() {
  builtin cd "$@"
  if [ -f .venv/bin/activate ]; then
    source .venv/bin/activate
  fi
}