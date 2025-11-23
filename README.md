# Learning CI/CD
found this beautiful springboot project to test.

# Jenkins and docker
installed Jenkins on Docker container, and where i read it said install docker inside docker for easyly integrate further tasks and its done by something called docker:bind so i used chatgpt and gave me this docker-compose.yaml and Dockerfile

```docker-compose.yaml
networks:
  custom:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 192.168.61.0/24

volumes:
  jenkins-docker-certs:
  jenkins-data:

services:
  jenkins:
    image: myjenkins/blueocean:2.387.3
    build: 
      context: ./
      dockerfile: Dockerfile
    ports:
      - 8080:8080
      - 50000:50000
    environment:
      - DOCKER_HOST=tcp://docker:2376
      - DOCKER_CERT_PATH=/certs/client
      - DOCKER_TLS_VERIFY=1
    networks:
      custom:
        ipv4_address: 192.168.61.15
    dns: 8.8.8.8
    domainname: ip.me
    hostname: jenkins
    restart: on-failure
    volumes:
      - jenkins-data:/var/jenkins_home
      - jenkins-docker-certs:/certs/client:ro
    depends_on:
      - docker

  docker:
    image: docker:dind
    ports:
      - 2376:2376
      - 8888:8888
    environment:
      - DOCKER_TLS_CERTDIR=/certs
    networks:
      custom:
        ipv4_address: 192.168.61.16
        aliases:
          - docker
    privileged: true
    domainname: ip.me
    hostname: docker
    restart: always
    volumes:
      - jenkins-docker-certs:/certs/client
      - jenkins-data:/var/jenkins_home
```

and content of Dockerfile is as follows

```Dockerfile
FROM jenkins/jenkins:2.538-jdk21
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli zip \ 
    && curl -L "https://github.com/docker/compose/releases/download/v2.40.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \ 
    && chmod +x /usr/local/bin/docker-compose
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
```
