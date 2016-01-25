FROM ubuntu:15.10
MAINTAINER Eric Van Hensberen <eric.vanhensbergen@arm.com>
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install gcc git-core openssh-server build-essential autoconf automake1.11 libtool libtool-bin libopenmpi-dev openmpi-bin openmpi-common python-dev zlib1g-dev
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
#RUN svn co --non-interactive --trust-server-cert https://www.sst-simulator.org/svn/sst/trunk/ sst
RUN git clone --recursive https://github.com/sstsimulator/sst.git
WORKDIR /sst/scratch/src/sst
RUN git submodule foreach git checkout devel
RUN ./autogen.sh
RUN ./configure --prefix=/sst/local/sst --with-boost=/sst/local/packages/boost-1.56
RUN make -j4 all
RUN make install
RUN echo "export PATH=/sst/local/sst/bin:\$PATH" >> ~/.bashrc
WORKDIR /sst/local/sst/bin
