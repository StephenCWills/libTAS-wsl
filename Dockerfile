ARG baseImage=ubuntu:24.04
FROM $baseImage

# Deploy WSL setup files
COPY wsl.conf /etc/
COPY wsl-distribution.conf /etc/
COPY oobe.sh /etc/
COPY libTAS.ico /usr/lib/wsl/
COPY terminal-profile.json /usr/lib/wsl/
RUN chown root:root /etc/wsl*.conf && \
    chmod 644 /etc/wsl*.conf && \
    chmod +x /etc/oobe.sh && \
    (getent passwd 1000 > /dev/null && userdel -r $(id -un 1000) || true)

# Download libTAS release package
ARG releaseVersion=1.4.7
ARG package=libtas_${releaseVersion}_amd64.deb
ADD https://github.com/clementgallet/libTAS/releases/download/v${releaseVersion}/$package /tmp/
RUN chmod 666 /tmp/$package

# Apply libTAS installation steps to WSL's oobe.sh script
RUN echo dpkg --add-architecture i386 >> /etc/oobe.sh && \
    echo apt-get update >> /etc/oobe.sh && \
    echo apt-get -y install sudo libcap2-bin /tmp/$package >> /etc/oobe.sh && \
    echo rm /tmp/$package >> /etc/oobe.sh && \
    echo setcap cap_checkpoint_restore+eip /usr/bin/libTAS >> /etc/oobe.sh

CMD /bin/bash
