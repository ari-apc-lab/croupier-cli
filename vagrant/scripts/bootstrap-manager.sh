#!/bin/bash

# Copyright 2017 MSO4SC - javier.carnero@atos.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [[ $# < 4 ]] ; then
    echo 'Usage: '$0' <ORCHESTRATOR_HOST> <ORCHESTRATOR_SSH_USER> <ADMIN_USER> <ADMIN_PASSWD>'
    exit 1
fi

./check-ssh-keys.sh

ssh-keygen -R $1
ssh-keyscan -H $1 >> ~/.ssh/known_hosts
ssh-copy-id -i ~/.ssh/id_rsa $2@$1

cd /opt/cfy/cloudify-manager-blueprints/
if [ -f simple-manager-blueprint-inputs.yaml.bak ]; then
    cp simple-manager-blueprint-inputs.yaml.bak simple-manager-blueprint-inputs.yaml
fi
cp simple-manager-blueprint-inputs.yaml simple-manager-blueprint-inputs.yaml.bak

sed -i -e "s|public_ip: ''|public_ip: '$1'|g" ./simple-manager-blueprint-inputs.yaml
sed -i -e "s|private_ip: ''|private_ip: '$1'|g" ./simple-manager-blueprint-inputs.yaml

sed -i -e "s|ssh_user: ''|ssh_user: '$2'|g" ./simple-manager-blueprint-inputs.yaml
sed -i -e "s|ssh_key_filename: ''|ssh_key_filename: '~/.ssh/id_rsa'|g" ./simple-manager-blueprint-inputs.yaml

sed -i -e "s|#agents_user: ubuntu|agents_user: ubuntu|g" ./simple-manager-blueprint-inputs.yaml
sed -i -e "s|#admin_username: 'admin'|admin_username: '$3'|g" ./simple-manager-blueprint-inputs.yaml
sed -i -e "s|#admin_password: ''|admin_password: '$4'|g" ./simple-manager-blueprint-inputs.yaml

cfy bootstrap simple-manager-blueprint.yaml -i simple-manager-blueprint-inputs.yaml
cfy status
