# Nexus Platform with Docker Support, behind Nginx

This is a template for deploying Nexus Repository Manager and IQ Server behind an NGINX proxy to offload SSL using Docker Compose

I also add a few aliases to my /etc/hosts file to simulate DNS from outside of docker host but this is accessible over http wtihout them. If you're on Windows the file is here, c:\windows\system32\drivers\etc\hosts.

```
127.0.0.1      localhost iq-server.mycompany.com repo.mycompany.com registry.mycompany.com
```

## Features - 
*Will transition in the new name soon to clean up some of the ports and make this work with docker commands. As is there is no cert in path*

- Nexus Web UI with SSL accessible via https://repo.mycompany.com
- Nexus Web UI over http via http://localhost:8081
- Docker proxy group registry accessible via https://registry.mycompany.com
- Docker Private Registry accessible via https://registry.mycompany.com:5000  (push)
- IQ Server accessible via http://localhost:8070 or https://iq-server.mycompany.com

## Operations

The demo-setup script is a one time script to config docker and npm within NXRM; prior to running, review the docker-compose file and the persistent volume mounts. They are set to work on a linux machine and will need to be changed for a windows based machine.
```
./demo-setup.sh
```

To stop, use docker-compose:

```
docker-compose down
```

Subsequent runs can use docker-compose without the build for nginx or the need to create the persistent folders:

```
docker-compose up -d
```

For folks using Docker Sesktop with Kubernetes built in you can also now use Docker Stack.

```
docker-compose build
docker stack deploy -c docker-compose.yml demoenv
```

Then remove it all with

```
docker stack rm demoenv
```

## Ports

The ports are based on my own configuration but can easily be re-aligned via the nginx conf file. If you were previously using my setup with SSL built into Nexus then the big change is to remap 18443 and 5000 to http instead of https within Nexus. I've added some provisioning scripts to remove the need for manual configuration within Nexus. 18443 maps to my Docker-proxy group and 5000 maps to my docker-hosted repo. I run nexus on 8081 (to avoid a conflict with Jenkins) which can still be hit directly for non-https connections. For now the provisioning only does Docker config items but additional examples are in place.

## IQ Server Configuration

There is a config.yml in the IQ-Server folder which is where you can customize the config to work with a SMTP, JIRA and Proxy servers.

## SSL Certificates

The Ngnix docker image build process generates insecure SSL certificates with fake location information and CNAME of localhost. Understand the risks of using these SSL certificates before proceeding. A deployed solution should use a valid CA certificate.


## Dynamic Configuration

Working examples of how to provision a new blobstore and create docker repos using it are in here and part of the setup. There are also placeholders for other formats like Maven, nnpm, etc...
