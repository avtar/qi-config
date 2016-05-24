This repository contains content that lets a Quality Infrastructure CI server configure jobs using simple ``.qi.yml`` YAML configuration files in project repositories. The configuration file is used to automatically set up virtual machines managed by Vagrant to carry out CI workloads.

## Getting Started

* Add a .qi.yml configuration file in your repository (more details about the format can be found in the ``QI Config Format`` below).

* Set up the 'Jenkins (GitHub plugin)' service in your repository (the URL will most likely be https://github.com/<user name>/<repo name>/settings/hooks/new?service=jenkins) and enter the following webhook URL:

http://i-0044.tor1.inclusivedesign.ca/github-webhook/

* Provide a URL for your .qi.yml file. It will get added and confirmation will be provided.

* Push any change to your repository to start a build.

* Optionally (but recommended) download a [Vagrantfile](https://raw.githubusercontent.com/avtar/qi-config/master/files/Vagrantfile.linux), save it as ``Vagrantfile``, and test the provisioning process locally by typing ``vagrant up``.

## QI Config Format

The QI configuration file uses a simple YAML format. An example for the GPII Nexus project is provided below. Each field is mandatory unless noted otherwise.

```
# This string is used to identify each job on the CI server. Please hyphenate multiple words, for example, 'gpii-nexus'.
app_name: nexus

# Specify your project's GitHub repository.
git_repository: https://github.com/avtar/nexus.git

# List any git branches here that need to be built.
git_branches:
  - qi-test

# An email address used to send notifications when CI jobs fail.
email: agill@ocadu.ca

# Two environment runtimes are available: 
#
# * 'linux' provides a headless [Centos 7 Vagrant box](https://github.com/idi-ops/packer-centos)
# * 'linux-desktop' provides a [Gnome 3 Fedora Vagrant box](https://github.com/idi-ops/packer-fedora) containing Chrome and Firefox browsers
env_runtime: linux

# Specify the TCP port used by your application. If using Vagrant locally this port will also be used for port fowarding between your host operating system and the VM managed by Vagrant. 
app_tcp_port: 9081

# A script can be passed as an argument to software such as Node.js Providing a script here and setting ``app_start_service`` below to ``true`` will enable a service to be started as part of the VM provisioning process.
app_start_script: nexus.js

# Setting this to ``true`` along with providing a value for ``app_start_service`` will result in a daemonized process after the VM has finished starting up. Setting this to ``false`` will prevent this from happening.
app_start_service: true

# Currently ``nodejs`` is the only software stack that can be set up automatically in VMs. This README will be updated when that changes.
software_stack: nodejs

# Using any Node.js version [supported by the IDI ansible-nodejs role](https://github.com/idi-ops/ansible-nodejs/blob/master/vars/RedHat.yml#L10-L60) are valid options here.
software_stack_version: 4.3.1

# These commands will be run in sequence in the VM specified by ``env_runtime`` and relative to the directory containing the ``.qi.yml`` configuration file. Any failures here will prevent the CI job from proceeding further.
setup:
  - sudo yum -y install curl
  - sudo npm install -g wscat
  - npm install

# Similarly these commands will also be run in sequence in the VM and relative to the location of the ``.qi.yml`` file but more verbose output will be made available compared to commands run by ``setup``. Unexpected issues here will also cause the job to fail.
commands:
  - node /home/vagrant/sync/tests/all-tests.js
```

