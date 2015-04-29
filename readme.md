# PostgreSQL for 1C Server

## Postgres 9.2.4-1.1 1C version

### Dependency

Download from [users.v8.1c.ru](https://users.v8.1c.ru/distribution/version_file?nick=AddCompPostgre&ver=9.2.4-1.1C&path=AddCompPostgre\9_2_4_1_1S\postgresql_9_2_4_1_1C_amd64_deb_tar.bz2) postgres deb package and extract it to ```./9.2-1С/dist``` path.

### Build

Building container

    docker build -t db ./9.2-1С

Create data volume container
  
    docker create -v /var/lib/postgresql/data --name dbdata db /bin/true

### Run

    docker run -d -p 5432:5432 --volumes-from dbdata db

