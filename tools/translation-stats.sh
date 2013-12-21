#!/bin/bash

POFILE=doc/openstack-ops/locale/ja.po

CURDIR=$(dirname $0)
POFILE_PATH=$CURDIR/../$POFILE
echo -n "$POFILE: "
msgfmt -o /dev/null --statistics $POFILE_PATH
