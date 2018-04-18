[![Build Status](https://travis-ci.org/SoftwareAG/sagdevops-hello-docker.svg?branch=master)](https://travis-ci.org/SoftwareAG/sagdevops-hello-docker)

# Command Central Docker images

## Configuration

Login to Docker Store with your Docker ID, open https://store.docker.com/images/softwareag-commandcentral and accept license agreement to get access
to Command Central images.

Login to Docker with your Docker ID from your console and verify you can download the images:

```bash
docker login
docker pull store/softwareag/commandcentral:10.2-server
```

## Starting a default Command Central server

Create a Docker network for the components to communicate

```bash
docker network create ccnetwork
```

You can start new Command Central server by running the container:

```bash
docker run --name cc -d -p 8091 --network ccnetwork store/softwareag/commandcentral:10.2-server
```

Run ```docker port cc``` command to find out its published port

```bash
8091/tcp -> 0.0.0.0:32769
```

This will start an empty Command Central with the HTTPS port exposed.

To check the Command Central container logs run ```docker logs cc```.
The output should look similiar to this:

```bash
2018/04/17 23:00:42 INFO  #      Command Central version: 10.2.0.0001-0195
```

Open published port in the browser, for example https://0.0.0.0:32769/
to see Command Central login page.

Login with default credentials as Administrator/manage.

NOTE it will take up to a minute for the server to start accepting HTTP requests.

## Registering an existing Software AG installation

You can connect any 9.x or 10.x Software AG installation that has a running Software AG Platform Manager (SPM).

Simply point to running SPM host:port:

```bash
docker exec cc sagcc add landscape nodes alias=mynode1 url=http://IP:8092 -e OK
```

Successfull registration will report ```200 OK```

Command Central Web UI will show this managed node under Installations tab with all discovered managed instances under Instances tab.

## Launching a new empty Software AG installation

For development or testing purposes you can launch an empty Software AG managed installation.

Run Command Central node container on the 'ccnetwork' network:

```bash
docker run --name n102 -d -P --network ccnetwork store/softwareag/commandcentral:10.2-node
```

By default node container will auto register itself with Command Central using
container's internal id.

After a minute or so the managed node status will change to green (ONLINE).

NOTE that you can add launch and register older versions of Softwarte AG managed installation
for which a corresponding docker image is available. For example

```bash
docker run --name n101 -d -P --network ccnetwork store/softwareag/commandcentral:10.1-node
```

## Create custom Command Central image

You can tune up certain aspects of Command Central by modifying its configuration files and creating a custom image with the changes.

For example, you can optimize Command Central for template development or CI process by instructing Command Central to skip restart
of runtimes at the end of composite template application, register repositories and license files:

```dockerfile
FROM store/softwareag/commandcentral:10.2-server
# skip runtimes restart
RUN echo com.softwareag.platform.management.client.template.composite.skip.restart.runtimes=true>>$SAG_HOME/profiles/CCE/configuration/config.ini
```

Build the image and run the container:

```bash
docker build -t my/ccserver:10.2 .
docker run --name mycc -d -p 8091 --network ccnetwork my/ccserver:10.2
```

Use it in your DEV/CI pipeline:

```bash
docker exec mycc sagcc exec composite templates apply mytemplate
```

## Using docker-compose files for dev and test environments

Run example init service from ```docker-compose.yml``` file:

```bash
export EMPOWER_USERNAME=you@company.com
export EMPOWER_PASSWORD=****
export CC_PASSWORD=****

docker-compose run --rm init
```

The init service will:

* Create and start Command Central container
* Create, start and register a test managed node
* Register master product and fix repositories with provided Empower credentials

When it's done running open [Command Central Web UI](https://0.0.0.0:8091)

## Configuring Command Central

You can automatically configure your Command Central with everything
you need to perform provisioning, migration and maintenace of your
Software AG landscape.

Please see [Command Central](https://github.com/SoftwareAG/sagdevops-cc-server) project Docker secion for details.

## Building Docker images using Command Central Builder

You can build custom images with Software AG software using
softwareag/commandcentral:10.2-builder image and Command Central templates.

Please see [Command Central Docker builder](https://github.com/SoftwareAG/sagdevops-cc-docker-builder) project.

_______________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
_______________
DISCLAIMER
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
