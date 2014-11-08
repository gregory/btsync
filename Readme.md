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

### Real case scenario

You'll want to get a default config:

```
docker run -it --rm metakungfu/btsync --dump-sample-config > btsync.conf
docker run -d --name btsync -v `pwd`:/tmp -p 8888:8888 -p 55555:55555 metakungfu/btsync --config /tmp/btsync.conf
open http://$(boot2docker ip 2>/dev/null):8888
```
