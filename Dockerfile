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
RUN yum -y install yum-utils wget openssh-clients ntp epel-release python python-pip zip
RUN yum clean all
RUN pip install -q wagon==0.6.1

# Cloudify-cli
RUN wget -q http://repository.cloudifysource.org/cloudify/19.07.18/community-release/cloudify-cli-community-19.07.18.rpm -O ./cfy.rpm
RUN rpm -Uvh cfy.rpm
RUN rm -f cfy.rpm

# Shared volume
VOLUME ['/cli/resources']

ENTRYPOINT ["bash", "-c", "exec $@"]
CMD ["bash"]

