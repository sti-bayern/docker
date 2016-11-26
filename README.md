# akilli/jenkins

`akilli/base` based jenkins image that includes the docker engine to use the docker pipeline plugin.

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    services:
        jenkins:
            image: akilli/jenkins
            ports:
                - "8080:8080"
            volumes:
                - /var/run/docker.sock:/var/run/docker.sock
            privileged: true

or with a separate data volume

    version: '2'
    volumes:
        jenkinsdata: {}
    services:
        jenkins:
            image: akilli/jenkins
            ports:
                - "8080:8080"
            volumes:
                - jenkinsdata:/home/app/root
                - /var/run/docker.sock:/var/run/docker.sock
            privileged: true

Then browse to `http://localhost:8080`

**NOTE**
Uses the `app` user that is created in the `akilli/base` image. 
**The `app` user is added to the docker group so that he is allowed to execute docker commands.** 
