FROM ubuntu:focal
MAINTAINER ostfor

# Install gramps itself
RUN apt-get update &&  \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install curl rclone xvfb xdg-utils python3-gi python3-gi-cairo python3-bsddb3 librsvg2-2 gir1.2-gtk-3.0 make python3-pillow graphviz python3-pip && \
    apt-get clean && \
    rm /var/lib/apt/lists/*_*

# download 4.2.3
RUN curl -L https://github.com/gramps-project/gramps/releases/download/v5.1.2/gramps_5.1.2-1_all.deb > /tmp/gramps.deb && \
    dpkg -i /tmp/gramps.deb


# Generate and set default locales

RUN groupadd --gid 950 gramps && \
    useradd --gid 950 --uid 950 gramps && \
    mkdir -p /home/gramps/workdir && \
    chown -cR gramps:gramps /home/gramps/

WORKDIR /home/gramps/workdir

USER gramps
