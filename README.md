PHPXMLRPC Demo Servers
======================

A package making it easy to install the xml-rpc and json-rpc debuggers and demo servers from PHPXMLRPC, PHPJSONRPC and PHPXMLRPC-Extras

NB: only the "harmless" demo servers will be installed, ie. all the ones which do not write anything to the filesystem
and do not function as open http requests relays.

Requirements and Installation
-----------------------------

* PHP (version 5.4 or later, as required by PHPXMLRPC, PHPJSONRPC and PHPXMLRPC-Extras)
* Composer
* bash, curl, git, grep, unzip, shasum and a few other common linux cli tools
* A web server able to run php (recommended: servers supporting `.htaccess` files)

### To install

* after cloning the project from Github, run `./bin/setup_app.sh` (needs write permissions to the current directory and
  a working Composer installation)

### Fine-tuning the installation

* in order to allow the servers to answers CORS preflight requests, use the php.ini setting `auto_prepend_file` to always
  load `./bin/config/_prepend.php`
* if the web server does not support .htaccess files: configure it to deny access to directories `./bin`, `./config`
* to allow auto-upgrade of the 3 bundled libraries, set up a cron-job to execute periodically the script
  `./bin/update_if_canary_found.sh`. Then external processes will be able to trigger the upgrade via creating the file
  `./var/canary/please_update.txt`. This could be done eg. via a github action job with an ftp step.

License
-------
Use of this software is subject to the terms in the [license.txt](license.txt) file
