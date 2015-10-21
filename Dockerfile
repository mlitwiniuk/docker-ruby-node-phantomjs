FROM ubuntu:14.04
MAINTAINER Edwin van der Graaf <edwin@digitpaint.nl>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev \
               libreadline6-dev libyaml-dev git python-software-properties \
               fontconfig libjpeg8 libjpeg-turbo8 libicu52

ENV RUBY_DOWNLOAD_SHA256 df795f2f99860745a416092a4004b016ccf77e8b82dec956b120f18bdc71edce
ADD https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.2.3.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.2.3.tar.gz && \
  cd ruby-2.2.3 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.2.3 && \
  rm -f ruby-2.2.3.tar.gz

RUN gem install bundler --no-ri --no-rdoc

# Install node
ENV NODEJS_DOWNLOAD_SHA256 8861b9f4c3b4db380fcda19a710c0430c3d62d03ee176c64db63eef95a672663
ADD https://nodejs.org/dist/v4.2.1/node-v4.2.1.tar.gz /tmp/

RUN \
  cd /tmp && \
  echo "$NODEJS_DOWNLOAD_SHA256 *node-v4.2.1.tar.gz" | sha256sum -c - && \
  tar xvzf node-v4.2.1.tar.gz && \
  rm -f node-v4.2.1.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  echo -e '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

# Download phantomjs build (see README)
RUN \
  cd /tmp && \
  git clone https://github.com/edwinvdgraaf/phantomjs-build.git && \
  cd phantomjs-build && \
  cp bin/phantomjs /usr/local/bin/ && \
  cd /tmp && \
  rm -rf /tmp/phantomjs-build

