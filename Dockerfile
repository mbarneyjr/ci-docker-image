FROM public.ecr.aws/amazonlinux/amazonlinux:latest

RUN yum update -y

# add nodejs repo
RUN curl --silent --location https://rpm.nodesource.com/setup_14.x | bash -
RUN yum -y install \
  git \
  gcc \
  tar \
  jq \
  make \
  nodejs \
  openssl-devel \
  python-devel.x86_64 \
  libffi-devel \
  zlib-devel \
  zip \
  unzip

# install python 3
RUN cd /opt; \
  curl https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tgz --output python.tgz; \
  tar xzf python.tgz; \
  cd Python-3.9.4; \
  ./configure --enable-optimizations; \
  make install

RUN python3 -m pip install --upgrade \
  awscli \
  aws-sam-cli \
  aws-whoami \
  cfn-lint \
  pip \
  yq

# update npm to latest version
RUN npm install -g npm
