# This is meant to be sourced, e.g.
# cat <<EOF >> ~/.bashrc
# . $HOME/bin/ssh-agent.sh
# EOF

type ssh-agent >/dev/null && {
AFILE=$HOME/.myagent.sh
touch "$AFILE" || exit 1
while
  test -S "$SSH_AUTH_SOCK" || . "$AFILE"
  ! test -S "$SSH_AUTH_SOCK"
do
  ssh-agent -s > "$AFILE"
done
}
