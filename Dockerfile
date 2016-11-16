FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y curl default-jre sudo
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
USER developer
ENV HOME="/home/developer"
ENV USER="developer"
ENV ANDROID_HOME="/opt/android-sdk-linux"
ENV ANDROID_SDK_HOME="${ANDROID_HOME}"
ENV PATH="${PATH}:${ANDROID_SDK_HOME}/tools"
RUN cd /tmp && \
    curl -O https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    cd /opt && sudo tar xzf /tmp/*.tgz && rm /tmp/*.tgz && sudo chown -R developer:developer /opt/android-sdk-linux
RUN echo "y" | android update sdk --no-ui --force -a --filter platform-tools,android-23,build-tools-23,sys-img-x86-android-23
RUN echo "n" | android create avd --force -n nexus -t android-23 -b default/x86
COPY avd/config.ini $ANDROID_HOME/.android/avd/nexus.avd/
COPY script/emulator.sh $ANDROID_HOME/tools
ENTRYPOINT ["emulator.sh"]
