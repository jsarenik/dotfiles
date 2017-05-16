
test -n "$PS1" && {
  alias h='ls -lrt'
  . $HOME/bin/ssh-agent.sh
#  . $HOME/bin/git-prompt.sh
  cat $HOME/notes
  pgrep -f estenie || ( su -c "nohup busybox sh $HOME/bin/estenie.sh &" )
}
