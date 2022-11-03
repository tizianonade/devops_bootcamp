# Advanced part

# Exercise 8 Download from Nexus and start application

1. Create a new user that has access to both repo (npm & maven)
    - id: jane
    - first name: Jane
    - last name: Smith
    - email: jane.smith@company.com
    - status: active
    - roles: Team project 1 - Team project 2

2. Fetch the download URL info for the latest NodeJS app artifact

2.1 Retrieve all repositories

```Bash
 curl -u jane01:janepasswd -X GET 'http://127.0.0.1:8081/service/rest/v1/repositories'
```

2.2 Retrieve all info related to NodeJS artifact

```Bash
 curl -u jane01:janepasswd -X GET 'http://127.0.0.1:8081/service/rest/v1/components?repository=npmProjectTeam1'
```

2.3 Retrieve only one component with all his assets

```Bash
 curl -u jane01:janepasswd -X GET 'http://127.0.0.1:8081/service/rest/v1/components/<component_id>'
```

3. Fetch the artifact 

```Bash
curl -o 'bootcamp-node-project-1.0.0.tgz' 'http://127.0.0.1:8081/repository/npmProjectTeam1/bootcamp-node-project/-/bootcamp-node-project-1.0.0.tgz'
```

4. Untar & launch

```Bash
tar -xzvf bootcamp-node-project-1.0.0.tgz
```

```
cd package/ && npm install && npm start

```

# Exercise 9 - Automate

***Json processor command***

```Bash
sudo apt install jq
```

curl -u {user}:{password} -X GET ‘http://{nexus-ip}:8081/service/rest/v1/components?repository={node-repo}&sort=version’ | jq “.” > artifact.json 

curl -u jane01:janepasswd -X GET 'http://127.0.0.1:8081/service/rest/v1/components?repository=npmProjectTeam1&sort=1.0.0' | jq "." > artifact.json

#grab the download url from the saved artifact details using ‘jq’json processor tool 

artifactDownloadUrl=$(jq‘.items[].assets[].downloadUrl’ artifact.json --raw-output) 

#fetch the artifact with the extracted download url using ‘wget’tool 

wget --http-user={user} --http-password={password}$artifactDownloadUrl