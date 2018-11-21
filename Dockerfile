FROM ubuntu:18.04

# Init
RUN apt-get update

# Net
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y gnupg2 # kubectl, gcloud
RUN apt-get install -y dnsutils # dig, etc
RUN apt-get install -y unzip

# Development
RUN apt-get install -y vim
RUN apt-get install -y git-core
RUN apt-get install -y zsh
RUN apt-get install -y mysql-client
RUN apt-get install -y redis-tools
RUN apt-get install -y jq
RUN apt-get install -y maven

# Docker
RUN apt-get install -y docker.io

# kubectl
RUN apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl

# gcloud
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-bionic main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && apt-get -y install kubectl google-cloud-sdk google-cloud-sdk-app-engine-grpc google-cloud-sdk-pubsub-emulator google-cloud-sdk-app-engine-go google-cloud-sdk-cloud-build-local google-cloud-sdk-datastore-emulator google-cloud-sdk-app-engine-python google-cloud-sdk-cbt google-cloud-sdk-bigtable-emulator google-cloud-sdk-app-engine-python-extras google-cloud-sdk-datalab google-cloud-sdk-app-engine-java

# bigtable emulator
# RUN apt-get install -y google-cloud-sdk-bigtable-emulator

# cloud sql proxy
WORKDIR /root/.local/bin
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
RUN chmod +x cloud_sql_proxy

# aws cli
RUN apt install -y python-pip
RUN pip install awscli --upgrade --user
RUN echo 'export PATH=~/.local/bin:$PATH' >> /root/.zshrc

# node
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh

# terraform
WORKDIR /root/.local/bin
RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
RUN unzip terraform.zip
RUN rm terraform.zip

# java
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# scala sbt
ENV SCALA_VERSION=2.11.8
ENV SBT_VERSION=0.13.15

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz | tar xfz - -C /root/ && \
  echo >> /root/.zshrc && \
  echo 'export PATH=~/scala-${SCALA_VERSION}/bin:$PATH' >> /root/.zshrc

# Install sbt
RUN \
  curl -L -o sbt-${SBT_VERSION}.deb https://dl.bintray.com/sbt/debian/sbt-${SBT_VERSION}.deb && \
  dpkg -i sbt-${SBT_VERSION}.deb && \
  rm sbt-${SBT_VERSION}.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# go
WORKDIR /root/local
RUN wget -O go.tar.gz https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
RUN tar -xzf go.tar.gz 
RUN rm go.tar.gz
RUN echo 'export GOPATH=$HOME/src/go' >> /root/.zshrc
RUN echo 'export PATH=$PATH:$GOPATH/bin' >> /root/.zshrc

# protobuf
WORKDIR /root/local
RUN curl -OL https://github.com/google/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip
RUN unzip -o protoc-3.6.1-linux-x86_64.zip -d /usr/local bin/protoc
RUN rm -f protoc-3.6.1-linux-x86_64.zip

WORKDIR /root
ENTRYPOINT /bin/zsh
# CMD /bin/zsh