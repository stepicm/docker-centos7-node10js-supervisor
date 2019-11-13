FROM centos:7
MAINTAINER Martin Stepic <grft801@airmail.cc>

RUN yum -y --setopt=tsflags=nodocs update
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install epel-release
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install supervisor
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install gcc-c++ make

# nodejs
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash
RUN yum -y install nodejs
RUN yum clean all

# yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# supervisor
RUN rm /etc/supervisord.conf
ADD supervisor.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]

EXPOSE 35729 9111
