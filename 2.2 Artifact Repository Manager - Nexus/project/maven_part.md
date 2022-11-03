# Exercises - Context

You and other teams in 2 different projects in your company see at some point, that they have manydifferent small projects, the NodeJS application you built in the previous step, the java-gradle helperapplication and so on. So you discuss and decide it will be good to be able to keep all these appartifacts in 1 place, where each team can keep their app artifacts and can access them when they need.

So they ask you to setup Nexus in the company and create repositories for 2 different projects.

# Exercise 1 - Installation and configuration of Nexus on DigitalOcean droplet 

> Installation and configuration of Nexus on DigitalOcean droplet 
> -> see: nexus_on_cloud.md

# Exercise 5 - Create maven hosted repository associated with the blob store

1. Create a new maven hosted repo
    - Recipe: maven hosted 
    - blob: blob-1
    - name: npmProjectTeam2

# Exercise 6 - Create new user associated with maven repo created

1. Create a new role
    - type: nexus role
    - role id: team-p2
    - role name: Team p2
    - role description: manage maven repo
    - privileges: nx-repository-view-maven2-mavenProjectTeam2-*
2. Create new user
    - id: thomas_02
    - first name: Thomas
    - last name: Shan
    - email: thomas.shan@company.com
    - status: active
    - roles: Team project 2

# Exercise 7 - Build and publish jar file using Gradle

1. Clone repo

```Bash
git clone https://gitlab.com/devops-bootcamp3/java-gradle-app.git
```

2. Modify name of project 

> java-gradle-app/settings.gradle

```Bash
rootProject.name = 'my-app'
```
3. Create a new file and add key value pair 

> java-gradle-app/gradle.properties

```Bash
repoUser = thomas01
repoPassword = thomaspasswd
```

4. Add new dependencies to build

```Bash
apply plugin: 'maven-publish'

publishing {
    publications {
        maven(MavenPublication) {
            artifact("build/libs/my-app-$version"+".jar") {
                extension 'jar'
            }
        }
    }

    repositories{
        maven {
            name 'nexus'
            url "http://127.0.0.1:8081/repository/mavenProjectTeam2/"
            credentials {
                username project.repoUser
                password project.repoPassword
            }
        }
    }
}
```

5. Build

```Bash
./gradlew build
```

6. Publish

```Bash
./gradlew publish
```

> If this error occurs:
> > Repository version policy: RELEASE does not allow metadata in path: com/example/my-app/1.0-SNAPSHOT/maven-metadata.xml
> Solution:
> > Replace "version '1.0-SNAPSHOT'" with "'version '1.0-RELEASE'" within the build.gradle file
