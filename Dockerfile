FROM ruby:2.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs yarn sqlite3 libsqlite3-dev libffi-dev

# Set working directory
WORKDIR /app

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.22
RUN bundle install

# Copy app source
COPY . .
RUN bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
