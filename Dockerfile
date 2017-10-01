FROM base/archlinux
MAINTAINER Pin <pinfake@hotmail.com>
EXPOSE 5037 5554 5555
RUN sed -i 's/^SigLevel.*$/SigLevel = Never/g' /etc/pacman.conf
#RUN pacman -Suy --noconfirm curl jre8-openjdk-headless unzip qt5-svg
RUN pacman -Suy --noconfirm curl jre8-openjdk-headless unzip
ENV ANDROID_HOME="/opt/android-sdk-linux"
ENV ANDROID_SDK_HOME="${ANDROID_HOME}"
ENV ANDROID_SDK_ROOT="${ANDROID_HOME}"
ENV PATH="${PATH}:${ANDROID_SDK_HOME}/tools:${ANDROID_SDK_HOME}/tools/bin:${ANDROID_SDK_HOME}/emulator"
RUN cd /tmp && \
    curl -O https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    mkdir $ANDROID_HOME && cd $ANDROID_HOME && unzip /tmp/*.zip && rm /tmp/*.zip
RUN echo "y" | sdkmanager "emulator" "platforms;android-25" "system-images;android-25;google_apis;x86_64"
RUN sdkmanager --update
RUN echo "n" | avdmanager create avd --force -n nexus -k "system-images;android-25;google_apis;x86_64" --abi "google_apis/x86_64"
COPY avd/config.ini $ANDROID_HOME/.android/avd/nexus.avd/
WORKDIR ${ANDROID_HOME}/emulator
ENTRYPOINT ["emulator","-verbose","-skin","800x1280","@nexus"]
