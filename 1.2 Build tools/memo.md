# Memo

## ***Java backend app***

## Configuration files

1. Search for dependencies compatible with your code on remote repos
2. Add it to config file
3. Download it automatically by the tool

### **Gradle**
> Configuration file: **build.gradle**

### **Maven**
*Location of local repo maven 
.m2 file*
> Configuration file: **pom.xml**

## Install dependencies
### **Gradle**
```Bash
./gradlew build
```
### **Maven**
```Bash
mvn install
```

## Run the app using Java

```Bash
java -jar <name of jar file>
```

# ***Javascript backend app (NodeJS...)***

## **Build dependencies**

> Type of file: **.zip or .tar file**

> Tool: **npm or yarn**
> > - package managers but not build tools
> > - install dependencies
> > - NOT use to build an app like maven or gradle
> > - use their own repo to find modules & dependencies
> > - use the package.json file for dependencies

> Useful commands: 
> > - **npm install** - download packages
> > - **npm start** - start the app
> > - **npm stop** - stop the app
> > - **npm test** - run the tests
> > - **npm publish** - publish the artifact
> > - **npm pack** - create an artifact including the package.json file 

> Tips for deployment:
> > - Copy artifact & packages.json file to the server 
> > - Once build the package (zip/tar) file include the app itself but not dependencies
> > - Dependencies must be installed first on the server and then unpack zip/tar file and run the app using **npm run**



# ***Javascript backend & frontend app (NodeJS + React...)***

> Package frontend & backend separately or common package

> Both javascript frontend & backend
> > - need to be transpiled (used by browser)
> > - compressed/minified
> > - Build tool **Webpack**

> Best practice
> > same build & package management tools for frontend / backend

## **For app with react as frontend & java as backend**
> Best practice:
> > - Bundle frontend app with Webpack
> > - Manage dependencies with npm or yarn
> > - Package everything into a WAR file
