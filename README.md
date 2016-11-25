# akilli/jenkins

`akilli/base` based jenkins image that includes the docker engine to use the docker pipeline plugin.

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    services:
        jenkins:
            image: akilli/jenkins
            ports:
                - "80:8080"
            volumes:
                - /var/run/docker.sock:/var/run/docker.sock

or with a separate data volume

    version: '2'
    volumes:
        jenkinsdata: {}
    services:
        jenkins:
            image: akilli/jenkins
            ports:
                - "80:8080"
            volumes:
                - jenkinsdata:/home/app/root
                - /var/run/docker.sock:/var/run/docker.sock

Then browse to `http://localhost`

**NOTE**
Uses the `app` user that is created in the `akilli/base` image. 
**The `app` user is added to the docker group so that he is allowed to execute docker commands.** 
