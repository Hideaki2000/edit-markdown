FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get install -y default-mysql-client





#node install
RUN apt-get install -y nodejs npm && npm install n -g && n 14.15.5

#yarn install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn

RUN mkdir /server
WORKDIR /server
COPY Gemfile /server/Gemfile
COPY Gemfile.lock /server/Gemfile.lock

RUN bundle install
RUN yarn 
COPY . /server