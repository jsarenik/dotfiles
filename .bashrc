[[ $- != *i* ]] && return

export LESS="-ciRQ"
alias ls='ls --color=auto'
alias h='ls -1rt'

. $HOME/bin/ssh-agent.sh
#. $HOME/.nvm/nvm.sh

set -o vi
hebcal -wSsdtec -C Berlin -Z eu
eval `dircolors $HOME/.dir_colors`

echo -n "San Mateo: "; TZ="America/Los_Angeles" date +%H:%M
echo -n "   Manila: "; TZ="Asia/Manila" date +%H:%M

test -s $HOME/notes && cat $HOME/notes
