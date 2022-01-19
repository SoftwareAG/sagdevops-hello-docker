<!-- Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

   SPDX-License-Identifier: Apache-2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and

     limitations under the License.                                                  

-->

[![Build Status](https://travis-ci.org/SoftwareAG/sagdevops-hello-docker.svg)](https://travis-ci.org/SoftwareAG/sagdevops-hello-docker)

# Command Central Docker images

## Create subscription on Docker Store

* Login to [Docker Store](https://store.docker.com) with your Docker ID
* Open [Command Central product](https://store.docker.com/images/softwareag-commandcentral)
* `Checkout`, accept the license agreement to get access to Command Central images

## Preparation

Login to Docker with your Docker ID on the target machine and verify you can download the images
from the Docker Store:

```bash
docker login
docker pull store/softwareag/commandcentral-client:10.3
```

## Using docker-compose to stand up basic dev or test environment

> IMPORTANT: Empower SDC credentials are required to register product and fix repositories

Run example init service from [docker-compose.yml](docker-compose.yml) file:

On Linux, Mac

```bash
export EMPOWER_USR=you@company.com
export EMPOWER_PSW=****
export CC_PASSWORD=****

docker-compose run --rm init
...
INIT SUCCESSFUL
```

On Windows:

```shell
set EMPOWER_USR=you@company.com
set EMPOWER_PSW=****
set CC_PASSWORD=****

docker-compose run --rm init
...
INIT SUCCESSFUL
```

The above command will:

* Create and start Command Central container
* Create, start and register a test managed node as `node1` alias
* Register master `products` and `fixes` repositories using provided Empower credentials
* Verify `node1` and repositories are registed and accessible

> NOTE: Command Central container (`cc` service) performs all the initialization on its own. The `init` service is run for verification purpose only.

When the above command successfully completes, open [Command Central Web UI](https://0.0.0.0:8091)
and login as Administrator and `CC_PASSWORD`.

## Persistance

Command Central container uses named volumes for persisting data and configuration. You can list the created volumes
using `docker volume ls` command:

```bash
docker volume ls
DRIVER              VOLUME NAME
local               sagdevops-cc-server_cce_conf
local               sagdevops-cc-server_cce_data
local               sagdevops-cc-server_spm_conf
local               sagdevops-cc-server_spm_data
```

Any changes you make within Command Central container are peristed in these volumes.
The containers can be completely destroyed, recreated, upgraded and the configuration and data will be preserved.

## Troubleshooting

1. Check status of the containers by running `docker-compose ps` command

If `cc` service has exited with exit code 100, this means the initialization of the Command Central container has failed

2. Check the Command Central container logs by running `docker-compose logs cc` command.

If the failed initialization refers to repository connectivity error, double check that you provided valid Empower credentials
using `EMPOWER_USR` and `EMPOWER_PSW`

## Developing templates and Dockerizing your applications

Please see [Software AG DevOps Templates](https://github.com/SoftwareAG/sagdevops-templates) project
for details on how use default Command Central templates for template-based provisioning, customize them
and create your own templates, as well as build default and custom Docker images for your applications.

_______________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
_______________
For more information you can Ask a Question in the [TECHcommunity Forums](https://tech.forums.softwareag.com/tags/c/forum/1/Command-Central).

You can find additional information in the [Software AG TECHcommunity](https://tech.forums.softwareag.com/tag/command-central).
_______________

These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
