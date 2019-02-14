#descirbe: test image
FROM nginx:1.15-alpine
LABEL maintainer="yiruiduan<yiruiduan@163.com>"
ENV NGX_DOC_ROOT=/data/web/html/ \
    WEB_SERVER_PACKAGE="nginx-1.15.5.tar.gz" \
    PORT=8080
ADD entrypoint.sh /bin/
COPY index.html ${NGX_DOC_ROOT:-/data/web/html/}
COPY nginx.conf /etc/nginx
#ADD ${WEB_SERVER_PACKAGE} /usr/local/src/
#RUN cd /usr/local/src/nginx-1.15.5 && \
#    yum -y install gcc gcc-c++ automake pcre pcre-devel zlip zlib-devel openssl openssl-devel && \
#    ./configure  --prefix=/usr/local/nginx  --sbin-path=/usr/local/nginx/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --error-log-path=/var/log/nginx/error.log  --http-log-path=/var/log/nginx/access.log  --pid-path=/var/run/nginx/nginx.pid --lock-path=/var/lock/nginx.lock  --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module --with-http_gzip_static_module --http-client-body-temp-path=/var/tmp/nginx/client/ --http-proxy-temp-path=/var/tmp/nginx/proxy/ --http-fastcgi-temp-path=/var/tmp/nginx/fcgi/ --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi --http-scgi-temp-path=/var/tmp/nginx/scgi --with-pcre && \
#    make && \
#    make install && \
#    yum clean all
#COPY nginx.conf /usr/local/nginx/conf
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 CMD wget -O - -q http://localhost:${PORT}/ || exit 1
ONBUILD ADD https://mirror.tuna.tsinghua.edu.cn/centos/7.2.1511/readme /usr/local/src/

CMD ["/usr/sbin/nginx","-g","daemon off;"]
ENTRYPOINT ["/bin/entrypoint.sh"]

EXPOSE 80/tcp
