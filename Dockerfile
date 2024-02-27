FROM alpine:3.19.1

USER root

COPY ssh_config /root/.ssh/config

RUN apk add \
        openssh \
        git git-subtree git-lfs

RUN git config --global --add safe.directory '*'

COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
