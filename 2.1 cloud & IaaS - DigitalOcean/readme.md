# Cloud & IaaS - DigitalOcean

# First steps

1. Sign up
2. Create a new project
3. Create a new Droplet
    - Select Frankfurt region - FRA1 - Datacenter 1
    - VPC Network default-fra1
    - OS: ubuntu 22.04
    - Droplet Type: Shared CPU Basic
    - CPU options: Regular SSD
    - Minimal ressource is enough for the demo
    - Add public SSH Key
4. Configure the server
    - Create a firewall
        - Add a new Inbound rules
            - Allow SSH port 22
            - Accept only your punblic IP address (Becareful restarting your router)
5. Test SSH
    - ssh root@<Public IP address of the server>

# Add a new user & configure ssh connection

```Bash
useradd -m <Name of new user> && usermod <Name of new user> --shell /bin/bash && usermod -aG sudo <Name of new user> && passwd
```

```Bash
su - <Name of new user>
```

```Bash
mkdir -p /home/<Name of new user>/.ssh/authorized_keys
```

> Copy the public IP address of your local machine to the authorized_keys file


```Bash
ssh <Name of new user>@<Public IP address of the droptlet>
```

# JAVA installation for specific Nexus version

```Bash
sudo apt update  && sudo apt install openjdk-8-jre-headless
```

# Deploy and Run application artifact on Droplet

1. Clone a repo locally

```Bash
git clone https://github.com/nanuchi/java-react-example
```

2. Build the app with Gradle

```Bash
java-react-example/./gradlew build
```

3. Send the artificat to the server

```Bash
scp java-react-example/build/libs/java-react-example.jar user@<Public IP address of the server>:/home/user/ 
```

4. Execute the app

```Bash
java -jar java-react-example.jar
```

*Run on the attach mode*

```Bash
java -jar java-react-example.jar
```

5. Open the port on which the app is running

> Inbound rule: CUSTOM - TCP - PORT 7071 - FROM ALL SOURCES

6. Test the app

> <Public IP address of the server>:7071

7. Make sure the app is running

```Bash
ps aux | grep java
```

```Bash
sudo apt update && sudo apt install net-tools
```

```Bash
netstat -lpnt
```
 
