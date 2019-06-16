function do_ssh() {
    echo "${1}"
    ssh -i ~/.ssh/azure_pk ${2} "${3}"
}