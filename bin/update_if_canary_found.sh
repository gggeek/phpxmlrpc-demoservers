#!/usr/bin/env bash

# Checks for existence of a "canary" file. If found, updates the installation and removes it.
# Designed to be scheduled as cronjob.

BASEDIR="$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"
LOGFILE="$BASEDIR/var/update.log"

cd "$BASEDIR"

CANARY="./var/canary/please_update.txt"

if [ -f "$CANARY" ]; then

    echo "[$(date)] Canary file found" >> "$LOGFILE"

    # @todo stop attempting to update if the canary file is too old, as that means most likely a file permissions
    #       issue or some other permanent configuration problem

    echo "[$(date)] Updating self" >> "$LOGFILE"
    CHECKSUM="$(shasum "$(readlink -f "$0")")"
    git pull >> "$LOGFILE"
    if [ "$?" != 0 ]; then
        echo "[$(date)] Updating self failed! Going on anyway..." >> "$LOGFILE"
    fi

    if [ "$(shasum "$(readlink -f "$0")")" != "$CHECKSUM" ]; then
        echo "[$(date)] Update script changed! Restarting it..." >> "$LOGFILE"
        . "$(readlink -f "$0")"
    else
        ./bin/update_app.sh >> "$LOGFILE"
        if [ "$?" != 0 ]; then
            echo "[$(date)] Updating the apps failed! Not removing the canary file..." >> "$LOGFILE"
            exit 1
        fi

        echo "[$(date)] Removing the canary file" >> "$LOGFILE"
        rm "$CANARY"
    fi
fi
