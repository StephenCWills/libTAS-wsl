ARG baseImage=ubuntu:24.04
FROM $baseImage AS libtas-wsl-builder

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install git wget debhelper-compat && \
    apt-get -y install \
        build-essential automake pkg-config libx11-dev libx11-xcb-dev \
        qtbase5-dev libsdl2-dev libxcb1-dev libxcb-keysyms1-dev libxcb-xkb-dev \
        libxcb-cursor-dev libxcb-randr0-dev libudev-dev libasound2-dev \
        libavutil-dev libswresample-dev ffmpeg liblua5.4-dev libcap-dev \
        libxcb-xinput-dev libfreetype6-dev libfontconfig1-dev g++-multilib \
        libx11-6:i386 libx11-dev:i386 libx11-xcb1:i386 libx11-xcb-dev:i386 \
        libasound2:i386 libasound2-dev:i386 libavutil58:i386 \
        libswresample4:i386 libfreetype6:i386 libfreetype6-dev:i386 \
        libfontconfig1:i386 libfontconfig1-dev:i386 && \
    apt-get -y install \
        build-essential automake pkg-config libwxbase3.2-1t64 libwxgtk3.2-dev \
        wx-common libsdl2-dev libopenal-dev && \
    apt-get -y install \
        pkg-config libasound2-dev libudev-dev default-jre-headless g++ curl \
        fonts-noto

WORKDIR /root
RUN git clone https://github.com/clementgallet/libTAS.git && \
    git clone https://github.com/TASEmulators/pcem.git && \
    git clone https://github.com/ruffle-rs/ruffle.git && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y

WORKDIR /root/libTAS
RUN ./build.sh --with-i386 && \
    DEB_BUILD_OPTIONS=nostrip dpkg-buildpackage --no-sign -b && \
    mv ../libtas*.deb ../libtas.deb

WORKDIR /root/pcem
RUN autoreconf -i && \
    ./configure --enable-release-build && \
    make && \
    sed -i 's/libwxbase3.0-dev/& | libwxbase3.2-1t64/' debian/control && \
    DEB_BUILD_OPTIONS=nostrip dpkg-buildpackage --no-sign -b && \
    mv ../pcem*.deb ../pcem.deb

WORKDIR /root/ruffle
RUN /root/.cargo/bin/cargo build --release --package=ruffle_desktop



FROM $baseImage AS libtas-wsl-interim

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

# Deploy libTAS, PCem and Ruffle

COPY --from=libtas-wsl-builder /root/libtas.deb /tmp/
COPY --from=libtas-wsl-builder /root/pcem.deb /tmp/

COPY --from=libtas-wsl-builder \
     /root/ruffle/target/release/ruffle_desktop \
     /usr/local/bin/ruffle

# Deploy dependency lists
COPY libtas32.deps /tmp/
COPY ruffle.deps /tmp/

# Apply installation steps to WSL's oobe.sh script
RUN echo dpkg --add-architecture i386 >> /etc/oobe.sh && \
    echo apt-get update >> /etc/oobe.sh && \
    echo apt-get -y install sudo libcap2-bin >> /etc/oobe.sh && \
    echo apt-get -y install /tmp/libtas.deb >> /etc/oobe.sh && \
    echo apt-get -y install /tmp/pcem.deb >> /etc/oobe.sh && \
    echo apt-get -y install '$(< /tmp/libtas32.deps)' >> /etc/oobe.sh && \
    echo apt-get -y install '$(< /tmp/ruffle.deps)' >> /etc/oobe.sh && \
    echo rm /tmp/libtas.deb >> /etc/oobe.sh && \
    echo rm /tmp/pcem.deb >> /etc/oobe.sh && \
    echo rm /tmp/libtas32.deps >> /etc/oobe.sh && \
    echo rm /tmp/ruffle.deps >> /etc/oobe.sh && \
    echo setcap cap_checkpoint_restore+eip /usr/bin/libTAS >> /etc/oobe.sh

CMD /bin/bash
