FROM libtas-wsl

# Download PCem release package
ARG releaseVersion=17+st-1
ARG package=pcem_${releaseVersion}_amd64.deb
ADD https://github.com/TASEmulators/pcem/releases/download/${releaseVersion}/$package /tmp/
RUN chmod 666 /tmp/$package

# Apply PCem installation steps to WSL's oobe.sh script
RUN echo apt-get -y install /tmp/$package >> /etc/oobe.sh && \
    echo rm /tmp/$package >> /etc/oobe.sh

CMD /bin/bash
