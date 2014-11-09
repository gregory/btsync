FROM progrium/busybox

RUN opkg-install curl &&\
    curl -o /usr/bin/btsync.tar.gz http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable &&\
    cd /usr/bin &&\
    gunzip btsync.tar.gz &&\
    tar -xvf btsync.tar &&\
    rm btsync.tar &&\
    mkdir -p /data/.sync

ADD web.conf /home/
ADD backup.conf /home/
ADD run.sh /

RUN chmod +x /run.sh

VOLUME /data
EXPOSE 8888 55555
ENTRYPOINT ["/run.sh"]


