FROM centos:centos7

MAINTAINER Chris Kim (me@chrishkim.com)

RUN yum -y iptables install wget git net-tools bind-utils bash && yum -y clean all

ENTRYPOINT /bin/bash -c 'trap : TERM INT; sleep infinity & wait'
