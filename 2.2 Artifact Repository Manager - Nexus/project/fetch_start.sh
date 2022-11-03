#!/bin/bash

#save the artifact details in a json file
curl -u jane01:janepasswd -X GET 'http://127.0.0.1:8081/service/rest/v1/components?repository=npmProjectTeam1&sort=1.0.0' | jq "." > artifact.json

#grab the download url from the saved artifact details using ‘jq’json processor tool 
artifactDownloadUrl=$(jq .items[].assets[].downloadUrl artifact.json --raw-output) 

#fetch the artifact with the extracted download url using ‘wget’tool 
wget --http-user={jane01} --http-password={janepasswd} $artifactDownloadUrl

#Untar
tar -xzvf bootcamp-node-project-1.0.0.tgz && cd package

#Install dependencies
npm install

#Run 
npm start