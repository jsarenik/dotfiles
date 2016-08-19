# This is meant to be sourced, e.g.
# cat <<EOF >> ~/.bashrc
# . $HOME/bin/ssh-agent.sh
# EOF

AFILE=$HOME/.myagent.sh

test -S "$SSH_AUTH_SOCK" && {
  set | grep SSH_AUTH_SOCK; echo "export SSH_AUTH_SOCK";
  echo "echo Using pre-initialized SSH Agent"
} > "$AFILE"

touch "$AFILE" || exit 1
until
  . "$AFILE"
  test -S "$SSH_AUTH_SOCK"
do
  ssh-agent -s > "$AFILE" || exit 1
done

unset AFILE
