#!/bin/bash

yum install -y wget && \
    wget  http://vault.centos.org/7.2.1511/os/Source/SPackages/openssl-1.0.1e-42.el7.9.src.rpm && \
    rpm -ivh --nomd5 openssl-1.0.1e-42.el7.9.src.rpm && \
    yum install -y krb5-devel zlib-devel && \
    cd /root/rpmbuild/SOURCES && \
    sed -i -e "s/secure_getenv/getenv/g" *.patch && \
    cd /root/rpmbuild/SPECS && \
    sed -i 's/Name: openssl/Name: openssl1/g' openssl.spec && \
    sed -i 's/%setup -q -n %{name}-%{version}/%setup -q -n openssl-%{version}/g' openssl.spec && \
    sed -i "/Summary: Utilities/i Prefix: /usr \nPrefix: /etc \n \n" openssl.spec && \
    # sed -i  "/%post libs -p \/sbin\/ldconfig/a %post libs -p /usr/bin/echo \"\/usr\/local\/ssl\/usr\/lib64\/\" > /etc/ld.so.conf.d/openssl1.conf" openssl.spec  && \
    # sed -i '/%build/i %define _prefix \/usr\/local/ssl' openssl.spec && \
    sed -i '/Requires: ca-certificates/d' openssl.spec  && \
    rpmbuild -bb --define "_source_filedigest_algorithm md5" --define "_binary_filedigest_algorithm md5" openssl.spec
