# Using CentOS as base container
FROM blacklabelops/centos
MAINTAINER Nicolas Muller<n.muller@treeptik.fr>

# Copy  scripts and configs
COPY  ftpscripts/*.sh /

# Sources for proftpd
ENV PROFTP_FTPASSWD_URL http://www.castaglia.org/proftpd/contrib/ftpasswd
ENV PROFTP_URL ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz

# Update container, Install ProFTPd and other needed
RUN yum update -y && yum install tar  perl sudo gcc make -y ;\
    \
    \
    cd /usr/local/src;\
    curl ${PROFTP_URL} | tar zx && cd proftpd* ;\
    ./configure --sysconfdir=/etc && make && make install ;\
    \
    \
    rm /etc/proftpd.conf;\
    curl ${PROFTP_FTPASSWD_URL} > /usr/bin/ftpasswd ; \
    chmod +x /usr/bin/ftpasswd ; \
    chmod +x /usr/bin/ftpasswd ;\
    mkdir -p  /var/ftp/ftpuser ; mkdir /var/ftp/user_keys ;\
    umask 0057;\
    echo 'ftpuser:$1$3CWChbUT$nl5TzKmPkBBk2HinHYKR30:99:99::/var/ftp/ftpuser:/sbin/nologin' > /var/ftp/ftpd.passwd;\
    umask 0022;\
    chown -R  nobody:nobody /var/ftp;\
    ln -s /ftpuser.sh /usr/bin/addftpuser;\
    ln -s /ftpuser.sh /usr/bin/removeftpuser;\
    ln -s /ftpuser.sh /usr/bin/chpassftpuser;\
    ln -s /ftpuser.sh /usr/bin/addtechuser;\
    chmod +x /entrypoint.sh

#Copy config
COPY  configuration/ftp.conf /root/
#Specify volume
VOLUME /var/ftp
EXPOSE 21

# Set entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

#RUN useradd -m proftpd

# Set default start command
CMD ["proftpd","--nodaemon"]
