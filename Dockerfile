FROM openkbs/jre-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jre-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
ENV ATOM_VERSION=v1.18.0
ENV ATOM_PACKAGE=atom-amd64.deb

WORKDIR ${HOME}

COPY ${ATOM_PACKAGE} /tmp/
#RUN curl -L https://github.com/atom/atom/releases/download/${ATOM_VERSION}/${ATOM_PACKAGE} > /tmp/${ATOM_PACKAGE} && \
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    fakeroot \
    gconf2 \
    gconf-service \
    git \
    gvfs-bin \
    libasound2 \
    libcap2 \
    libgconf-2-4 \
    libgtk2.0-0 \
    libnotify4 \
    libnss3 \
    libxkbfile1 \
    libxss1 \
    libxtst6 \
    xdg-utils && \
    dpkg -i /tmp/${ATOM_PACKAGE} && \
    rm -f /tmp/${ATOM_PACKAGE} && \
    apm install language-docker

RUN \
    mkdir -p ${HOME}/workspace  && \
    useradd -d /home/atom -m atom

VOLUME ${HOME}/workspace
VOLUME ${HOME}/.atom 

USER ${USER_NAME}

CMD ["/usr/bin/atom","-f"]

