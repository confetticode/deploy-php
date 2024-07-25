<?php

namespace SendCode\DeployPHP;

use Symfony\Component\Process\Process;

class NginxSetup implements ScriptInterface
{
    public function __construct(private readonly Server $server)
    {
    }

    public function run(): void
    {
        $user = $this->server->user;
        $host = $this->server->host;
        $port = $this->server->port;
        $priKey = $this->server->priKey;

        $script = 'nginx-setup.sh';
        $file = __DIR__ . '/../scripts/' . $script;
        $code = file_get_contents($file);

        file_put_contents($scriptPath = __DIR__ . '/' . $script, $code);

        $process = Process::fromShellCommandline(
            "ssh -o StrictHostKeyChecking=no -i $priKey -p $port $user@$host 'sudo bash -s' < $scriptPath"
        );

        $process->setTimeout(null);

        $process->run(function ($type, $buffer) {
            // file_put_contents('log.txt', $buffer, FILE_APPEND);
            echo $buffer;
        });

        @unlink($scriptPath);
    }
}
