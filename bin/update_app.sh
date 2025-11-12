#!/usr/bin/env bash

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

export COMPOSER_DISCARD_CHANGES=true

# this is needed, or the update would fail because of missing files
echo "[$(date)] Running Composer to temporarily reinstall the removed demo files..."
composer install --no-autoloader --no-scripts --no-interaction

echo "[$(date)] Running Composer to update the apps..."
composer update --prefer-source --with-all-dependencies --no-autoloader --no-interaction

# only dump the autoloader after having culled the files
echo "[$(date)] Running Composer to generate autoload configuration..."
composer dump-autoload --optimize
