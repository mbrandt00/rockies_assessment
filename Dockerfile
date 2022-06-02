# syntax=docker/dockerfile:1
FROM ruby:2.7.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client pkg-config libxml2-dev libxslt-dev libc6
WORKDIR /rockies_challenge
COPY Gemfile /rockies_challenge/Gemfile
COPY Gemfile.lock /rockies_challenge/Gemfile.lock
RUN bundle install
RUN rails db:{drop,create,migrate} pitches
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]