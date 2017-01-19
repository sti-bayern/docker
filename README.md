# akilli/jenkins

`akilli/base` based jenkins image that includes the docker engine to use the docker pipeline plugin.

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    volumes:
        jenkins-data: {}
    services:
        jenkins:
            image: akilli/jenkins
            ports:
                - "8080:8080"
            volumes:
                - jenkins-data:/var/lib/jenkins
                - /var/run/docker.sock:/var/run/docker.sock

Then browse to `http://localhost:8080`

**NOTE**
**The `jenkins` user is added to the docker group so that he is allowed to execute docker commands.** 
