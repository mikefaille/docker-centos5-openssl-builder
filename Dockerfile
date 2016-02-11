FROM centos:5
MAINTAINER michael@faille.io <michael@faille.io>

COPY Centos.src.repo /etc/yum.repo.conf/Centos.src.repo

RUN yum update -y && \
    yum install yum-utils -y && \
    yumdownloader --source  openssl -y && \
    mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} && \
    echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros && \
    yum groupinstall "Development Tools" -y && \
    rpm -ivh openssl-0.9.8e-37.el5_11.src.rpm
