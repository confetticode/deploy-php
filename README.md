Deploy PHP

### Tested OS Types

- Ubuntu 22.04 LTS

### Installation

1. Security setup
    - Create a new sudo user
    - Configure SSH
    - Install fail2ban
    
2. Install Nginx
3. Install PHP
4. Install Database (if required)
5. Install Redis (if needed)
6. Install Supervisor (if needed)

### Usage

Imagine, "script/test.sh" on your local machine, you can execute it as "root" on a remote server.

```bash
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa -p 22 root@192.168.33.11 'sudo bash -s' < scripts/test.sh
```
