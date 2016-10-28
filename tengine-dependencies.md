### 必要依赖 (necessary dependencies)

1. gcc
`yum install gcc`
      
2. pcre -> --with-http_rewrite_module && core module
`yum install pcre pcre-devel`

3. zlib -> --with-http_gzip_static_module
`yum install zlib zlib-devel`

4. openssl -> --with-http_ssl_module && --with-mail_ssl_module
`yum install openssl openssl-devel`

### 非必要依赖 (unnecessary dependencies)

1. libgd(can not be found by yum) -> --with-http_image_filter_module
`yum install libgd libgd-devel`

2. libgeoip(can not be found by yum) -> --with-http_geoip_module
`yum install libgeoip libgeoip-devel`

3. libxml2 -> --with-http__xslt_module
`yum install libxml2 libxml2-devel`

4. libxslt -> --with-http__xslt_module
`yum install libxslt libxslt-devel`

