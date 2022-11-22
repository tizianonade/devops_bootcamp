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
Now you are done with testing the application locally with Mysql database and want to deploy it on theserver to make it accessible for others in the team, so they can edit information.
And since your DB and DB UI are running as docker containers, you want to make your app also run asa docker container. So you can all start them using 1 docker-compose file on the server. So you do thefollowing

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

```Bash
docker compose -f app.yaml up
``` 