FROM centos:8 AS build

# steamcmd is a 32-bit executable, so we need 32-bit libs
RUN dnf -y install glibc.i686 libstdc++.i686
RUN mkdir /opt/{steam,server} && \
    cd /opt/steam && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN /opt/steam/steamcmd.sh +login anonymous +force_install_dir /opt/server +app_update 896660 validate +exit

FROM centos:8

COPY --from=build /opt/server /opt/server
COPY start.sh /
ENTRYPOINT ["/start.sh"]
