#!/bin/sh

if [ -z "$NAME" ]; then
    export NAME="Docker at $HOSTNAME"
    echo "===> NAME is $NAME"
fi

if [ -z "$UI" ]; then
  if [ -z "$RW_SECRET" ]; then
    export RW_SECRET=$(btsync --generate-secret)
  fi

  if [ -z "$RO_SECRET" ]; then
    export RO_SECRET=$(btsync --get-ro-secret "$RW_SECRET")
    export SECRET=$RO_SECRET
  fi

  if [ -z "$RW" ]; then
    export SECRET=$RO_SECRET
    echo "===> /data is mounted in RO mode"
  else
    export SECRET=$RW_SECRET
    echo "===> /data is mounted in RW mode"
  fi

  echo "===> The KEY is: $SECRET"

  sed -i "s/{{NAME}}/$NAME/g;s/{{SECRET}}/$SECRET/g" /home/backup.conf

  /usr/bin/btsync --nodaemon --config /home/backup.conf
  else
    if [ -z "$LOGIN" ]; then
      export LOGIN='admin'
      echo "===> LOGIN is $LOGIN"
    fi

    if [ -z "$PASSWORD" ]; then
      export PASSWORD='password'
      echo "===> PASSWORD is $PASSWORD"
    fi

    sed -i "s/{{NAME}}/$NAME/g;s/{{LOGIN}}/$LOGIN/g;s/{{PASSWORD}}/$PASSWORD/g" /home/web.conf
    /usr/bin/btsync --nodaemon --config /home/web.conf
fi

