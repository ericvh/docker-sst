FROM ubuntu:15.10
MAINTAINER Eric Van Hensberen <eric.vanhensbergen@arm.com>
#RUN mv /etc/resolv.conf /etc/resolv.conf.bak
#RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install gcc openssh-server build-essential autoconf automake1.11 libtool libtool-bin libopenmpi-dev openmpi-bin openmpi-common python-dev zlib1g-dev
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
RUN wget http://sourceforge.net/projects/boost/files/boost/1.56.0/boost_1_56_0.tar.gz
RUN tar xfz boost_1_56_0.tar.gz && rm -f boost_1_56_0.tar.gz
WORKDIR /usr/local/src/boost_1_56_0
RUN ./bootstrap.sh --prefix=/sst/local/packages/boost-1.56
RUN sed -i.bak -e '16 a\
# Add MPI so that Boost.MPI gets built.\
using mpi ;\
' project-config.jam
RUN ./b2 install || true
RUN echo "export LD_LIBRARY_PATH=/sst/local/packages/boost-1.56/lib:/usr/lib/openmpi/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
RUN echo "export DYLD_LIBRARY_PATH=/sst/local/packages/boost-1.56/lib:/usr/lib/openmpi/lib:\$DYLD_LIBRARY_PATH" >> ~/.bashrc
WORKDIR /sst/scratch/src/
#RUN wget --no-check-certificate http://sst-simulator.org/downloads/sst-5.1.tar.gz
RUN wget --no-check-certificate https://github.com/sstsimulator/sst-downloads/releases/download/SSTReleases/sst-5.1.tar.gz
RUN tar xfz sst-5.1.tar.gz && rm sst-5.1.tar.gz
WORKDIR /sst/scratch/src/sst-5.1
RUN ./autogen.sh
RUN ./configure --prefix=/sst/local/sst-5.1 --with-boost=/sst/local/packages/boost-1.56
RUN make -j4 all
RUN make install
RUN echo "export PATH=/sst/local/sst-5.1/bin:\$PATH" >> ~/.bashrc
WORKDIR /sst/local/sst-5.1/bin
