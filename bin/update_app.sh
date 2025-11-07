#!/usr/bin/env bash

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

# this is needed, or the update would fail because of missing files
COMPOSER_DISCARD_CHANGES=true  composer install --no-interaction

composer update --prefer-source --with-all-dependencies --optimize-autoloader --no-interaction
