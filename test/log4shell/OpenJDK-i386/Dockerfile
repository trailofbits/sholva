# LABEL org.opencontainers.image.authors="evan.sultanik@trailofbits.com"
# LABEL description="A Docker container that builds the latest version of OpenJDK \
# (pulled from its git repo) in 32bit and with a target architecture of i386. \
# UI and audio libraries are not statically linked, so they will be 32-bit \
# but not necessarily strictly use i386 instructions."

# Building the JDK requires a number of libraries for the target (32-bit) system.
# We fetch them from the Debian archives during this first stage of the build:

FROM ubuntu:20.04 AS libs

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget
WORKDIR /tmp
RUN mkdir /x11 && \
    wget \
    http://ftp.us.debian.org/debian/pool/main/libx/libxi/libxi6_1.7.10-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libxi/libxi-dev_1.7.10-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/x/xorgproto/x11proto-core-dev_2020.1-1_all.deb \
    http://ftp.us.debian.org/debian/pool/main/x/xorgproto/x11proto-input-dev_2020.1-1_all.deb \
    http://ftp.us.debian.org/debian/pool/main/x/xorgproto/x11proto-kb-dev_2020.1-1_all.deb \
    http://ftp.us.debian.org/debian/pool/main/x/xorgproto/x11proto-render-dev_2020.1-1_all.deb \
    http://ftp.us.debian.org/debian/pool/main/x/xorgproto/x11proto-xext-dev_2020.1-1_all.deb \
    http://ftp.us.debian.org/debian/pool/main/libi/libice/libice-dev_1.0.10-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libxrender/libxrender-dev_0.9.10-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libxrandr/libxrandr-dev_1.5.1-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libs/libsm/libsm-dev_1.2.3-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libxt/libxt-dev_1.2.0-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libx11/libx11-dev_1.7.2-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libxtst/libxtst-dev_1.2.3-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/libx/libxext/libxext-dev_1.3.3-1.1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/f/freetype/libfreetype6-dev_2.10.4+dfsg-1_i386.deb \
    http://ftp.us.debian.org/debian/pool/main/f/freetype/libfreetype6_2.10.4+dfsg-1_i386.deb
WORKDIR /x11
RUN for deb in /tmp/*.deb ; do dpkg-deb -x $deb . ; done && rm /tmp/*.deb
RUN ln -s /x11/usr/lib/i386-linux-gnu/libfreetype.so.6 /x11/usr/lib/i386-linux-gnu/libfreetype.so
WORKDIR /tmp
RUN mkdir /alsa && \
    wget \
    http://ftp.debian.org/debian/pool/main/a/alsa-lib/libasound2_1.2.4-1.1_i386.deb \
    http://ftp.debian.org/debian/pool/main/a/alsa-lib/libasound2-dev_1.2.4-1.1_i386.deb \
    && \
    cd /alsa && \
    for deb in /tmp/*.deb ; do dpkg-deb -x $deb . ; done && \
    rm /tmp/*.deb


# We could have done this all using the 32-bit Ubuntu Docker container `i686/ubuntu`,
# but it uses a very old version of Ubuntu that only has OpenJDK 6 available.
# The latest version of OpenJDK (19) is self-hosting, meaning that it requires at least
# OpenJDK version 17 to be installed on the build system in order to compile.
#
# OpenJDK also has a concept of "dev kits" for cross-compilation. There is no prebuilt
# dev kit for 32-bit x86, but there are scripts to make them based off of Fedora.
# We tried this, but also ran into issues related to dependency versions.
#
# Therefore, we are forced to use Ubuntu 20 and cross-compile to 32-bit.
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y build-essential git make autoconf zip \
    unzip openjdk-17-jdk libcups2-dev libfontconfig1-dev file gcc-multilib g++-multilib

# Copy over the 32-bit libraries from the first stage of the build:
COPY --from=libs /x11 /x11
COPY --from=libs /alsa /alsa

# Use the latest version of OpenJDK master
RUN git clone --depth 1 https://git.openjdk.java.net/jdk/

WORKDIR /jdk

RUN bash configure \
    --with-extra-cflags="-fno-pic -g -static -fno-stack-protector -z execstack -mtune=i386" \
    --with-extra-cxxflags="-fno-pic -g -static -fno-stack-protector -z execstack -mtune=i386" \
    --with-extra-ldflags="-L/x11/usr/lib/i386-linux-gnu -L/alsa/usr/lib/i386-linux-gnu -Wl,--unresolved-symbols=ignore-all" \
    --with-x=/x11/usr \
    --with-freetype-include=/usr/include/freetype2/ \
    --with-freetype-lib=/x11/usr/lib/i386-linux-gnu/ \
    --with-alsa=/alsa/usr \
    --with-target-bits=32

RUN make images

RUN mkdir /workdir

WORKDIR /workdir

VOLUME /workdir

CMD /jdk/build/linux-x86-server-release/jdk/bin/java
