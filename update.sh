#!/bin/bash -e

LOCK=/tmp/update_jenkins_jobs.lock
CONFIG_DIR=$(cat ./ansible/vars/main.yml  | shyaml get-value qi_config_temp_dir)

[ -f $LOCK ] &&
echo "Error: Found lock file!" &&
exit 1

touch $LOCK

ansible-playbook ./ansible/download_configs.yml

for config in ${CONFIG_DIR}/*.yml
do
    ansible-playbook --extra-vars "@${config}" ./ansible/generate_jjb_definitions.yml
done

jenkins-jobs --conf /etc/jenkins_job.ini update jenkins_jobs

rm $LOCK

exit 0
