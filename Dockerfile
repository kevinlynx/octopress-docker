FROM registry.cn-hangzhou.aliyuncs.com/lovekun/ubuntu-16.04:1.0.0

MAINTAINER Peter Humburg <peter.humburg@gmail.com>

ENV LC_ALL C.UTF-8

COPY source.list /tmp
RUN cp /tmp/source.list /etc/apt/source.list

# Get dependencies
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442 && \
  echo 'deb http://download.fpcomplete.com/ubuntu xenial main'| tee /etc/apt/sources.list.d/fpco.list && \
  apt-get update && apt-get install -y \
  texlive-xetex \
  bundler \
  curl \
  git \
  ruby \
  stack \
  wget && \
  apt-get clean

# Install pandoc
RUN apt-get install -y pandoc


# Install octopress
RUN git clone git://github.com/imathis/octopress.git /octopress && \
    cd /octopress && \
    gem install bundler && \
    bundle install

# Expose default port for octopress preview
EXPOSE 4000
WORKDIR /octopress
