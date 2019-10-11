### Minishift Demo
The purpose of this repo is to demonstrate how Minishift and OpenShift can be used to develop software in a local development environment. 

##  Install Minishift on local machine
* Install any hypervisor. Recommended [VirtualBox](https://www.virtualbox.org/wiki/Downloads) works for all OS.
* Download [latest Minishift](https://github.com/minishift/minishift/releases) for particular OS. For mac its minishift-1.34.1-darwin-amd64.tgz.
* Untar the downloaded file and copy the minishift file to /usr/local/bin folder.  
`sudo cp ~/Downloads/<expanded folder>/minishift /usr/local/bin`  
`sudo chmod +x /usr/local/bin/minishift`
* Use `minishift start --vm-driver virtualbox` to start minishift on top of VirtualBox.
* Use `minishift config set vm-driver virtualbox` to set minishift to permanently run on top of virtualbox.
`minishift status`

## Login into minishift
* To access openshift cluster using cli, oc command line tool installed with minishift. To configure the shell run following command: `eval $(minishift oc-env)`
* By default any non-empty user name and password can be used to login to the local cluster. The recommended user name and password is developer and developer, respectively.  
`oc login -u developer -p developer`   
* To login as system admin- `oc login -u system:admin`
* To see current login user `oc whoami`
* Use `oc status` to get the url for web console.
* Minishift, by default, comes with some security settings as addon. Its better to enable those addons to make it more relaxed.
`minishift addon list`  
`minishift addon enable admin-user` creates a user with cluster admin permissions.  
`minishift addon enable anyuid` allows you to login using any UID

## Create new project 
* Create new project called node-app.  
`oc new-project node-app`

## Creating an application from source code 
* Generate the Personal Access token of your private repo.  
`oc secret new-basicauth github-secret --username=<username> --prompt`
* When prompt for password enter PAT.
* Clone repository https://github.ibm.com/garghitesh/nodejs_openshift_minishift.git and use link of your repo. 
`oc new-app https://github.ibm.com/garghitesh/nodejs_openshift_minishift.git --context-dir=app --source-secret=github-secret`

## Create Route 
`oc get all`  
`oc expose svc/<serviceName>`

## Create application by using template
* Clone the repository to access the openshift folder which has all the yml files to create resources.

* Run the following command to create the node-app template.
`oc create -f Template.yml`  
* It will create the node-app template for everyone to directly create the application resources. To access this go to web console -> go to project node-app -> Add to project -> Browse Catalog. Under this you will see node-app template. Select the template -> next. Then it will ask for all the required field for application.

* Also we can create application directly from template file without first creating template and accessing that template to create application. To do so use following command:
`oc process -f Template.yaml -l app=node-app -p GITHUB_TOKEN=<token>`

## Create resources using template via cli
`oc get template use this to get the created template name`  
`oc new-app <template-name> -p GITHUB_TOKEN=<project-name> We can pass values to parameters using tag -p.`  
`oc get all to see all the resources created. You will see application url under route.`  

## Update repository to trigger new build(s2i) and deployment automatically.
To make call github hooks to your local environment, we use Ultrahook. With Ultrahook, github will be able to call your private endpoint.
Signup for free and create your unique namespace. For step by step guide: https://blog.openshift.com/using-github-hooks-with-your-local-openshift-environment/
After installing ultrahook and getting namespace, go to repository setting -> WebHooks & Services -> Add Webhook and add url as github.<your-namespace>.ultrahook.com.
From the terminal use oc describe <buildConfig-name> to get the Webhook GitHub: Url
Copy the url and run ultrahook github <copied-url>
Update the registered branch or push any change, build and deployment will trigger automatically.
  
## Basic troubleshooting commands
oc get events
oc logs <podname>
oc describe pod <podname>
oc status
oc projects
oc delete all --all
