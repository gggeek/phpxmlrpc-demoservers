#!/usr/bin/env bash

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

export COMPOSER_DISCARD_CHANGES=true

# this is needed, or the update would fail because of missing files
composer install --no-autoloader --no-scripts --no-interaction

composer update --prefer-source --with-all-dependencies --no-autoloader --no-interaction

# only dump the autoloader after having culled the files
composer dump-autoload --optimize
