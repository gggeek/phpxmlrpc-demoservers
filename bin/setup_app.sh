#!/usr/bin/env bash

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

# @todo automatically install composer if not available

composer install --prefer-source

./cleanup.sh
