FROM public.ecr.aws/amazonlinux/amazonlinux:2022

RUN yum update -y

# add nodejs repo
RUN yum -y install \
  git \
  gcc \
  tar \
  jq \
  make \
  bzip2-devel \
  openssl \
  openssl-devel \
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

# install node
ENV NVM_DIR /root/.nvm/
ENV NODE_VERSION 18.12.1
RUN mkdir ${NVM_DIR} \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
