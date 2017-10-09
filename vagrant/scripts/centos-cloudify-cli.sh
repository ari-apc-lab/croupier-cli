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
yum -y install epel-release
yum -y install python-pip
pip install --upgrade pip
pip install virtualenv

## Cloudify CLI 17.3.1
#wget -q http://repository.cloudifysource.org/cloudify/17.3.31/release/cloudify_17.3.31~community_amd64.rpm

## Cloudify CLI 17.6.30
#wget -q http://repository.cloudifysource.org/cloudify/17.6.30/community-release/cloudify-community-cli-17.6.30.rpm

## Cloudify CLI 17.9.21
wget -q http://repository.cloudifysource.org/cloudify/17.9.21/community-release/cloudify-cli-community-17.9.21.rpm

## Install Cloudify CLI package
rpm -Uvh cloudify-*.rpm
rm cloudify-*.rpm
