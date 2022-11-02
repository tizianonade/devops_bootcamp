# Initialisation of Digital Ocean Droplet

1. Requirement packages
2. Java installation 
3. Nexus installation
4. New user
5. Nexus configuration

## Requiremenets packages

```Bash
sudo apt update && sudo apt install net-tools
```
## Java

```Bash
sudo apt-cache search openjdk-8 | grep openjdk-8
```

```Bash
sudo apt install openjdk-8-jdk
```

## Nexus

```Bash
sudo wget -O "/opt/latest-unix.tar.gz" "https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
```

```Bash
sudo tar -zxvf /opt/latest-unix.tar.gz
``` 

## User
```Bash
sudo useradd nexus -d /home/nexus -m -s /bin/bash
```

```Bash
echo ""nexus":"password"" | sudo chpasswd
```

```Bash
sudo chown -R nexus:nexus nexus-3.42.0-01/ && sudo chown -R nexus:nexus sonatype-work/
```

## Nexus configuration and startup
```Bash
sudo vim nexus-3.42.0-01/bin/nexus.rc
run_as_user="nexus"
```

```Bash
su - nexus
```

```Bash
/opt/nexus-3.42.0-01/bin/nexus start
```

## Test

```Bash
ps aux | grep nexus && netstat -lnpt
```

> open port 8081 on DigitalOcean - inbound

> Browse!

## Access 

```Bash
cat /opt/sonatype-work/nexus3/admin.password
```
