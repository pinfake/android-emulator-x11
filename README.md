# android-emulator-x11

Docker container ready to run an android emulator through x11.

This container requires KVM enabled on the host machine.

It will only run on 64 bit linux distros (debian,ubuntu,arch tested so far).
You should use the branch that matches the linux distribution that you are using as host. It most certainly won't work any other way around (this is all about X11 acceleration and the /usr/lib:/usr/lib mapping).

You must enable global x11 access to the host with:
```sh
xhost +
```

Then, to run without docker-compose:
```sh
docker run -d --privileged --name android-emulator --net=host \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix -v /usr/lib:/usr/lib \
pinfake/android-emulator-x11:ubuntu-trusty
```

With docker-compose:
```sh
docker-compose up -d
```
