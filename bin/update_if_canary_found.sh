#!/usr/bin/env bash

# Checks for existence of a "canary" file. If found, updates the installation and removes it.
# Designed to be scheduled as cronjob.

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

CANARY="./var/canary/please_update.txt"

if [ -f "$CANARY" ]; then
    ./bin/update_app.sh
    rm "$CANARY"
fi
