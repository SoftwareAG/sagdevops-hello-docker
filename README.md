# Command Central Docker images

## Starting a default Command Central server

You can start new Command Central server by running the container:

```bash
docker run --name cc -d -p 8091 softwareag/commandcentral:10.1.0.1-server
```

Run ```docker port cc``` command to find out its published port

```bash
8091/tcp -> 0.0.0.0:32769
```

This will start up an empty Command Central with the HTTPS port exposed.
Open published port in the browser, for example https://0.0.0.0:32769/ 
to see Command Central login page

Default login credentials are Administrator/manage.

NOTE it will take up to a minute for the server to start accepting HTTP requests.

## Registering an existing Software AG installation

You can connect any 9.x or 10.x Software AG installation that has a running Software AG Platform Manager (SPM).

Simply point to SPM host:port by running:

```bash
docker exec cc sagcc add landscape nodes alias=mynode1 url=http://IP:8092 -e 200
```

If this is succesfull the output will be ```200 OK```

Your Command Central Web UI now shows this node under Installations and all
discovered managed instances under Instances tab.

## Launching a new empty Software AG installation

For development or testing purposes you can launch and empty Software AG managed installation.

Run Command Central node container with a link to 'cc' container

```bash
docker run --name n1 -d -P --link cc softwareag/commandcentral:10.1.0.1-node
```

By default node container will auto register itself with Command Central using
container's internal id.

Your Command Central Web UI now shows this new node under Installations but
it is OFFLINE because of UnknownHostException.
This is because Command Central container does 'see' node container as they do not share the same network.

Connect both containers to the same network:

```bash
docker network create
docker network connect cc cc
docker network connect cc n1
```

After a minute or the newly connected node change its status to green (ONLINE).

## Using compose files for defining complex dev and test environments

```bash
docker-compose run --rm init
```

When it's done running open [Command Central Web UI](https://0.0.0.0:8091)

Command Central will have two nodes:

* one auto-registered with container id as node alias
* second one registered with as 'test2'

After a minute or so they both will come online

Install, patch, configure and use Software AG software on these
test nodes. Recycle them when no longer needed:

```bash
docker-compose stop test1 test2
docker-compose rm test1 test2
```

## Configuring Command Central

You can automatically configure your Command Central with everything
you need to perform provisioning, migration and maintenace of your
Software AG landscape.

Please see [Command Central](https://github.com/SoftwareAG/sagdevops-cc-server) project Docker secion for details.

## Building Docker images usign Command Central Builder

You can build custom images with Softweare AG software using
```softwareag/commandcentral:10.1.0.1-builder``` image.

Please see [Command Central Docker builder]() project.

_______________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
_______________
DISCLAIMER
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.

