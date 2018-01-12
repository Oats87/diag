FROM centos

MAINTAINER Chris Kim (me@chrishkim.com)

ENTRYPOINT /bin/bash -c 'trap : TERM INT; sleep infinity & wait'
