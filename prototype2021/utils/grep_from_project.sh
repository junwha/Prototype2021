#!/bin/sh

function help_prompt() {
    echo "<pattern> : Find the match of given pattern"
    echo "-e <pattern> : Find the exact match of given pattern"
    echo ''
    echo '**IMPORTANT** : This shell script should be executed at project root directory'
}

echo ''

ROOT=$(pwd)
CMDARG='-inR'
SEARCH=$1

cd $ROOT

if [ $# -eq 0 ]; then
    help_prompt
else

    if [ $# -eq 2 ]; then
        if [ $1 = "-e" ]; then
            CMDARG='-nRw'
            SEARCH=$2
        fi
    fi

    if [ $1 = "-h" ]; then
        help_prompt
    else
        grep $CMDARG -E --include='*.dart' $SEARCH *
    fi

fi
