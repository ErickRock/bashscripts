if cat /proc/version | grep Microsoft > /dev/null; then
  export WSL=true
fi
if [ ! "$WSL" = 'true' ]; then return; fi
# put your script here for WSL only
export DOCKER_HOST="unix://$HOME/sockets/docker.sock"
function removeWindowsFromPath {
  echo `echo $PATH | tr ':' '\n' | grep -v /mnt/ | tr '\n' ':'`
}
if ! pgrep socat > /dev/null; then
  tmux new -s docker-relay-session -d docker-relay
fi
pushd /mnt/c > /dev/null
export WHOME=$(wslpath -u $(cmd.exe /c "echo %USERPROFILE%") | sed -e 's/[[:space:]]*$//')
popd > /dev/null
if [ "$WHOME" == "$(pwd)" ]; then
  cd
fi
if hash wslfetch 2>/dev/null; then
  wslfetch
fi
