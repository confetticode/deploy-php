<?php

namespace SendCode\DeployPHP;

readonly class Server
{
    public function __construct(
        public readonly string $user,
        public readonly string $host,
        public readonly int $port,
        public readonly string $priKey,
    ) {
    }
}
