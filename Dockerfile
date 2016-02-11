FROM centos:5
MAINTAINER michael@faille.io <michael@faille.io>

COPY Centos.src.repo /etc/yum.repo.conf/Centos.src.repo

RUN yum update -y && \
    yum install yum-utils -y && \
    mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} && \
    echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros && \
    yum groupinstall "Development Tools" -y



RUN wget http://vault.centos.org/7.2.1511/os/Source/SPackages/openssl-1.0.1e-42.el7.9.src.rpm && \
    rpm -ivh openssl-1.0.1e-42.el7.9.src.rpm && \
    yum install -y krb5-devel zlib-devel && \
    cd ~/rpmbuild/SOURCES && \
    sed -i -e "s/secure_getenv/getenv/g" *.patch && \
    cd /root/rpmbuild/SPECS && \
    rpmbuild openssl.spec
