This repository contains content that lets a Quality Infrastructure CI server configure jobs using simple ``.qi.yml`` YAML configuration files in project repositories. The configuration file is used to automatically set up virtual machines managed by Vagrant to carry out CI workloads.

## Getting Started

* Add a .qi.yml configuration file in your repository (more details about the format can be found in the ``QI Config Format`` below).

* Set up the 'Jenkins (GitHub plugin)' service in your repository (the URL will most likely be https://github.com/<user name>/<repo name>/settings/hooks/new?service=jenkins) and enter the following webhook URL:

http://i-0044.tor1.inclusivedesign.ca/github-webhook/

* Provide a URL for your .qi.yml file. It will get added and confirmation will be provided.

* Push any change to your repository to start a build. Every git branch will be monitored for activity and built. Branches without .qi.yml configuration files will not have their jobs executed.

* Optionally (but recommended) download a [Vagrantfile](https://raw.githubusercontent.com/avtar/qi-config/master/files/Vagrantfile.linux), save it as ``Vagrantfile``, and test the provisioning process locally by typing ``vagrant up``.

## QI Config Format

The QI configuration file uses a simple YAML format. Each field is mandatory unless noted otherwise. Please also refer to an [example .qi.yml configuration](https://github.com/avtar/qi-config/blob/master/files/.qi.yml.example) provided for the GPII Nexus project.

* ``app_name`` - A string used to identify each job on the CI server. Please hyphenate multiple words, for example, 'gpii-nexus'.

* ``git_repository`` - Specify your project's GitHub repository. Every branch will be monitored for activity and built. If a ``.qi.yml`` configuration file is not part of a branch its jobs will not be executed. 

* ``email`` - Email address used to send notifications when CI jobs fail.

* ``env_runtime`` - Two environment runtimes are available: 
  * 'linux' provides a headless [Centos 7 Vagrant box](https://github.com/idi-ops/packer-centos)
  * 'linux-desktop' provides a [Gnome 3 Fedora Vagrant box](https://github.com/idi-ops/packer-fedora) containing Chrome and Firefox browsers

* ``app_tcp_port`` - The TCP port used by your application. If using Vagrant locally this port will also be used for port fowarding between your host operating system and the VM managed by Vagrant. 

* ``app_start_script`` - A script can be passed as an argument to software such as Node.js Providing a script here and setting ``app_start_service`` and ``app_tcp_port`` will enable a service to be started as part of the VM provisioning process.

* ``app_start_service`` - Setting this to ``true`` along with providing values for ``app_start_script`` and ``app_tcp_port`` will result in a daemonized process after the VM has finished starting up. Setting this to ``false`` will prevent this from happening.

* ``software_stack`` - The software stack to provision in the VM before job commands are executed. Currently ``nodejs`` is the only software stack that can be set up automatically in VMs. This README will be updated when that changes.

* ``software_stack_version`` - Specifying ``lts`` or ``current`` will install versions ``4.*`` and ``6.*`` respectively using [the IDI ansible-nodejs role](https://github.com/idi-ops/ansible-nodejs/).

* ``setup`` - A list of commands that will be run in sequence in the VM specified by ``env_runtime`` and relative to the directory containing the ``.qi.yml`` configuration file. Any failures here will prevent the CI job from proceeding further.

* ``commands`` - A list of commands that will also be run in sequence in the VM and relative to the location of the ``.qi.yml`` file but more verbose output will be made available compared to commands run by ``setup``. Unexpected issues here will also cause the job to fail.
