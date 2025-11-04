#!/usr/bin/env bash

# Removes the parts of phpxmlrpc, phpxmlrpc-jsonrpc and phpxmlrpc-extras which are not required

set -e

cd "$(dirname -- "$(dirname -- "$(readlink -f "$0")")")"

DIRS="extras/.github extras/ajax extras/doc extras/docxmlrpcserver extras/proxy extras/tests \
jsonrpc/.github jsonrpc/demo/client jsonrpc/demo/server/symfony jsonrpc/doc jsonrpc/extras jsonrpc/lib jsonrpc/tests \
phpxmlrpc/.githooks phpxmlrpc/.github phpxmlrpc/demo/client phpxmlrpc/demo/server/symfony phpxmlrpc/doc phpxmlrpc/extras phpxmlrpc/lib phpxmlrpc/tests"

for DIR in $DIRS; do
    if [ -d "vendor/phpxmlrpc/$DIR" ]; then
        rm -rf "vendor/phpxmlrpc/$DIR"
    fi
done

FILES="jsonrpc/demo/server/codegen.php jsonrpc/demo/server/discuss.php jsonrpc/demo/server/legacy.php jsonrpc/demo/server/proxy.php \
jsonrpc/demo/server/methodProviders/CommentManager.php jsonrpc/demo/server/methodProviders/testsuite.php jsonrpc/demo/server/methodProviders/wrapper.php \
phpxmlrpc/demo/vardemo.php phpxmlrpc/demo/server/codegen.php phpxmlrpc/demo/server/discuss.php phpxmlrpc/demo/server/legacy.php phpxmlrpc/demo/server/proxy.php \
phpxmlrpc/demo/server/methodProviders/CommentManager.php phpxmlrpc/demo/server/methodProviders/testsuite.php phpxmlrpc/demo/server/methodProviders/wrapper.php"

for FILE in $FILES; do
    if [ -f "vendor/phpxmlrpc/$FILE" ]; then
        rm -rf "vendor/phpxmlrpc/$FILE"
    fi
done
