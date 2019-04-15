FROM centos:centos7

MAINTAINER Chris Kim (me@chrishkim.com)

RUN yum -y install iptables wget git net-tools bind-utils bash screen mariadb && yum -y clean all

ENTRYPOINT /bin/bash -c 'trap : TERM INT; sleep infinity & wait'
