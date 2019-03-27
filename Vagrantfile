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
# Vagrantfile


# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.network "private_network", ip: "192.168.56.10"
#  config.vm.network "forwarded_port", guest: 8000, host: 8000

  config.vm.synced_folder "../../croupier-resources", "/home/vagrant/resources"

  config.vm.provider "virtualbox" do |vb|
	# Not display the VirtualBox GUI when booting the machine
	vb.gui = false
	vb.cpus = 2
	# Customize the amount of memory on the VM:
	vb.memory = "4096"
	vb.customize ["modifyvm", :id, "--vram", "12"]
	# Set the timesync threshold to 1 second, instead of the default 20 minutes.
	vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000]
  end

  config.vm.provision "file", source: "./check-ssh-keys.sh", destination: "/home/vagrant/check-ssh-keys.sh"
  config.vm.provision "file", source: "./bootstrap-manager.sh", destination: "/home/vagrant/bootstrap-manager.sh"
  config.vm.provision "shell", path: "./centos-basic-deps.sh"
  config.vm.provision "shell", path: "./centos-python2.sh"
  config.vm.provision "shell", path: "./centos-cloudify-cli.sh"
  config.vm.provision "shell", path: "./vagrant-set-permissions.sh"

  #HACK TO AVOID ttyname failed: Inappropiate ioctl for device
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
end
