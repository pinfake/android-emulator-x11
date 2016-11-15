# android-emulator-x11
Docker container ready to run an android emulator through x11.

You must ensure you are running the container from a user with uid:gid 1000:1000 in the host machine.

You must give others rw access to /dev/kvm (yes this is a security issue, of course madmoiselle)
```sh
sudo chmod o+rw /dev/kvm
```

You must ensure your unix display socket belongs to your user id.
```sh
ls /tmp/.X11-unix
```

Assuming your DISPLAY is :0, the X0 file must belong to you, if it doesn't:
```sh
sudo chown $USER /tmp/.X11-unix/X?
```
where ? is your display number.

To run without docker-compose:
```sh
docker run -d --privileged --name android-emulator -e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix -v /usr/lib:/usr/lib pinfake/android-emulator-x11
```
With compose:

```sh
docker-compose up -d
```
