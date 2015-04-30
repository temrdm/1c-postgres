# PostgreSQL for 1C Server

## Image

Image container at DockerHub [temrdm/1c_postgres](https://registry.hub.docker.com/u/temrdm/1c_postgres/)

## Usage

    FROM temrdm/1c_postgres:9.2-1C

## Manual build

Building postgres 9.2.4-1.1 1C version

### Dependency

Download from [users.v8.1c.ru](https://users.v8.1c.ru/distribution/project/AddCompPostgre) postgres deb package and extract it to ```./9.2-1С/dist``` path.

### Build

Building container

    docker build -t db ./9.2-1С

Create data volume container
  
    docker create -v /var/lib/postgresql/data --name dbdata db /bin/true

### Run
    
    docker run -d -p 5432:5432 --volumes-from dbdata --name db --restart=always db

### Shell

    docker run -i --volumes-from dbdata -t db /bin/bash
