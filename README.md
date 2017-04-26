## Intent
Develop a converged open data platform that can be rapidly deployed and tailored to meet client needs and accelerate solution delivery

### Capabilities
* Package an open source [natural language processing](http://stanfordnlp.github.io/CoreNLP) (NLP) tool suite as a ready-to-use entity extraction capability using [Docker](https://www.docker.com/)
* Package an open source [geocoder library](https://github.com/foursquare/fsqio/tree/master/src/jvm/io/fsq/twofishes) as a ready-to-use geographical coordinate capability using [Docker](https://www.docker.com/)
* Orchestrate a data ingest workflow using [Apache NiFi](https://nifi.apache.org/) templates to leverage the containers described above
* Package the ingest workflow as a ready-to-use data ingest container

## Logical Architecture

![alt text](https://github.boozallencsn.com/odp/odp-data-nifi/raw/master/docs/images/logical_arch.png "Logical Architecture")

## Video Demonstrations

* [![Simple Data Ingest](https://github.boozallencsn.com/odp/odp-data-nifi/raw/master/docs/images/mp4.png)](https://boozallen.sharepoint.com/sites/odp/_layouts/15/guestaccess.aspx?guestaccesstoken=enS43rGKOw6dbpitDwPpWXMHnML8HEJ7xAXsv%2bH%2bAww%3d&docid=2_07a94a74ec6db40bdb38176825dcc45b5&rev=1) [Simple Data Ingest](https://boozallen.sharepoint.com/sites/odp/_layouts/15/guestaccess.aspx?guestaccesstoken=enS43rGKOw6dbpitDwPpWXMHnML8HEJ7xAXsv%2bH%2bAww%3d&docid=2_07a94a74ec6db40bdb38176825dcc45b5&rev=1) - Demonstrates ingest of simple (sentence) data to the NLP and Geocoder containers 


* [![Structured Data Ingest](https://github.boozallencsn.com/odp/odp-data-nifi/raw/master/docs/images/mp4.png)](https://boozallen.sharepoint.com/sites/odp/_layouts/15/guestaccess.aspx?guestaccesstoken=2KPzvfVftMo7do9gT%2fhOzaLZnLLcf4QfevtvCZ3Dafc%3d&docid=2_00f91239c983b4ee78efb8072eaf97a5f&rev=1) [Structured Data Ingest](https://boozallen.sharepoint.com/sites/odp/_layouts/15/guestaccess.aspx?guestaccesstoken=2KPzvfVftMo7do9gT%2fhOzaLZnLLcf4QfevtvCZ3Dafc%3d&docid=2_00f91239c983b4ee78efb8072eaf97a5f&rev=1) - Demonstrates ingest of tabular data (Data.gov procurement data) through the ingest workflow

* [![Hortonworks Automated Installation](https://github.boozallencsn.com/odp/odp-data-nifi/raw/master/docs/images/mp4.png)](https://boozallen.sharepoint.com/sites/odp/_layouts/15/guestaccess.aspx?guestaccesstoken=k2xNHndHNwDWUSFMNmH2Zkr%2fnEZHwVdJGBDVmIXUulk%3d&docid=2_0f20a80647fac4d6ba7555cd94559394d&rev=1) [Hortonworks Automated Installation](https://boozallen.sharepoint.com/sites/odp/_layouts/15/guestaccess.aspx?guestaccesstoken=k2xNHndHNwDWUSFMNmH2Zkr%2fnEZHwVdJGBDVmIXUulk%3d&docid=2_0f20a80647fac4d6ba7555cd94559394d&rev=1) - Demonstrates the automated installation of Hortonworks data platform to an AWS infrastructure

* [![DataLift](https://github.boozallencsn.com/odp/odp-data-nifi/raw/master/docs/images/youtube.png)](https://www.youtube.com/watch?v=IwQqHO4dZHM) [DataLift](https://www.youtube.com/watch?v=IwQqHO4dZHM) - Demonstrates building a container exposing a simple Data API from sample data


## Getting Started

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

## Future Enhancements

* Mission/Domain Vertical Enhancements (Representative examples)
 * Defense/Intel: PUBS document ingestion, security
 * Healthcare: HL7 ingest, security

* General Platform (Representative examples)
 * Data Quality
 * Monitoring
 * Security
 * Auto-metering/scaling





