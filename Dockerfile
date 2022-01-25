FROM ruby:3.0.2

ENV LANG C.UTF-8
ENV DEBCONF_NOWARNINGS yes
ENV XDG_CACHE_HOME /tmp

RUN apt update -qq && \
    apt install -y \
    build-essential vim less

RUN curl https://deb.nodesource.com/setup_15.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update -qq && apt install -y nodejs yarn

WORKDIR /myapp
COPY . ./
RUN bundle
RUN yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
