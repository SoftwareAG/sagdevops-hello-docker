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

[![Build Status](https://travis-ci.org/SoftwareAG/sagdevops-hello-docker.svg?branch=develop)](https://travis-ci.org/SoftwareAG/sagdevops-hello-docker)

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

## Using docker-compose to standup basic dev or test environment

> IMPORTANT: Empower SDC credentials are required to register product and fix repositories

Run example init service from [docker-compose.yml](docker-compose.yml) file:

```bash
export EMPOWER_USR=you@company.com
export EMPOWER_PSW=****
export CC_PASSWORD=****

docker-compose run --rm init
```

The above command will:

* Create and start Command Central container
* Create, start and register a test managed node as `node1` alias
* Register master `products` and `fixes` repositories using provided Empower credentials
* Verify `node1` and repositories are registed and accessible

When the above command successfully completes, open [Command Central Web UI](https://0.0.0.0:8091)
and login as Administrator and `CC_PASSWORD` that you used.

## Developing templates and Dockerizing your applications

Please see [Software AG DevOps Templates](https://github.com/SoftwareAG/sagdevops-templates) project
for details on how use default Command Central templates for template-based provisioning, customize them
and create your own templates, as well as build default and custom Docker images for your applications.

_______________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
_______________
DISCLAIMER
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
