Sample ~/.zshrc
```sh
export PATH=/opt/homebrew/opt/python@3.11/bin:$PATH
export PYTHONPATH=~/Dev/GitHub

alias showip='ifconfig | awk "/^[a-z]/ { iface=\$1; } /inet / { print iface, \$2 }" | sed "s/://"'

# API keys
export OPENAI_API_KEY=secret
```