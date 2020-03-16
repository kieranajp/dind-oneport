FROM docker:18.09-dind as upstream

# copy everything to a clean image, so we can change the exposed ports
FROM scratch
COPY --from=upstream / /

VOLUME /var/lib/docker

# EXPOSE 2376 # is for tls connections, and having both breaks gitlab "wait-for-it" service
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []

ENV DOCKER_CHANNEL=stable
ENV DOCKER_VERSION=19.03
ENV DOCKER_TLS_CERTDIR ''

