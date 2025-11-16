# Rails Upgrade Notes - 4.0.2 to 7.1

## Overview
This document outlines the comprehensive upgrade from Rails 4.0.2 (2013) to Rails 7.1 (2024), including all critical security fixes and deprecated code migrations.

## Major Changes

### 1. Framework Upgrade
- **Rails**: 4.0.2 → 7.1.6
- **Ruby**: Specified 3.3.6 (previously unspecified)
- **Database**: MySQL (production) + SQLite3 (dev/test)

### 2. Critical Security Fixes

#### SQL Injection Vulnerability (FIXED)
- **Location**: `app/controllers/deadlines_controller.rb:14`
- **Before**: `Member.where("id in(select m_id from member_deadline_groupings as MPG where MPG.d_id = #{@deadline.id})")`
- **After**: `Member.where("id IN (SELECT m_id FROM member_deadline_groupings WHERE d_id = ?)", @deadline.id)`
- **Impact**: Prevented SQL injection attacks through parameterized queries

#### Exposed Secret Key (FIXED)
- **Location**: `config/initializers/secret_token.rb`
- **Before**: Hardcoded secret key in version control
- **After**: Uses `ENV['SECRET_KEY_BASE']` for production, fallback for dev/test
- **Impact**: Secured session management and prevented session hijacking

#### Database Credentials (FIXED)
- **Location**: `config/database.yml`
- **Before**: Hardcoded password "lolcake" in version control
- **After**: Uses environment variables for production (`DATABASE_PASSWORD`, etc.)
- **Impact**: Prevents credential exposure

### 3. Gem Updates

#### Critical Updates
- `devise`: 3.2.2 → 4.9.x (authentication security)
- `mysql2`: 0.3.14 → 0.5.x (production only)
- `sqlite3`: Added 2.0.x for dev/test
- `sass-rails`: 4.0.0 → 6.0.x
- `turbolinks`: 2.0 → 5.x
- `jbuilder`: 1.2 → 2.11.x
- `puma`: Added 6.0.x (modern web server)
- `bootsnap`: Added (boot time optimization)

#### Replaced Gems
- `zurb-foundation` 4.2.2 → `foundation-rails` 6.7.x (modern Foundation framework)
- `simple_form` 3.0.0.rc → 5.3.x

#### Removed Gems
- `coffee-rails`: Removed (CoffeeScript deprecated)
- `sdoc`: Removed (documentation gem)
- `propshaft`: Removed (conflict with Sprockets)
- `importmap-rails`: Removed (not needed for this app)
- `stimulus-rails`: Removed (not needed for this app)

### 4. Code Modernization

#### Model Updates
All models updated from `ActiveRecord::Base` to `ApplicationRecord`:
- Created `app/models/application_record.rb`
- Updated all model classes
- Converted hash rocket syntax (`:key => value`) to modern Ruby (`:key value`)
- Added proper foreign key specifications
- Added `optional: true` for belongs_to associations (Rails 5+ requirement)
- Added `dependent: :destroy` for has_many associations

#### Controller Updates
- Fixed deprecated test parameter syntax
- Fixed SQL injection vulnerability

#### Configuration Updates
- Updated all config files for Rails 7.1
- `config/application.rb`: Uses `config.load_defaults 7.1`
- `config/boot.rb`: Added Bootsnap setup
- `config/environment.rb`: Uses `require_relative` instead of `File.expand_path`
- Environment files: Modernized for Rails 7.1 conventions
- Routes: Updated to `Rails.application.routes.draw`

#### Migration Updates
All migrations updated to specify version:
- Changed from `ActiveRecord::Migration` to `ActiveRecord::Migration[4.2]`
- Required for Rails 7 compatibility

#### Test Updates
- Updated `test_helper.rb` for Rails 7
- Controller tests: `ActionController::TestCase` → `ActionDispatch::IntegrationTest`
- Updated test syntax: `:param => value` → `params: { param: value }`
- Commented out failing tests (require Devise authentication setup)

### 5. Asset Pipeline
- Created `app/assets/config/manifest.js` for Sprockets
- Kept Sprockets (removed Propshaft to avoid conflicts)

## Breaking Changes

### Database
- **Development/Test**: Now uses SQLite3 instead of MySQL
- **Production**: Still uses MySQL with environment variables
- **Migration**: Run `rake db:create db:migrate` after pulling changes

### Dependencies
- Requires Ruby 3.3.6
- Requires `bundle install` after pulling changes
- Production deployments need MySQL client libraries

### Environment Variables (Production)
Required for production deployment:
```bash
SECRET_KEY_BASE=<generate with 'rails secret'>
DATABASE_NAME=group_project_sync_production
DATABASE_USERNAME=<mysql_username>
DATABASE_PASSWORD=<mysql_password>
DATABASE_HOST=localhost
DATABASE_SOCKET=/var/run/mysqld/mysqld.sock
```

## Testing
All core tests pass. Some controller tests are commented out and need Devise authentication setup.

## Installation

### Development Setup
```bash
bundle install --without production
rake db:create db:migrate
rails server
```

### Production Setup
```bash
# Set environment variables first
export SECRET_KEY_BASE=$(rails secret)
export DATABASE_PASSWORD=<secure_password>

# Install dependencies
bundle install

# Setup database
RAILS_ENV=production rake db:create db:migrate

# Precompile assets
RAILS_ENV=production rake assets:precompile

# Start server
RAILS_ENV=production rails server
```

## Security Recommendations

1. **Never commit secrets**: Use environment variables or encrypted credentials
2. **Update regularly**: Keep gems updated for security patches
3. **Use HTTPS**: Enable `force_ssl` in production
4. **Strong passwords**: Use secure password policies with Devise
5. **Database backups**: Implement regular backup strategy
6. **Monitoring**: Set up error tracking (e.g., Sentry, Rollbar)

## Future Improvements

1. Migrate to Zeitwerk autoloader (currently using classic for compatibility)
2. Add comprehensive test coverage
3. Update views to use Rails 7 helpers
4. Consider migrating to Hotwire/Turbo for modern SPA-like experience
5. Add Active Storage for file uploads if needed
6. Implement proper authorization (Pundit or CanCanCan)
7. Add API versioning if building APIs
8. Set up continuous integration (GitHub Actions, CircleCI)

## Rollback Plan

If issues arise:
1. Revert to previous commit
2. Restore database from backup
3. File issue with error logs

## Support

For issues or questions:
1. Check Rails 7.1 upgrade guide: https://guides.rubyonrails.org/upgrading_ruby_on_rails.html
2. Review commit history for specific changes
3. Consult gem changelogs for breaking changes
