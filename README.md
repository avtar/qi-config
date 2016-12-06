This repository contains content that lets a Quality Infrastructure CI server configure jobs using simple [.qi.yml](https://github.com/amatas/vagrant-vmenv/blob/master/qi.yml.template) YAML configuration files in project repositories. The configuration file is used to automatically set up virtual machines managed by Vagrant to carry out CI workloads.

## Getting Started

* Add a [.qi.yml configuration file](https://github.com/amatas/vagrant-vmenv/blob/master/qi.yml.template) in your repository.

* Set up the 'Jenkins (GitHub plugin)' service in your repository (the URL will most likely be https://github.com/<user name>/<repo name>/settings/hooks/new?service=jenkins) and enter the following webhook URL:
```
http://i-0044.tor1.inclusivedesign.ca/github-webhook/
```
* Provide a URL for your .qi.yml file. It will get added and confirmation will be provided.

* Push any change to your repository to start a build. Every git branch will be monitored for activity and built. Branches without .qi.yml configuration files will not have their jobs executed.

* Optionally (but recommended) download a [Vagrantfile](https://github.com/amatas/vagrant-vmenv/blob/master/Vagrantfile.template), save it as ``Vagrantfile``, and test the provisioning process locally by typing ``vagrant up`` and then ``vagrant provision``.
