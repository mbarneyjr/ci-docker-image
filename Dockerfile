FROM public.ecr.aws/amazonlinux/amazonlinux:latest

RUN yum update -y

# add nodejs repo
RUN curl --silent --location https://rpm.nodesource.com/setup_18.x | bash -
RUN yum -y install \
  git \
  gcc \
  tar \
  jq \
  make \
  nodejs \
  bzip2-devel \
  openssl \
  openssl-devel \
  python-devel.x86_64 \
  libffi-devel \
  zlib-devel \
  zip \
  unzip

# install python 3
RUN cd /opt; \
  curl https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz --output python.tgz; \
  tar xzf python.tgz; \
  cd Python-3.9.7; \
  ./configure --enable-optimizations; \
  make install

RUN python3 -m pip install --upgrade \
  aws-sam-cli \
  aws-whoami \
  cfn-lint \
  pip \
  yq

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install

# update npm to latest version
RUN npm install -g npm
