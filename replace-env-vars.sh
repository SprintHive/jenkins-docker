#!/bin/bash

CONTENT="$(cat $1)"

for envPlaceholder in $(echo -n "$CONTENT" | grep -o '###ENV:.*###'); do
    envVar=$(echo -n ${envPlaceholder} | sed 's/###ENV:\(.*\)###/\1/')
    envValue=$(printenv ${envVar})
    if [[ ! -z $envValue ]]; then
        CONTENT="$(echo -n "${CONTENT}" | sed "s/${envPlaceholder}/${envValue}/g")"
    fi;
done;

echo -n "${CONTENT}" > $2
