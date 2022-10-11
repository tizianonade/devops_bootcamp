# Git-Cheat-Sheet
Cheet Sheet of Git commands

# GIT Cheat Sheet

## Installation 

```Bash
sudo apt-get update && sudo apt-get install -y git && git --version
```

## Configuration

```bash
git config --global user.name "username"
```

```bash
git config --global user.email "email"
```

```bash
git config --global color.ui true
```

```bash
git config --list
```

***To rebase branches at each pull requests***

```bash
git config --global branch.autosetuprebase always
```

## Tips - UNGIT on Windows

> install  nodejs version > 12 : https://nodejs.org/en/ - https://github.com/FredrikNoren/ungit

```bash
npm install -g ungit
```

***The following command is executable within the git repo***

```bash
ungit
```

## SSH Configuration

```bash
ssh-keygen
```
> Type ***Enter*** to choose RSA & the default folder where keys are stored

> Enter a passphrase

> Show and select the Public key located in the default folder and store it within settings of Gitlab/Github repository

> git clone with SSH


## Switch to main 

***Sometimes, the default branch is "Master" but this branch doesn't exist anymore, therefore switch to the "main" branch must me be necessary***

```bash
git switch -c main
```

## Status

```bash
git status
```

## Add files to the stage

```bash
git add nameOfFile
```

### Add all files

```bash
git add .
```

### Add all files by extension

```bash
git add ".py"
```

## Commits files on stage

```bash
git commit -m "message"
```

## Git ignore

### Create .gitignore file
```bash
touch .gitignore
```

### Example of content of the ..gitignore file

```bash
*.tmp
log.txt
tmp/*
```

## Logs - list of commits

```bash
git log
```
### The last 2 commits

```bash
git log -n 2 
```

### Get the list fast

```bash
git log --oneline
```

### The last commits of a specific file

```bash
git log -p readme.md
```

## Difference between commits

```bash
git diff
```

```bash
git log --online -p index.html
```

## See previous version

***It doesn't save previous modification after commit + checkout master!***

```bash
git checkout KEY
```

***It does save previous modification after commit + checkout master!***

```bash
git checkout key filename
```

## Go to Master branch

```bash
git checkout master
```

## Undo Commit without deleting commits in between

```bash
git revert KEY
```

## Branches

### Create a branch

```bash
git branch nameOfBranch
```

### Jump into a branch

```bash
git checkout nameOfBranch
```

### Come back to Master branch

```bash
git checkout master
```

### Fusion

```bash
git merge nameOfBranch 
```

### Delete branch

```bash
git branch -d nameOfBranch
```

## History

```bash
git add nameOfFile
```
***Set modification to the last commit***

```bash
git commit --amend 
```

***Add commits to master with the history of the branch***

```bash
git checkout nameOfBranch
git rebase master
```

## Remotes

### List of remote

```bash
git remote -v 
```
### Delete remote

```bash
git remote remove origin
```

### Add remote

```bash
git remote add origin SSH
```


### Push 

```bash
git push origin main
```

### List branches local

```bash
git branch -a 
```

### List branches online

```bash
git branch -r 
```

### Create a branch

```bash
git branch nameOfBranch
```

### Publish a branch

```bash
git push origin nameOfBranch
```

### Delete branch locally

```bash
git branch -d nameOfBranch
```

### Delete branch remotely

```bash
git push origin --delete nameOfBranch
```

```bash
git push origin main
```

### Pull

```bash
git pull origin main
```

### Pull with rebase

```bash
git pull --rebase origin 
```

### Clone everything

```bash
git clone ...git
```