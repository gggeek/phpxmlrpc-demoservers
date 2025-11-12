#!/usr/bin/env bash

# Checks for existence of a "canary" file. If found, updates the installation and removes it.
# Designed to be scheduled as cronjob.

BASEDIR="$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"
LOGFILE="$BASEDIR/var/update.log"

cd "$BASEDIR"

CANARY_FILE="./var/canary/please_update.txt"
FTP_STATE_FILE="./var/canary/.ftp-deploy-sync-state.json"

if [ -f "$CANARY_FILE" ]; then

    echo "[$(date)] Canary file found" >> "$LOGFILE"

    # @todo stop attempting to update if the canary file is too old, as that means most likely a file permissions
    #       issue or some other permanent configuration problem

    echo "[$(date)] Updating self (git pull)..." >> "$LOGFILE"
    CHECKSUM="$(shasum "$(readlink -f "$0")")"
    git pull >> "$LOGFILE" 2>&1
    if [ "$?" != 0 ]; then
        echo "[$(date)] Updating self failed! Going on anyway..." >> "$LOGFILE"
    fi

    if [ "$(shasum "$(readlink -f "$0")")" != "$CHECKSUM" ]; then
        echo "[$(date)] Update script (self) changed! Restarting it..." >> "$LOGFILE"
        . "$(readlink -f "$0")"
    else
        echo "[$(date)] Running the apps update script..." >> "$LOGFILE"
        # The update_app.sh script runs composer, which has some output on both stdout and stderr.
        # We try avoiding triggering cron emails by piping it all into the log file
        ./bin/update_app.sh >> "$LOGFILE" 2>&1
        if [ "$?" != 0 ]; then
            echo "[$(date)] Updating the apps failed! Exiting without removing the canary file" >> "$LOGFILE"
            exit 1
        fi

        echo "[$(date)] Removing the canary file" >> "$LOGFILE"
        rm "$CANARY_FILE"

        # Remove a file left over from the github action we use for ftp creation of the canary file
        if [ -f "$FTP_STATE_FILE" ]; then
            rm "$FTP_STATE_FILE"
        fi
    fi

    echo "[$(date)] Done" >> "$LOGFILE"
fi
