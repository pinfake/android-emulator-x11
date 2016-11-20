FROM ubuntu:trusty
MAINTAINER Pin <pinfake@hotmail.com>
EXPOSE 5037 5554 5555
RUN apt-get update && \
    apt-get install -y curl default-jre-headless libgl1-mesa-glx && \
    apt-get clean
ENV ANDROID_HOME="/opt/android-sdk-linux"
ENV ANDROID_SDK_HOME="${ANDROID_HOME}"
ENV PATH="${PATH}:${ANDROID_SDK_HOME}/tools"
RUN cd /tmp && \
    curl -O https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    cd /opt && tar xzf /tmp/*.tgz && rm /tmp/*.tgz
RUN echo "y" | android update sdk --no-ui --force -a --filter android-23,sys-img-x86-android-23
RUN echo "n" | android create avd --force -n nexus -t android-23 -b default/x86
COPY avd/config.ini $ANDROID_HOME/.android/avd/nexus.avd/
ENTRYPOINT ["emulator64-x86","@nexus"]
