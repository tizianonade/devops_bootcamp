# Startup environement

1. Clone projects
2. Install packages with expected versions
3. Configuration of the environment

## Clone projects from remote repo

### **Maven project**

```Bash
git clone https://gitlab.com/nanuchi/java-maven-app
```
### **Gradle project**

```Bash
git clone https://gitlab.com/nanuchi/java-app
```
### **NodeJS project**

```Bash
git clone https://github.com/nanuchi/react-nodejs-example
```

## Environement configuration

### **OpenJDK - expected version: 15.0.2**

1. Create a path JAVA location folder

```Bash
mkdir -p /usr/lib/jvm/
``` 

2. Download the binary JDK file

```Bash
curl -o "openjdk-v15.0.2.tar.gz" "https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz"
``` 

3. Extract & replace the OpenJDK file to right path

```Bash
tar -xzvf openjdk-v15.0.2.tar.gz && sudo cp -r jdk-15.0.2 "java-15.0.2-openjdk" && sudo mv java-15.0.2-openjdk /usr/lib/jvm/ && sudo rm -r jdk-15.0.2 sudo rm openjdk-v15.0.2.tar.gz
``` 

4. Add the JAVA_HOME within as a Global environment variable

```Bash
echo -e '#!/bin/bash' > env_init.sh &&
echo 'echo "JAVA_HOME=\"/usr/lib/jvm/java-15.0.2-openjdk/\"" >> /etc/environment' >> env_init.sh && 
sudo chmod u+x env_init.sh && sudo bash env_init.sh && rm env_init.sh
```

5. Configure environment variables within the */usr/bin/* folder

```Bash
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-15.0.2-openjdk/bin/java" 1
```

```Bash
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/java-15.0.2-openjdk/bin/javac" 1
```

6. Test

```Bash
java --version && javac --version
```

## Maven - version 3.8.6

1. Download binary version

```Bash 
curl -o "maven-3.8.6.tar.gz" "https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz"
```

2. Move Folder to the right path

```Bash 
tar -xzvf maven-3.8.6.tar.gz && sudo mv apache-maven-3.8.6 /opt/ && rm maven-3.8.6.tar.gz
```

3. Update the environment variables

```Bash
echo '#!/bin/bash' > env_init.sh &&
echo 'echo -e "\nM2_HOME=\"/opt/apache-maven-3.6.3\"" >> ~/.profile' >> env_init.sh &&
echo 'echo -n "PATH=\"$M2_HOME/bin:" >> ~/.profile' >> env_init.sh && 
echo 'echo -n "$" >> ~/.profile' >> env_init.sh &&
echo 'echo "PATH\"" >> ~/.profile' >> env_init.sh &&
echo 'echo "export PATH" >> ~/.profile' >> env_init.sh &&
sudo chmod u+x env_init.sh && bash env_init.sh && rm env_init.sh && source ~/.profile 
```

4. Test

```Bash
mvn --version
```
## Node 10.17.0 - NPM 7.11.1 using NVM

### *NVM installation*

```Bash
sudo apt update && sudo apt install curl
```

```Bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
```
***Reload terminal***

### *Node installation*

```Bash
nvm install 10.17.0
```
### *NPM installation*

```Bash
npm install -g npm@7.11.1
```

npm install -g npm@5.6.0
> npm is already installed

