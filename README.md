# Command Central basic Docker use for infrastructure testing

## Required tools

* [Docker engine](https://www.docker.com/products/overview)
  * [Docker toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/) for older Windows
* [Docker compose](https://docs.docker.com/compose/install/)

## Run Command Central container

```bash
docker-compose up -d cce
```
Open [Command Central Web UI](https://localhost:8091)

NOTE: if you use Toolbox, replace localhost with the docker VM IP address

Login as Administrator/manage

## Add empty landscape nodes

Add an empty managed node

```bash
docker-compose run --rm regn1
```

Check [Installations tab](https://localhost:8091/cce/web/#environment:ALL/t/1)
Registered n1 node will come online in about a minute or less

## Add database

Add Oracle database

```bash
docker-compose up -d db
```
Connection URL: ```jdbc:wm:oracle://localhost:1521;SID=xe```
DBA credentials: system/oracle


## All up

```bash
docker-compose up -d
docker-compose ps
```

## Cleanup

```bash
docker-compose down
```

_______________
DISCLAIMER
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
