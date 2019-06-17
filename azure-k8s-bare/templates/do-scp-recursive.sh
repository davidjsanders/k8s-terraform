function do_scp_recursive() {
    echo "${1}"
    scp -r -i ~/.ssh/azure_pk ${2} ${3}
}