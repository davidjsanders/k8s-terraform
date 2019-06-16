function do_scp() {
    echo "${1}"
    scp -i ~/.ssh/azure_pk ${2} ${3}
}