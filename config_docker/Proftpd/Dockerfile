FROM ccn4/serveurftp:build-internet

RUN rm -f /opt/filetransfert/proftpd.conf

COPY proftpd.conf /opt/filetransfert/



CMD ["proftpd", "-c", "/opt/filetransfert/proftpd.conf", "-n"]




