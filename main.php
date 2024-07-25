<?php

use SendCode\DeployPHP\SecuritySetup;
use SendCode\DeployPHP\Server;

require __DIR__.'/vendor/autoload.php';

$server = new Server('vagrant', '192.168.33.11', 22, '~/.ssh/id_rsa');
$script = new SecuritySetup(
    $server, "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9pfLIllqDfz4xNkOuywjBAdG7K8wsWVcBtecUqn7p2dyZDpymi9GhSCTJCXGOCha1pTIlczeouj7LoCKUysxx+aVQt/ifg3rWfzxRLLmt2UpoK0GQFZFEnUH1JwlQR46tRJR5Hncop+80ZhEGvxRDOG+/gKKUbDAkB4w9ugrbmO/ooLmeM6gIpFy5YaoKgYLF3WU5nrr13cQkDMnvctWSlOVIrdmf3CFn0l6PubcMig41oxOJ33jD7qdbcUv7DquXNZABKGIvAyYgBpbkvjjJ1efGU5VBC4RK2SdXeAdPbc4YTm1iignRlQypHiXMuqovbeF2YcladiGSyXm+x12VZBnDWuA/Tc1/nrjVxa3FYC90vlmfZiwEVrlBAIsCTVu6cXtKVoUbYlvQQHAdFVQKbWdVC/C2xEJXwsSPWI6BVaPPF2tGjKxNrNgn1xuu9LhQda0Gwndy25+1Qp0C9uRCoejFcJq9uRcbqMwiik5aHuxP9AbuEhDs556cGE6ouDt1SOuurIv1uFQRwROdyHuQlecg79CDlUrUd7VLKhLg7pWJxhizGHPX4Pr0O1SfAzvEXmV9kzi/V6X1nBnQQkJsHcHPZ5ba/z3KkMIZ3uyWacl1HH44y/L6dj1ZZ6CDiIBG+fs2pVv3XTiP2AYDJsYjyEegJTBNsod9+yjNsTDNNw== Vito Vagrant"
);
$server->run();
