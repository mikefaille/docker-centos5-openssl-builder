#!/bin/bash

yum install -y wget && \
    wget http://vault.centos.org/7.2.1511/os/Source/SPackages/openssl-1.0.1e-42.el7.9.src.rpm && \
    rpm -ivh --nomd5 openssl-1.0.1e-42.el7.9.src.rpm && \
    yum install -y krb5-devel zlib-devel && \
    cd /root/rpmbuild/SOURCES && \
    sed -i -e "s/secure_getenv/getenv/g" *.patch && \
    cd /root/rpmbuild/SPECS && \
    rpmbuild -bb --define "_source_filedigest_algorithm md5" --define "_binary_filedigest_algorithm md5" openssl.spec
