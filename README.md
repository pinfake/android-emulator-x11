# android-emulator-x11

Docker container ready to run an android emulator through x11.

This container requires KVM enabled on the host machine.

It will only run on 64 bit linux distros (debian,ubuntu,arch tested so far)

You must ensure you are running the container from a user with uid:gid 1000:1000 in the host machine.

To run without docker-compose:
```sh
docker run -d --privileged --name android-emulator -e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix -v /usr/lib:/usr/lib pinfake/android-emulator-x11
```
With compose:

```sh
docker-compose up -d
```
