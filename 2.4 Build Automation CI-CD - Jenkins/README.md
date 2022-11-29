# Jenkins Docker installation on Digital Ocean

1. Droplet 
    - 4 GB / 2 CPU
    - 80 GB SSD
    - 4 TB transfer
    - Region Frankfurt
    - name: jenkins-server

2. Firewall
    - inbound rules:
        - ssh - 22 TCP
        - custom - 8080 
    - name: jenkins-firewall
    - droplet: jenkins-server

3. Docker installation
    - [Docker installation on Github](https://github.com/tizianoadv/devops_bootcamp/tree/main/2.3%20Containers%20-%20Docker)
