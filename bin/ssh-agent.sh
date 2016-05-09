# This is meant to be sourced, e.g.
# cat <<EOF >> ~/.bashrc
# . $HOME/bin/ssh-agent.sh
# EOF

AFILE=$HOME/.myagent.sh

type ssh-agent >/dev/null && {
while
  test -S "$SSH_AUTH_SOCK" || {
    touch "$AFILE" || exit 1
    . "$AFILE"
  }
  ! test -S "$SSH_AUTH_SOCK"
do
  ssh-agent -s > "$AFILE"
done
}

unset AFILE
