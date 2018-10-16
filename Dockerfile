FROM ubuntu:18.04

# Init
RUN apt-get update

# Net
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y gnupg2 # kubectl, gcloud
RUN apt-get install -y dnsutils # dig, etc

# Development
RUN apt install -y vim
RUN apt-get install -y git-core
RUN apt-get install -y zsh
RUN apt-get install -y mysql-client
RUN apt-get install -y redis-tools

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
RUN apt-get update && apt-get install -y google-cloud-sdk

# cloud sql proxy
WORKDIR /root/.local/bin
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
RUN chmod +x cloud_sql_proxy

# aws cli
RUN apt install -y python-pip
RUN pip install awscli --upgrade --user
RUN echo 'export PATH=~/.local/bin:$PATH' >> ~/.zshrc

# nvm
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh 

WORKDIR /root
ENTRYPOINT /bin/zsh
# CMD /bin/zsh