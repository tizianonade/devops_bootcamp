# Exercises for Module "Build Tools and Package Manager"

> **Context**: Your team wants to build out a small helper library in Java and ask you to take over the project.

## **0. Clone project and create own Git repository**

```Bash
mkdir project/ && git clone https://gitlab.com/devops-bootcamp3/java-gradle-app.git
```

## **1. Build jar artifact**

```Bash
project/java-gradle-app/.gradlew build
```
**An error occured during the build process!**

# **2. Run tests**

```Bash
./gradlew test
```
**Replace the following code with the code at line 22 of the file java-gradle-app/src/main/java/com/example/Application.java**

```Bash
boolean result = myApp.getCondition(true);
```

## **3. Clean and build App**

```Bash
./gradlew clean
```

```Bash
./gradlew build
```

> Location of Jar file: **java-gradle-app/build/libs/**

## **4. Start application**

```Bash
java -jar bootcamp-java-project-1.0-SNAPSHOT.jar
```

## **5. Start App with 2 Parameters**

**Add the following code to the java-gradle-app/src/main/java/com/example/Application.java file at line 16**

```Java
Logger log =LoggerFactory.getLogger(Application.class); 
        try { 
                String one =args[0]; String two = args[1]; 
                log.info("Application will startwith the parameters {} and {}", one, two); 
            } 
        catch (Exception e) {
            log.info("No parameters provided"); 
            }
```

**Rebuild**

```Bash
./gradlew build
```

**Launch the app with 2 parameters**

```Bash
java -jar bootcamp-java-project-1.0-SNAPSHOT.jar Hello world
```