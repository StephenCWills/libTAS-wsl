FROM libtas-wsl

# Download DepotDownloader release package
ADD https://github.com/SteamRE/DepotDownloader/releases/latest/download/DepotDownloader-linux-x64.zip /tmp/

# Apply Steam installation steps to WSL's oobe.sh script
RUN echo apt-get -y install software-properties-common >> /etc/oobe.sh && \
    echo add-apt-repository -y multiverse >> /etc/oobe.sh && \
    echo apt-get update >> /etc/oobe.sh && \
    echo apt-get -y install steam >> /etc/oobe.sh && \
    echo apt-get -y install unzip >> /etc/oobe.sh && \
    echo unzip /tmp/DepotDownloader-linux-x64.zip DepotDownloader \
             -d /usr/local/bin/ >> /etc/oobe.sh && \
    echo rm /tmp/DepotDownloader-linux-x64.zip >> /etc/oobe.sh

CMD /bin/bash
