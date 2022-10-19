# Useful tips & configuration

## Homebrew package manager

> Execute the following command

```Bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

*Add the PATH*

```Bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## JDK installation - latest version

```Bash
sudo apt update && java --version 
```

```Bash
sudo apt install openjdk-18-jdk
```

### *JAVA_HOME enviroment variable configuration*

> To set this environment variable, first determine where Java is installed. Use the update-alternatives command:

```Bash
sudo update-alternatives --config java
```

> This command shows each installation of Java along with its installation path:

> In this case the installation paths are as follows:

    - OpenJDK 11 is located at: /usr/lib/jvm/java-18-openjdk-amd64/bin/java

***Add new path to JAVA_HOME***

```Bash
sudo vim /etc/environment
```

> Add This path at the end of the file

```Bash
JAVA_HOME="/usr/lib/jvm/java-18-openjdk-amd64/"
```

***Reload environment file***

```Bash
source /etc/environment
```

***Test***

```Bash
echo $JAVA_HOME
```

***Result***

> /usr/lib/jvm/java-18-openjdk-amd64/

