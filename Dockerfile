FROM gem5/sst-base:gem5-latest
MAINTAINER Eric Van Hensbergen <eric.vanhensbergen@arm.com>
RUN apt-get -y install pkg-config build-essential m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev swig python-dev python mercurial wget
RUN apt-get clean
WORKDIR /usr/local/src
RUN hg clone http://repo.gem5.org/gem5
# build it
WORKDIR /usr/local/src/gem5
ADD fix.patch /tmp/fix.patch
RUN scons -j$(nproc) --ignore-style build/ARM/libgem5_opt.so
ENV PKG_CONFIG_PATH /sst/local/sst/lib/pkgconfig
RUN patch -p1 < /tmp/fix.patch
RUN make -C ext/sst
