#!/bin/bash
ldconfig -r /hostlib
UNIXSOCKET=/tmp/.X11-unix/X${DISPLAY:1}
UNIXSOCKET_OWNER=`stat -c %U $UNIXSOCKET`
sudo chmod o+rw /dev/kvm
sudo chown $USER $UNIXSOCKET
emulator64-x86 @nexus
sudo chmod o-rw /dev/kvm
sudo chown $UNIXSOCKET_OWNER $UNIXSOCKET
