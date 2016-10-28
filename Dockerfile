# docker build -t tengine:simple -t tengine:latest --rm .
FROM centos:latest

MAINTAINER twesix <twesix@aliyun.com>

ENV TENGINE_VERSION 2.1.0

WORKDIR /root/src/

RUN yum update -y
RUN yum install -y gcc gcc-c++ \
                   bzip2 \
                   make autoconf\
                   perl \
                   wget \

RUN wget http://tengine.taobao.org/download/tengine.tar.gz tengine.tar.gz && \
    wget http://www.canonware.com/download/jemalloc/jemalloc-4.2.1.tar.bz2 && \
    wget http://zlib.net/zlib-1.2.8.tar.gz && \
    wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz && \
    wget ftp://ftp.openssl.org/source/openssl-1.0.2j.tar.gz && \

RUN tar -zxvf tengine.tar.gz && \
    rm tengine.tar.gz && \
    tar -jxvf jemalloc-4.2.1.tar.bz2 && \
    rm jemalloc-4.2.1.tar.bz2 && \
    tar -zxvf pcre-8.39.tar.gz && \
    rm pcre-8.39.tar.gz && \
    tar -zxvf openssl-1.0.2j.tar.gz && \
    rm openssl-1.0.2j.tar.gz && \
    tar -zxvf zlib-1.2.8.tar.gz && \
    rm zlib-1.2.8.tar.gz && \
    cd tengine-${TENGINE_VERSION} && \
    \
    ./configure \
    \
    --with-jemalloc=/root/src/jemalloc-4.2.1 \
    --with-pcre=/root/src/pcre-8.39 \
    --with-zlib=/root/src/zlib-1.2.8 \
    --with-openssl=/root/src/openssl-1.0.2j \
    \
    --prefix=/root/tengine \
    --sbin-path=/root/tengine/tengine && \
    \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_spdy_module \
    \
    --with-http_sysguard_module \
    --with-http_stub_status_module \
    \ && \
    \
    make && \
    make install && \

VOLUME ["/root/tengine/conf"]
VOLUME ["/www"]

WORKDIR /root/tengine/tengine

EXPOSE 80 443

CMD ["tengine", "-g", "daemon off;"]