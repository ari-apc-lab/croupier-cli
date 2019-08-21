# Croupier CLI

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Orchestration CLI of Croupier Project, based on Cloudify CLI. Its goal is to provide an interface to interact with a remote Croupier instance. For more information, visit <http://docs.getcloudify.org/4.1.0/cli/overview/>.

> **Note**
>
> Originally developed under the H2020 project [Croupier](http://www.croupier.eu/): <https://github.com/ari-apc-lab/Croupier-CLI>

## Contents

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)
- [Legal disclaimer](#legal-disclaimer)

## Installation

Croupier-CLI offers a docker image to easily start using the command line. Besides it can be installed following [the docs](https://docs.cloudify.co/4.5.0/install_maintain/installation/installing-cli/).

At [Docker Hub](https://hub.docker.com/r/ariapclab/croupier-cli) you can find the latest build image to start using the CLI.

```console
# docker run -it --name cli -v <PATH>/croupier-resources:/cli/resources ari-apc-lab/croupier-cli -- bash
[root@ec71ada311d6 cli]# exit
# docker start -ai cli
[root@ec71ada311d6 cli]# exit
```

To build: `docker build -t ari-apc-lab/croupier-cli .`

## Usage

### Local mode

Orchestration CLI of Croupier Project, based on Cloudify CLI, allows you to execute your blueprints without connecting to the remote Croupier instance.

```bash
ID=BLUEPRINT_ID
cfy blueprints validate blueprint.yaml # Validate your blueprint
cfy init --install-plugins -b $ID \
    -i ../local-blueprint-inputs.yaml blueprint.yaml # Create a new local app instance
cfy executions start -b $ID install # Bootstrap the app instance
cfy executions start -b $ID run_jobs # Execute the app instance workflow
cfy executions start -b $ID uninstall # Revert the app instance
```

### Remote mode

To connect to a Croupier instance, run the following command with your user credentials and remote host or IP of the orchestrator. If you don’t have an orchestrator instance yet, follow [Croupier installation](#croupier-installation) first.

```bash
cfy profiles use [ORCHESTRATOR_IP] [--ssl] -t default_tenant -u [USER] -p [PASS]
cfy status
```

Once you are connected to Croupier, you can perform the usual Cloudify CLI workflow for install, run and uninstall your TOSCA based applications:

```bash
ID=MY_ID
cfy blueprints upload -b $ID blueprint.yaml # Upload the blueprint
cfy deployments create -b $ID \
    -i ../local-blueprint-inputs.yaml $ID # Create the app instance
cfy executions start -d $ID install # Bootstrap the app instance
cfy executions start -d $ID run_jobs # Execute the app instance workflow
cfy executions start -d $ID uninstall # Revert the app instance
cfy deployments delete $ID # Remove the app instance
cfy blueprints delete $ID # Remove the blueprint
```

You can find several examples and real applications in the [resources respository @ Github](https://github.com/ari-apc-lab/croupier-resources)

## License

Croupier is licensed under [Apache License, Version 2.0 (the License)](./LICENSE)

## Legal disclaimer

The open source software and source code are provide to you on an “AS IS” basis and Atos Spain SA disclaim any and all warranties and representations with respect to such software and related source code, whether express, implied, statutory or otherwise, including without limitation, any implied warranties of title, non-infringement, merchantability, satisfactory quality, accuracy or fitness for a particular purpose.

Atos Spain SA shall not be liable to make any corrections to the open source software or source code, or to provide any support or assistance with respect to it without any previously specify agreement.

Atos Spain SA disclaims any and all liability arising out of or in connection
with the use of this software and/or source code
