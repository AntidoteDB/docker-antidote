# AntidoteDB Docker Images

[AntidoteDB][AntidoteDB-website] images for [Docker Hub Repository][AntidoteDB-dockerhub-link]

This is used as docker base image for AntidoteDB. 
The goal is to provide images for a few last Antidote releases (currently 0.2.0 / 0.1.1), and relative alpine slim images.

## Supported tags and respective `Dockerfile` links

The AntidoteDB images come in many flavors, each designed for a specific use case.
- `antidotedb:latest`: the most recent AntidoteDB version (unstable).
- `antidotedb:stable`: the most recent stable official release (recommended).
- `antidotedb:alpine`: the most recent lightweight alpine release (stable).
- `antidotedb:<release>`: Docker image for a specific <release> version of AntidoteDB, official releases are described on [AntidoteDB Github repository][AntidoteDB-github-releases-link].
- `antidotedb:<release>-alpine`: This variant, available for each official release, is recommended when final image size being as small as possible is desired. The main caveat to note is that it use [musl libc](http://www.musl-libc.org/) instead of [glibc and friends](http://www.etalabs.net/compare_libcs.html), so certain software might run into issues depending on the depth of their libs requirements. However, most software does not have an issue with this, so this variant is usually a very safe choice. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

Supported tags and respective `Dockefile` github links:
- [`latest`](https://github.com/AntidoteDB/docker-antidote/blob/master/latest/Dockerfile): the most recent AntidoteDB version (Unstable).
- [`0.2.0`, `stable`](https://github.com/AntidoteDB/docker-antidote/blob/master/v0.2.0/Dockerfile): the most recent stable release (recommended).
- [`0.2.0-alpine`, `alpine`](https://github.com/AntidoteDB/docker-antidote/blob/master/v0.2.0-alpine/Dockerfile): the most recent lightweight alpine release.
- [`0.1.1`](https://github.com/AntidoteDB/docker-antidote/blob/master/v0.1.1/Dockerfile)
- [`0.1.1-alpine`](https://github.com/AntidoteDB/docker-antidote/blob/master/v0.1.1-alpine/Dockerfile)
- [`0.1.0`](https://github.com/AntidoteDB/docker-antidote/blob/master/v0.1.0/Dockerfile)

## Getting started (for stable recommended version)

### Prerequisites

- Working recent version of Docker (1.12 and up recommended)

### Starting a local node

Start a local node with the command
```
docker run -d --name antidote -p "8087:8087" antidotedb/antidote:stable
```

This should fetch the Antidote image automatically. For updating to the latest version use the command `docker pull antidotedb/antidote:stable`.

### Building the image locally

For building the Docker image on your local machine, use the following commands:
```
git clone https://github.com/AntidoteDB/docker-antidote
cd docker-antidote/v0.2.0
docker build -f Dockerfile -t antidotedb:local-build
```

Then you can run it using:
```
docker run -d --name antidote -p "8087:8087" antidotedb:local-build
```

### Using the local node

Wait until Antidote is ready. The current log can be inspected with `docker logs antidote`. Wait until the log message `Application antidote started on node 'antidote@127.0.0.1'` appears.

Antidote should now be running on port 8087 on localhost.

### Connect to the console

You can connect to the console of a local node typing the following:
```
docker exec -it antidote /opt/antidote/bin/env attach
```

### Building Antidote locally from the source code
Please look at the [dedicated README doc](https://github.com/AntidoteDB/docker-antidote/tree/master/local-build)

## Quick reference

- **AntidoteDB**: [Official website][AntidoteDB-website], [Quick start guide](https://antidotedb.gitbook.io/documentation/) or [The AntidoteDB Community Slack](https://antidotedb.slack.com/).

- **Where to file issues**: [https://github.com/AntidoteDB/antidote/issues](https://github.com/AntidoteDB/antidote/issues)

- **Docker, where to get help**: [the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

## License
View [license information](https://github.com/AntidoteDB/antidote/blob/master/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

[AntidoteDB-website]: https://www.antidotedb.eu/
[AntidoteDB-dockerhub-link]: https://hub.docker.com/r/antidotedb/antidote
[AntidoteDB-github-releases-link]: https://github.com/AntidoteDB/antidote/releases
