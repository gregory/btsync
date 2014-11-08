FROM progrium/busybox

RUN opkg-install curl &&\
    curl -o /usr/bin/btsync.tar.gz http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable &&\
    cd /usr/bin &&\
    gunzip btsync.tar.gz &&\
    tar -xvf btsync.tar &&\
    rm btsync.tar &&\
    mkdir -p /btsync/.sync

ADD btsync.conf /btsync/
VOLUME /btsync/.sync
EXPOSE 8888 55555
ENTRYPOINT ["btsync", "--nodaemon"]
CMD ["--config", "/btsync/btsync.conf"]

