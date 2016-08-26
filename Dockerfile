FROM centos
MAINTAINER Wei<hevei.ho@gmail.com>

#ENV proxy_host "172.17.42.1"
#ENV proxy_port "8668"
#ENV http_proxy "http://${proxy_host}:${proxy_port}"
#ENV https_proxy ${http_proxy}
#ENV HTTP_PROXY ${http_proxy}
#ENV HTTPS_PROXY ${http_proxy}
#ENV proxy ${http_proxy}

#RUN echo $proxy

RUN yum -y update && yum -y groupinstall 'Development Tools' && \
    yum -y install java-devel cmake check check-devel libuuid-devel man && yum clean all
RUN curl -O http://apache.mirrors.ionfish.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
    tar xvf apache-maven-3.3.9-bin.tar.gz && \
    mv apache-maven-3.3.9 /usr/local/apache-maven

ENV M2_HOME /usr/local/apache-maven
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $JAVA_HOME/bin:$PATH

RUN mkdir -p /ws && cd /ws && git clone https://github.com/NonVolatileComputing/pmalloc.git && \
    cd pmalloc && mkdir build && cd build && cmake .. && make && make install

RUN cd /ws && git clone https://github.com/pmem/nvml.git && \
    cd nvml && git checkout tags/0.1+b16 && make && make install

RUN echo export MAVEN_OPTS="\" $([[ \"x\" != \"x${proxy_host}\" ]] && echo -DproxySet=\\\"true\\\" -DproxyHost=${proxy_host} -DproxyPort=${proxy_port}) \"" \
    > /etc/profile.d/mvn.sh && chmod +x /etc/profile.d/mvn.sh

RUN cd /ws && git clone https://github.com/apache/incubator-mnemonic.git && \
    cd incubator-mnemonic && source /etc/profile.d/mvn.sh && mvn clean package install

#make a remote repo lined to my forked version
RUN git remote add origin <https://github.com/weiho1122/incubator-mnemonic.git>

#cd incubator-mnemonic &&
WORKDIR /ws
CMD ["bash"]
