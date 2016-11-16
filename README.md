# android-emulator-x11

Docker container ready to run an android emulator through x11.

This container requires KVM enabled on the host machine.

It will only run on 64 bit linux distros (debian,ubuntu,arch tested so far)

You must enable generic x11 access to the host with:
```sh
xhost +
```

Then, to run without docker-compose:
```sh
docker run -d --privileged --name android-emulator -e DISPLAY=$DISPLAY \
-p "0.0.0.0:5037:5037" -p "0.0.0.0:5554:5554" -p "0.0.0.0:5555:5555"
-v /tmp/.X11-unix:/tmp/.X11-unix -v /usr/lib:/hostlib/usr/lib \
pinfake/android-emulator-x11
```

With compose:
```sh
docker-compose up -d
```
