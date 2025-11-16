# Project Sync Tool - Agent Deployment Guide

This guide provides concise, accurate instructions for deploying and running the Project Sync Tool.

## What This Is

**Project Sync Tool** is a Ruby on Rails 7.1 web application for managing projects, deadlines, and team member assignments. Originally built in 2013 (Rails 4.0.2), it was recently upgraded with critical security fixes and modern dependencies.

### Core Functionality

- Project creation and management
- Deadline assignment and tracking
- Team member management
- Role-based access (Managers vs Members)
- Secure authentication (Devise)

## Quick Start

### Option 1: Local Development (Fastest)

```bash
# Install dependencies
bundle install --without production

# Setup database
rake db:create db:migrate

# Start server
rails server

# Visit http://localhost:3000
```

**Requirements**: Ruby 3.3.6, Bundler, SQLite3

### Option 2: Docker (Recommended for Production)

```bash
# Build and start
docker-compose up -d

# Visit http://localhost:3000
```

**Requirements**: Docker, Docker Compose

## Docker Deployment

### Using Docker Compose (Recommended)

1. **Start the application**
   ```bash
   docker-compose up -d
   ```

2. **Check logs**
   ```bash
   docker-compose logs -f web
   ```

3. **Stop the application**
   ```bash
   docker-compose down
   ```

### Using Docker Directly

1. **Build the image**
   ```bash
   docker build -t project-sync .
   ```

2. **Run the container**
   ```bash
   docker run -p 3000:3000 \
     -e RAILS_ENV=production \
     -e SECRET_KEY_BASE=$(openssl rand -hex 64) \
     project-sync
   ```

### Production with MySQL

For production with MySQL database:

```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

Or manually:

```bash
docker run -p 3000:3000 \
  -e RAILS_ENV=production \
  -e SECRET_KEY_BASE=<your-secret-key> \
  -e DATABASE_NAME=project_sync_production \
  -e DATABASE_USERNAME=root \
  -e DATABASE_PASSWORD=<your-password> \
  -e DATABASE_HOST=mysql \
  --link mysql:mysql \
  project-sync
```

## Environment Variables

### Required for Production

| Variable | Description | Example |
|----------|-------------|---------|
| `SECRET_KEY_BASE` | Rails secret key | Generate with `rails secret` |
| `RAILS_ENV` | Environment | `production` |

### Required for Production with MySQL

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_NAME` | Database name | `group_project_sync_production` |
| `DATABASE_USERNAME` | MySQL username | `root` |
| `DATABASE_PASSWORD` | MySQL password | (required) |
| `DATABASE_HOST` | MySQL host | `localhost` |
| `DATABASE_SOCKET` | MySQL socket | `/var/run/mysqld/mysqld.sock` |

### Optional

| Variable | Description | Default |
|----------|-------------|---------|
| `RAILS_MAX_THREADS` | Max threads | `5` |
| `RAILS_LOG_LEVEL` | Log level | `info` |
| `RAILS_SERVE_STATIC_FILES` | Serve static files | `false` |

## Database Setup

### Development/Test (SQLite3)

Automatic - no configuration needed.

```bash
rake db:create db:migrate
```

### Production (MySQL)

1. **Ensure MySQL is running**
   ```bash
   # Via Docker
   docker run -d --name mysql \
     -e MYSQL_ROOT_PASSWORD=your_password \
     -e MYSQL_DATABASE=group_project_sync_production \
     -p 3306:3306 \
     mysql:8.0
   ```

2. **Set environment variables**
   ```bash
   export DATABASE_PASSWORD=your_password
   export DATABASE_HOST=localhost
   export DATABASE_NAME=group_project_sync_production
   ```

3. **Run migrations**
   ```bash
   RAILS_ENV=production rake db:migrate
   ```

## Testing

### Run Tests Locally

```bash
# All tests
rake test

# Specific test file
rake test test/models/member_test.rb

# With coverage (if configured)
COVERAGE=true rake test
```

### Run Tests in Docker

```bash
docker-compose run --rm web rake test
```

## Common Tasks

### Create Admin User

```bash
# Local
rails console

# Docker
docker-compose run --rm web rails console
```

Then in console:
```ruby
Member.create!(
  email: 'admin@example.com',
  password: 'secure_password',
  password_confirmation: 'secure_password'
)
```

### View Logs

```bash
# Local
tail -f log/development.log

# Docker
docker-compose logs -f web
```

### Database Console

```bash
# Local
rails dbconsole

# Docker
docker-compose run --rm web rails dbconsole
```

### Reset Database

```bash
# Local
rake db:drop db:create db:migrate db:seed

# Docker
docker-compose run --rm web rake db:reset
```

## Troubleshooting

### Port Already in Use

```bash
# Find and kill process on port 3000
lsof -ti:3000 | xargs kill -9

# Or use different port
rails server -p 3001
```

### Database Connection Issues

**SQLite3 locked:**
```bash
rm -f db/*.sqlite3
rake db:create db:migrate
```

**MySQL connection refused:**
- Ensure MySQL is running
- Check DATABASE_HOST is correct
- Verify credentials

### Bundle Install Fails

```bash
# Clear cache
bundle clean --force
rm -rf vendor/bundle
bundle install
```

### Asset Compilation Issues

```bash
# Clear precompiled assets
rake assets:clobber

# Recompile
rake assets:precompile
```

## Security Notes

### What Was Fixed (2024 Upgrade)

✅ **SQL Injection**: Parameterized queries in controllers
✅ **Exposed Secrets**: Moved to environment variables
✅ **Hardcoded Credentials**: Database password removed from code
✅ **Outdated Dependencies**: All gems updated to secure versions

### Best Practices

1. **Never commit secrets** to version control
2. **Use strong SECRET_KEY_BASE** (minimum 64 characters)
3. **Set up HTTPS** in production (use nginx/Apache reverse proxy)
4. **Regular updates**: Keep gems updated with `bundle update`
5. **Database backups**: Implement automated backup strategy
6. **Monitor logs**: Set up log aggregation (Papertrail, Loggly)

## Performance Optimization

### Caching

Enable caching in development:
```bash
rake dev:cache
```

### Database Pooling

Adjust pool size via `RAILS_MAX_THREADS`:
```bash
export RAILS_MAX_THREADS=10
```

### Precompile Assets

For production:
```bash
RAILS_ENV=production rake assets:precompile
```

## Architecture

### Stack

- **Application**: Ruby on Rails 7.1
- **Web Server**: Puma 6.0
- **Database**: SQLite3 (dev) / MySQL 8.0+ (prod)
- **Cache**: In-memory (can configure Redis)
- **Authentication**: Devise 4.9
- **Frontend**: Foundation 6.7, jQuery

### Data Model

```
Member (User)
  ↓
  ├─ has_many :projects (through member_project_groupings)
  └─ has_many :deadlines (through member_deadline_groupings)

Project
  ↓
  ├─ has_many :members (through member_project_groupings)
  ├─ has_many :deadlines
  └─ belongs_to :manager (optional)

Deadline
  ↓
  ├─ has_many :members (through member_deadline_groupings)
  └─ belongs_to :project (optional)
```

## Monitoring

### Health Check

Rails 7.1 includes built-in health check:

```bash
curl http://localhost:3000/up
```

Returns 200 if app is healthy, 500 if issues exist.

### Application Metrics

```bash
# Memory usage
docker stats project-sync-web-1

# Request logs
tail -f log/production.log | grep "Completed"
```

## Scaling

### Horizontal Scaling

Use multiple containers with load balancer:

```yaml
# docker-compose.scale.yml
version: '3.8'
services:
  web:
    deploy:
      replicas: 3
```

```bash
docker-compose -f docker-compose.yml -f docker-compose.scale.yml up -d
```

### Background Jobs

Not currently configured. To add:
1. Add Sidekiq gem
2. Configure Redis
3. Update Docker Compose with worker service

## Support

- **Documentation**: See [README.md](README.md) and [UPGRADE_NOTES.md](UPGRADE_NOTES.md)
- **Issues**: Create GitHub issue with detailed description
- **Logs**: Always include relevant log output when reporting issues

## Quick Reference

```bash
# Development
bundle install --without production
rake db:create db:migrate
rails server

# Docker
docker-compose up -d
docker-compose logs -f web
docker-compose down

# Production
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake assets:precompile
RAILS_ENV=production rails server

# Testing
rake test
docker-compose run --rm web rake test

# Console
rails console
docker-compose run --rm web rails console
```
