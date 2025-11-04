<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PHPXMLRPC Demo Servers</title>
    <link rel="stylesheet" type="text/css" href="demos.css">
</head>
<body>
<h1>PHPXMLRPC Demo Servers</h1>
<!--<div id="menu">
    <a href="#...">XXX</a> |
</div>-->
<div id="content">
<h2>Available debuggers</h2>
<ul>
    <li><a href="vendor/phpxmlrpc/phpxmlrpc/debugger/index.php">Xml-Rpc</a></li>
    <li><a href="vendor/phpxmlrpc/jsonrpc/debugger/index.php">Json-Rpc</a></li>
</ul>

<h2>Available demo servers</h2>
<?php
    // scan for all .php server files in the 3 known demo directories
    $dirs = array(
        'PhpXmlRpc' => 'phpxmlrpc/demo/server',
        'PhpJsonRpc' => 'jsonrpc/demo/server',
        'PhpXmlRpc Extras' => 'extras/demo/server');

    foreach ($dirs as $package => $dir) {
        echo "<h3>" . htmlspecialchars($package) . "</h3>\n<ul>\n";
        foreach (scandir(__DIR__ . '/vendor/phpxmlrpc/' . $dir) as $file) {
            if (is_dir(__DIR__ . '/vendor/phpxmlrpc/' . $dir . '/' . $file) || !preg_match('/\.php$/', $file) || $file === '_prepend.php' || $file === '_append.php') {
                continue;
            }
            echo "<li><a href=\"" . htmlspecialchars('vendor/phpxmlrpc/' . $dir . '/' . $file) . "\">" . htmlspecialchars($file) . "</a></li>\n";
        }
        echo "</ul>\n";
    }
?>
</div>
</body>
</html>
