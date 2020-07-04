FROM ruby:2.7.0

RUN apt-get update -qq && apt-get install -y build-essential

# for capybara-webkit
RUN apt-get install -y libqtwebkit4 libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install --no-install-recommends yarn

ENV APP_HOME /app/
RUN mkdir -p ${APP_HOME}
WORKDIR $APP_HOME
EXPOSE 3000

ADD . ${APP_HOME}/

COPY entrypoint.sh ${APP_HOME}/entrypoint.sh
RUN bundle install && \
    yarn install --check-files && \
    chmod +x ${APP_HOME}/entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]


# docker run -d -p 9042:9042 --name cassandra-host --rm cassandra:3.11.6
# docker run -d -p 3000:3000 --link cassandra-host:cassandra-host ruby
