# Docker-In-Docker image exposing only one port.

This image is a copy of the official Docker-in-Docker image exposing only port 2375, to get around [this issue](https://gitlab.com/gitlab-org/gitlab-runner/issues/3984) in Gitlab (essentially, when using the `docker:dind` service, the container hangs for 30 seconds because it's waiting for both ports 2375 and 2376 to be open).

I selected port 2375 over 2376 because we're using the Gitlab Helm chart, which [doesn't support volume mounts yet](https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4501#note_199594340). Exposing port 2376, the TLS port, requires a certificate be mounted inside the container, so is a no-go until they add that.

## Usage

In your `.gitlab-ci.yaml`:

```yaml
services:
- hub.docker.com/kieranajp/dind-oneport

variables:
  DOCKER_HOST: "tcp://127.0.0.1:2375"
  DOCKER_DRIVER: "overlay2"
  DOCKER_TLS_CERTDIR: ""
```

## Credits

Thanks to [Filip Procházka](https://gitlab.com/gitlab-org/gitlab-runner/-/issues/4143#note_194116050) for the idea.
