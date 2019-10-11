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
