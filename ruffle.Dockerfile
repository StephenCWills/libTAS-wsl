FROM libtas-wsl

# Download Ruffle nightly build asset
ARG releaseTag
ARG assetFilename
ADD https://github.com/ruffle-rs/ruffle/releases/download/${releaseTag}/$assetFilename /tmp/
RUN chmod 666 /tmp/$assetFilename

# Deploy Ruffle's dependency list
COPY ruffle.deps /tmp/

# Apply Ruffle installation steps to WSL's oobe.sh script
RUN echo apt-get -y install '$(< /tmp/ruffle.deps)' >> /etc/oobe.sh && \
    echo "(cd /usr/local/bin && tar -xzf /tmp/$assetFilename ruffle)" >> /etc/oobe.sh && \
    echo rm /tmp/ruffle.deps >> /etc/oobe.sh && \
    echo rm /tmp/$assetFilename >> /etc/oobe.sh

CMD /bin/bash
