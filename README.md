# android-emulator-x11
Docker container ready to run an android emulator through x11.

You must ensure you're running the container from a user with uid:gid 1000:1000 in the host machine.

You must give others rw access to /dev/kvm (yes this is a security issue, of course madmoiselle)
```sh
sudo chmod o+rw /dev/kvm
```

To run without docker-compose:
```sh
docker run -d --privileged --name android-emulator -e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix pinfake/android-emulator-x11 "@nexus"
```
With compose:

```sh
docker-compose up -d
```
