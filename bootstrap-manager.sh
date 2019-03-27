#!/bin/bash

########
# Copyright (c) 2019 Atos Spain SA. All rights reserved.
#
# This file is part of Croupier.
#
# Croupier is free software: you can redistribute it and/or modify it
# under the terms of the Apache License, Version 2.0 (the License) License.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT ANY WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT, IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
# OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# See README file for full disclaimer information and LICENSE file for full
# license information in the project root.
#
# @author: Javier Carnero
#          Atos Research & Innovation, Atos Spain S.A.
#          e-mail: javier.carnero@atos.net
#
# bootstrap-manager.sh


if [[ $# < 4 ]] ; then
    echo 'Usage: '$0' <ORCHESTRATOR_HOST> <ORCHESTRATOR_SSH_USER> <ADMIN_USER> <ADMIN_PASSWD>'
    exit 1
fi

## SSH Keys management
./check-ssh-keys.sh

ssh-keygen -R $1
ssh-keyscan -H $1 >> ~/.ssh/known_hosts
ssh-copy-id -i ~/.ssh/id_rsa $2@$1

## Firewall config
ssh $2@$1 <<'ENDSSH'
    sudo firewall-cmd --zone=public --add-service=http
    sudo firewall-cmd --zone=public --permanent --add-service=http
    sudo firewall-cmd --zone=public --add-service=https
    sudo firewall-cmd --zone=public --permanent --add-service=https
    sudo firewall-cmd --zone=public --add-port=5671/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=5671/tcp
    sudo firewall-cmd --zone=public --add-port=53229/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=53229/tcp
    sudo firewall-cmd --zone=public --add-port=53333/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=53333/tcp
ENDSSH

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
