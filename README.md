This repository contains content that lets a Jenkins server configure jobs using simple YAML configuration files in project repositories.

## Getting Started

* Add a .qi.yml configuration file in your repository (link to documentation)

* Set up the 'Jenkins (GitHub plugin)' service in your repository (the URL will most likely be https://github.com/<user name>/<repo name>/settings/hooks/new?service=jenkins) and enter the following webhook URL:

http://i-0044.tor1.inclusivedesign.ca/github-webhook/

* Provide a URL for your .qi.yml file. It will get added and confirmation will be provided.

* Push any change to your repository to start a build

* Optionally (but recommended) download a [Vagrantfile](https://gist.githubusercontent.com/avtar/3279c7f972ba8c1ca8d19638cde3c746/raw/dcd6401b3880c756966009c0290a5bee5b079bc2/Vagrantfile) and test the provisioning process locally by typing ``vagrant up``

## QI Config Format

The configuration file uses a simple YAML format. The following is an example for the GPII Nexus project:

```
# This string is used to identify each job on the CI server
app_name: nexus

git_repository: https://github.com/avtar/nexus.git

# List any git branches hre that need to be built
git_branches:
  - qi-test

# An email address used to notify 
email: agill@ocadu.ca

# Two runtimes are available. 'linux' provides a headless Centos 7 Vagrant box and 'linux-desktop' provides a Gnome 3 Fedora box containing Chrome and Firefox.
env_runtime: linux

app_tcp_port: 9081

app_start_script: nexus.js

# If your project does not have a service that should be started 
app_start_service: true

software_stack: nodejs

software_stack_version: 4.3.1

setup:
  - sudo yum -y install curl
  - sudo npm install -g wscat
  - npm install

commands:
  - node /home/vagrant/sync/tests/all-tests.js
```

