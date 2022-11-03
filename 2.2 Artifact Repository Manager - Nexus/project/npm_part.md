# Exercises - Context

You and other teams in 2 different projects in your company see at some point, that they have manydifferent small projects, the NodeJS application you built in the previous step, the java-gradle helperapplication and so on. So you discuss and decide it will be good to be able to keep all these appartifacts in 1 place, where each team can keep their app artifacts and can access them when they need.

So they ask you to setup Nexus in the company and create repositories for 2 different projects.

# Exercise 1 - Installation and configuration of Nexus on DigitalOcean droplet 

> Installation and configuration of Nexus on DigitalOcean droplet 
> -> see: nexus_on_cloud.md

# Exercise 2 - Create npm hosted repository & new blob store

1. Create a new Blob store
    - type: File
    - name: blob-1
    - path: /opt/sonatype-work/nexus3/blobs/blob-1
2. Create a new repo for the npm artifact
    - Recipe: npm hosted
    - blob: blob-1
    - name: npmProjectTeam1
3. Create a new user for team 1
    3.1 Create a new role
        - type: nexus role
        - role id: team-p1
        - role name: Team p1
        - role description: manage npm repo
        - privileges: nx-repository-view-npm-*-*
    3.2 Create a new user
        - id: paul_01
        - first name: Paul
        - last name: Apple
        - email :paul.apple@company.com
        - status: active
        - roles: Team project 1

# Exercise 3 - Build & publish npm tar

1. Clone a npm application from remote repo

```Bash
git clone https://gitlab.com/devops-bootcamp3/node-project.git
```

2. Install nvm (10.17.0) & npm (7.11.1)

```Bash
sudo apt update && sudo apt install curl 
```

```Bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
```

```Bash
nvm install 10.17.0 && npm install -g npm@7.11.1
```

> ***Reload window***

2. Install depedencies, test and build the app 

```Bash
cd /node-project/app 
```

```Bash
npm install
```

```Bash
npm test
```

```Bash
npm run
```

> Browse localhost:3000


```Bash
npm pack
```

3. Publish package to Nexus repo

> My case: 
> > npm-repo-url-in-nexus: http://localhost:8081/repository/npmProjectTeam1/
> > package-name: bootcamp-node-project-1.0.0.tgz

```Bash
npm login --registry=https://my.nexus.com/repository/npm-public/
```

> Username: paul_01
> Password: *********
> Email: paul.apple@company.com

```Bash
npm publish --registry="http://localhost:8081/repository/npmProjectTeam1/" bootcamp-node-project-1.0.0.tgz
```

