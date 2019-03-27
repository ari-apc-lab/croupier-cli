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
# Dockerfile


FROM centos:7

LABEL maintainer="javier.carnero@atos.net"

RUN mkdir /cli
WORKDIR /cli

# Basic dependencies
RUN yum -y update
RUN yum -y install yum-utils wget openssh-clients ntp
RUN yum clean all

# Cloudify-cli
ADD ./centos-cloudify-cli.sh ./
RUN /bin/bash ./centos-cloudify-cli.sh
RUN rm ./centos-cloudify-cli.sh

# Bootstrap script
ADD ./bootstrap-manager.sh ./

# SSH Keys
RUN mkdir ~/.ssh
ADD check-ssh-keys.sh /
RUN chmod +x /check-ssh-keys.sh

# Set all scripts as executables
RUN chmod +x ./*.sh

# Shared volume
VOLUME ['/cli/resources']

ENTRYPOINT ["bash", "-c", "/check-ssh-keys.sh && exec $@"]
CMD ["bash"]

