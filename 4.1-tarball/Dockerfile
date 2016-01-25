FROM ubuntu:12.04
MAINTAINER Eric Van Hensberen <eric.vanhensbergen@arm.com>
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install gcc openssh-server build-essential autoconf automake1.9 libtool libopenmpi-dev openmpi-bin openmpi-common python-dev
RUN apt-get -y install wget
RUN apt-get clean
RUN apt-get autoremove
RUN mkdir /sst
RUN mkdir /sst/scratch
RUN mkdir /sst/scratch/src
RUN mkdir /sst/local
RUN mkdir /sst/local/packages
RUN mkdir /sst/local/lib
WORKDIR /usr/local/src
RUN wget http://sourceforge.net/projects/boost/files/boost/1.54.0/boost_1_54_0.tar.gz
RUN tar xfz boost_1_54_0.tar.gz && rm -f boost_1_54_0.tar.gz
WORKDIR /usr/local/src/boost_1_54_0
RUN ./bootstrap.sh --prefix=/sst/local/packages/boost-1.54
RUN sed -i.bak -e '16 a\
# Add MPI so that Boost.MPI gets built.\
using mpi ;\
' project-config.jam
RUN ./b2 install || true
RUN echo "export LD_LIBRARY_PATH=/sst/local/packages/boost-1.54/lib:/usr/lib/openmpi/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
RUN echo "export DYLD_LIBRARY_PATH=/sst/local/packages/boost-1.54/lib:/usr/lib/openmpi/lib:\$DYLD_LIBRARY_PATH" >> ~/.bashrc
WORKDIR /sst/scratch/src/
RUN wget --no-check-certificate http://sst-simulator.org/downloads/sst-4.1.0.tar.gz
RUN tar xfz sst-4.1.0.tar.gz && rm sst-4.1.0.tar.gz
WORKDIR /sst/scratch/src/sst-4.1.0
RUN ./autogen.sh
RUN ./configure --prefix=/sst/local/sst-4.1.0 --with-boost=/sst/local/packages/boost-1.54
RUN make -j$(nproc) all
RUN make install
RUN echo "export PATH=/sst/local/sst-4.1/bin:\$PATH" >> ~/.bashrc
WORKDIR /sst/local/sst-4.1.0/bin
