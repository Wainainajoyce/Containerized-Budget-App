# syntax=docker/dockerfile:1

# Use the official Ruby image with version 3.1.2
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  build-essential \
  curl

# Set the working directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install Gems dependencies
RUN gem install bundler && bundle install

# Copy the application code
COPY . /myapp

# Precompile assets (optional, if using Rails with assets)
# Uncomment the following line if you want to precompile assets for production
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
