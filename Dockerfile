# Project Sync Tool - Dockerfile
# Rails 7.1 with Ruby 3.3.6

FROM ruby:3.3.6-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    libpq-dev \
    default-libmysqlclient-dev \
    nodejs \
    npm \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Set Rails environment
ENV RAILS_ENV=production \
    RACK_ENV=production \
    NODE_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

# Install bundler
RUN gem install bundler:2.7.2

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Create directories for runtime
RUN mkdir -p tmp/pids tmp/cache tmp/sockets log

# Precompile assets
RUN SECRET_KEY_BASE=dummy bundle exec rake assets:precompile

# Create non-root user
RUN useradd -m -u 1000 rails && \
    chown -R rails:rails /app

# Switch to non-root user
USER rails

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:3000/up || exit 1

# Start server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
