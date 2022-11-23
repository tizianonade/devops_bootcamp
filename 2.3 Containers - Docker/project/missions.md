# Context
Your team member has improved your previous static java application and added mysql database
connection, to let users edit information and save the edited data.
They ask you to configure and run the application with Mysql database on a server using docker-compose.

# Exercise 0: Clone Git repo and create your own

```Bash
git clone https://gitlab.com/devops-bootcamp3/bootcamp-java-mysql.git
```

# Exercise 1: Start MySQL container

> [Docker Hub](https://hub.docker.com/)

1. Pull MySQL image from docker hub

```Bash
docker pull mysql
```

2. Create environment variables

*Database config code of the Java application:*

```Java
@Configuration
public class DatabaseConfig {

    private String user = System.getenv("DB_USER");
    private String password = System.getenv("DB_PWD");
    private String serverName = System.getenv("DB_SERVER"); // db host name, like localhost without the port
    private String dbName = System.getenv("DB_NAME");
    private MysqlDataSource datasource = new MysqlDataSource();

    public DatabaseConfig() {
        datasource.setPassword(password);
        datasource.setUser(user);
        datasource.setServerName(serverName);
        datasource.setDatabaseName(dbName);
        //datasource.setPort(3306) default config
        //datasource.setURL("jdbc:mysql://localhost:3306/dbname");
    }
```

***Create Environment Variables***

Edit the ~/.bashrc and add the following commands at the end of the file

```Bash
export DB_SERVER=localhost
export DB_ROOT_PWD=root123
export DB_NAME=db_java_app
export DB_USER=john
export DB_PWD=john123
```

3. Create a network

```Bash
docker network create mysql_network
```

3. Create a mysql container (Data persistence)

```Bash
docker run \
    -p 3306:3306 \
    -v mysql_volume:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=$DB_ROOT_PWD \
    -e MYSQL_DATABASE=$DB_NAME \
    -e MYSQL_USER=$DB_USER \
    -e MYSQL_PASSWORD=$DB_PWD \
    -d \
    --name=mysql \
    --network=mysql_network \
    mysql:latest
```

***Volume must be deleted when the container is***

```Bash
sudo rm -r /var/lib/docker/volumes/<volume name>
```

4. Java installation

***Install OpenJDK 8***

```Bash
sudo apt install openjdk-8-jdk
```

5. Build the app

```Bash
./gradlew build
```

6. Launch the app

```Bash
java -jar build/libs/bootcamp-java-mysql-project-1.0-SNAPSHOT.jar
```

7. Browse

```Bash
http://localhost:8080
```

# Exercise 2 - Download phpmyadmin image and create a container

1. Download the image

```Bash
docker pull phpmyadmin
```

2. Create the container
```Bash
docker run \
    -p 9000:80 \
    -e PMA_HOST=mysql \
    -d \
    --name=pma  \
    --network=mysql_network \
    phpmyadmin:latest
```

3. Browse
```Bash
http://localhost:9000
```

# Exercise 3: Create mysql & PMA container with Docker Compose

```Bash
docker compose -f mysql.yaml up
```

# Exercise 4: Dockerize your Java Application

> Cf Dockerfile
> We should replace the share the new hostname of the DB_SERVER global environment which is not "localhost" anymore but it is the name of the container, "mysql" in our case

**Build the image**
```Bash
docker build -t java_app:1.0 --build-arg USERNAME=john --build-arg DATABASE=db_java_app --build-arg HOSTNAME=mysql --build-arg PASSWORD=john123 .
```

**Run the container with terminal**
```Bash
docker run -it --name app --network mysql_network -p 8080:8080 java_app:1.0 /bin/sh
```

**Build the container in daemon mode**
```Bash
docker run -d --name app --network mysql_network -p 8080:8080 java_app:1.0
```

**With Docker Compose**
```Bash
docker compose -f app.yaml up
``` 

# Exercise 5: Build and push Java Application Docker Image

**On Nexus UI:**

1. Create a new Blob store
    - type: File
    - name: blob-java
    - path: /opt/sonatype-work/nexus3/blobs/blob-java

2. Create a Docker hosted repository on Nexus
    - Recipe: docker hosted
    - blob: blob-java
    - name: javaAppRepo

3. Create a new role for Developers on Nexus
    - type: nexus role
    - role id: team-dev
    - role name: Developer team
    - role description: Push/Pull Docker images of Java App
    - privileges: nx-repository-view-docker-javaAppRepo-*

4. Create a new user for team-dev role
    - id: john_01
    - first name: John
    - last name: Doe
    - email: john.doe@company.com
    - password: dp
    - status: active
    - roles: Developer team

5.  Docker Hosted configuration

**Configuration to execute docker login with a nexus user successfully**

Docker client cannot connect to a Path which represent the docker hosted repository

The end points we can use for a Docker login is an IP address and a port,
but not default port *8081* where Nexus itself is running, so we need a port to access to the docker hosted repository specifically

    - On Nexus UI go to the docker hosted repo
    - Click on HTTP and type: 8083
    - Save changes

**To check whether the port 8083 is open or not**
```Bash
netstat -lnpt
```

6. Configuration on Digital Ocean 
    - Type: custom
    - port: 8083

7. Configuration of Realm on Nexus UI

When the **docker login** command is executed, we receive a token of authentication from Nexus's docker repository for a client and that token will be stored on our local machine, in a file called **~/.docker/config.json**. This file will include all authentions that we are made on different docker repositories. This file is only generated when the first docker authentication is made.

    - Go Realm Section
    - Active: Docker Bearer Token Realm

8. Configuration of Docker

By default Docker only allows clients requests whenever we execute a docker command (like docker push, login,pull...), all these commands to talk to a HTTPS end point, a secure end point of a docker registry. As we haven't configured a secure registry, in our case we use (HTTP). So we need to configure docker client to allow our docker hosted repository as un unsecure registry.

-   Edit /etc/docker/daemon.json

```JSON
{
        "insecure-registries": ["<NEXUS IP ADDRESS>:<REGISTRY PORT>"]
}
```

- Restart Docker daemon

```Bash
sudo systemctl restart docker
```

9. docker login

```Bash
docker login <NEXUS IP ADDRESS>:<DOCKER REPO PORT>
```

10. Push the image

    - Build the image

```Bash
docker build -t java_app:1.0 --build-arg USERNAME=john --build-arg DATABASE=db_java_app --build-arg HOSTNAME=mysql --build-arg PASSWORD=john123 .
```

    - Retag the image
To include the address to the name of the repository itself

```Bash
docker push <NEXUS IP ADDRESS>:<PORT DOCKER REPO>/java_app:1.0
```
    - Push docker image

```Bash
docker push <NEXUS IP ADDRESS>:<PORT DOCKER REPO>/java_app:1.0
```

11. Fetch docker image

```Bash
curl -u john:password -X GET 'http://127.0.0.1:8081/service/rest/v1/components?repository=javaAppRepo'
```