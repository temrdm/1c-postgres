#!/bin/bash

dpkg -x /opt/postgresql-contrib-${PG_MAJOR}_${PG_VERSION}.1C_${PG_ARCH}.deb /opt/tmpdir/
dpkg -e /opt/postgresql-contrib-${PG_MAJOR}_${PG_VERSION}.1C_${PG_ARCH}.deb /opt/tmpdir/DEBIAN
sed -i 's/libicu46/libicu52/g' /opt/tmpdir/DEBIAN/control
dpkg -b /opt/tmpdir /opt/postgresql-contrib-${PG_MAJOR}_${PG_VERSION}.1C_${PG_ARCH}_patched.deb
rm -rf /opt/tmpdir/