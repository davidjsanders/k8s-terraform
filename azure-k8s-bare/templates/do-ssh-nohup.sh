function do_ssh_nohup() {
    echo "${1}"
    ssh -n -i ~/.ssh/azure_pk ${2} "nohup ${3} > ~/$(hostname).log 2>&1 &"
}