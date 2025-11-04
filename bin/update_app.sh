#!/usr/bin/env bash

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

composer update --prefer-source --with-all-dependencies --optimize-autoloader --no-interaction

./cleanup.sh
