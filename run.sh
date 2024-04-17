#!/bin/bash

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
  echo "This script is for Linux only"
  exit 1
fi

id='MY ALIASES (github.com/ElBigodon/my-aliases)' 
file=~/.bashrc

writeFile() {
  echo -e '\n' >> "$file"
cat << EOF >> "$file"
# $id

# BUN 
alias bi='bun install --no-save'
alias ba='bun add'
alias bx='bunx'
alias bxb='bunx --bun'

# GITHUB 
alias gpr='git pull -f --rebase'
alias gp='git pull -f'
alias gm='git merge'
# END OF $id
EOF
}

exit_script() {
  echo "Exiting..."
  exit 0
}

ask() {
    echo -n "Do you want to add aliases to $b? [y[s]|n]: "
    read ans

    case $ans in
        [YySs]*) return 0 ;;
        [Nn]*) return 1 ;;
        *) echo "Invalid input"; ask ;;
    esac
}

if ! grep -q "$id" "$file"; then 

  if ask; then
    writeFile
    echo "Aliases added to $file"
    echo "run: source $file"
    exit_script
  fi

else
  echo "Aliases already added to $file"
  exit_script
fi

trap exit_script INT