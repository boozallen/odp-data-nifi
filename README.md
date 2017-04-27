## Open Data Platform NiFi Component
This component provides a Docker-based NiFi container and processing templates as part of the Open Data Platform.

## Getting Started
To get started either pull the online container or build a container locally.

To pull the docker container:
```
docker pull boozallen/odp-data-nifi
```

To create the docker container:
```
docker build -t odp-data-nifi .
```

To run the container with shared host mounted directories to allow updating of scripts and in/out data directories:
```
docker run -d --name odp-nifi -p 8080:8080 -p 8081:8081 -v /tmp/in:/opt/data/in -v /tmp/out:/opt/data/out -v scripts:/opt/data/scripts odp-data-nifi
```

This allows you to access NIFI:
http://localhost:8080/nifi

To connect to the odp-nifi container in order to look at logging or other helpful debugging information:
```
docker exec -it odp-nifi bash
```

[Docker Compose](https://docs.docker.com/compose/install/) allows you to bring up multiple containers associated with the project.  You may have to pull/build the docker images to your local environment the first time this is run.  Make sure your environment has enough memory to have multiple contianers running.  This was tested with a VM and 12 MB allocated.

Bring the containers up initially in detached mode: `docker-compose up -d`

Stop all containers: `docker-compose stop`

Start containers: `docker-compose start`

Remove container instance files: `docker-compose rm -f`
