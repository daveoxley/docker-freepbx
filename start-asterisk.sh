#!/bin/bash

if [[ ! -d /conf/asterisk_spool ]]; then
    mv /var/spool/asterisk /conf/asterisk_spool
else
    rm -rf /var/spool/asterisk
fi
ln -sf /conf/asterisk_spool /var/spool/asterisk

if [[ -d /conf/asterisk ]]; then
    for i in `ls /conf/asterisk/*_custom.conf`; do
        ln -sf /conf/asterisk/$(basename $i) /etc/asterisk/$(basename $i)
    done
fi

sleep 5 && fwconsole reload &

/usr/sbin/asterisk -f

