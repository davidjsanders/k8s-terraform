#!/usr/bin/env bash
yaml_files=$(ls -1 traefik/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Applying yaml for: $file"
    kubectl apply -f $file
done
echo "Done."
echo
