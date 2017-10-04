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

## Python2.7
apt-get -y -q install python python-pip
pip install --upgrade pip
pip install virtualenv

## Cloudify CLI
#wget -q http://repository.cloudifysource.org/cloudify/17.3.31/release/cloudify_17.3.31~community_amd64.deb
#wget -q http://repository.cloudifysource.org/cloudify/17.6.30/community-release/cloudify-community-cli-17.6.30.deb
wget -q http://repository.cloudifysource.org/cloudify/17.9.21/community-release/cloudify-cli-community-17.9.21.deb
dpkg -i cloudify-cli-community-*.deb
rm cloudify-cli-community-*.deb

#chown -R ubuntu:ubuntu /opt/cfy/cloudify-manager-blueprints
#chmod +x /home/ubuntu/bootstrap-manager.sh

## ssh localhost
#1. ssh-keygen -t rsa
#Press enter for each line 
#2. cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#3. chmod og-wx ~/.ssh/authorized_keys 
