# The worker scripts are running in the background and this script
# now waits until each worker is completed. A worker signifies
# completion by copying a hostname.done file to the jumpbox. When
# the number of files matches the number of workers, the script
# proceeds.
banner "ssh-commands.sh" "Wait for workers to complete"

function show_state() {
    echo "Workers $1 - $2 done for $3 agents"
}

worker_array=(${workers})
sleep_time=30
IFS=$" "
echo
while true
do
    files=$(ls -m *.done 2> /dev/null)
    done_files=(`echo $files`)

    # echo "Done notices : $${#done_files[@]}"
    # echo "Workers      : $${#worker_array[@]}"

    if [ "$${#done_files[@]}" == "$${#worker_array[@]}" ]
    then
        break;
    fi
    show_state "In progress" "$${#done_files[@]}" "$${#worker_array[@]}"
    sleep $${sleep_time}
done
show_state "Completed" "$${#done_files[@]}" "$${#worker_array[@]}"
echo
