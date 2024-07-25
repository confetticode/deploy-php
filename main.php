<?php

use SendCode\DeployPHP\NginxSetup;
use SendCode\DeployPHP\PHPSetup;
use SendCode\DeployPHP\SecuritySetup;
use SendCode\DeployPHP\Server;

require __DIR__.'/vendor/autoload.php';

$server = new Server('vagrant', '192.168.33.11', 22, '~/.ssh/id_rsa');
$script = new SecuritySetup(
    $server, file_get_contents('/home/sendcode/.ssh/id_rsa.pub')
);
$script->run();

$server = new Server('sendcode', '192.168.33.11', 22, '~/.ssh/id_rsa');
$script = new NginxSetup($server);
$script->run();

$server = new Server('sendcode', '192.168.33.11', 22, '~/.ssh/id_rsa');
$script = new PHPSetup($server);
$script->run();
