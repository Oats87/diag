FROM centos:centos7

MAINTAINER Chris Kim (me@chrishkim.com)

COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo

RUN yum -y update && yum -y install epel-release && yum -y install jq iperf3 iptables wget git net-tools bind-utils bash screen mariadb fio kubectl && yum -y clean all && rm -rf /var/cache/yum

ENTRYPOINT /bin/bash -c 'trap : TERM INT; sleep infinity & wait'
