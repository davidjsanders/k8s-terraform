source ~/scripts/banner.sh
banner "autocomplete.sh" "Enable BASH kubectl autocompletion"

echo "*** $(date) *** enable autocompletion in shell"
echo "source <(kubectl completion bash)" >> ~/.bashrc
sleep 2

echo "*** $(date) *** enable autocompletion for current session"
source <(kubectl completion bash)
sleep 2
