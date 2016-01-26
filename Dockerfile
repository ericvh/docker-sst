FROM gem5/sst-base:latest
MAINTAINER Eric Van Hensberen <eric.vanhensbergen@arm.com>
WORKDIR /sst/scratch/src/
#RUN svn co --non-interactive --trust-server-cert https://www.sst-simulator.org/svn/sst/trunk/ sst
RUN git clone --recursive https://github.com/sstsimulator/sst.git
WORKDIR /sst/scratch/src/sst
RUN git submodule foreach git checkout devel
RUN ./autogen.sh
RUN ./configure --prefix=/sst/local/sst --with-boost=/sst/local/packages/boost-1.56 --disable-mem-pools --enable-debug
RUN make -j$(nproc) all
RUN make install
RUN echo "export PATH=/sst/local/sst/bin:\$PATH" >> ~/.bashrc
WORKDIR /sst/local/sst/bin
