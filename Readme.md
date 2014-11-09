#BitTorrent Sync Dockerfile

This is a minimal (~12Mb) image to run [BitTorrent Sync](http://labs.bittorrent.com/experiments/sync.html) in docker


### Building the Image

```
docker build -t btsync .
```

By default the btsync.conf will be used for an up and running setup.(default l/p are admin/password)

```
docker run -it --rm -p 8888:8888 btsync
open http://$(boot2docker ip 2>/dev/null):8888
````

## ENVIRONMENT VARIABLES:

* NAME: the name that will appear in the other clients
* LOGIN: Login for the UI
* PASSWORD: Password for the UI
* RW_SECRET: Read/Write key for the default shared volume /data
* RO_SECRET: Read Only key for the default shared volume /data
* RW(=true/false): tells if you wanna mount /data in RO or RW mode

## Real case scenario

### SYNC /data (RW mode):

```
docker run -d --name btsync -p 8888:8888 -p 55555:55555 -e RW=true metakungfu/btsync
open http://$(boot2docker ip 2>/dev/null):8888
```

You can Docker logs CONTAINER_ID to get the Read/Write Key

### Backup /data (RO mode):

```
docker run -d --name btsync -p 8888:8888 -p 55555:55555  metakungfu/btsync
open http://$(boot2docker ip 2>/dev/null):8888
```

You can Docker logs CONTAINER_ID to get the Read Only Key

### Manage everything from the UI:

```
docker run -d --name btsync -p 8888:8888 -p 55555:55555 metakungfu/btsync
open http://$(boot2docker ip 2>/dev/null):8888
```

### Customize/pimp the config

```
docker run -it --rm metakungfu/btsync --dump-sample-config > web.conf
docker run -d --name btsync -v `pwd`:/home -p 8888:8888 -p 55555:55555 metakungfu/btsync
open http://$(boot2docker ip 2>/dev/null):8888
```

