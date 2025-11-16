# Known Issues

## SCSS/Foundation Compatibility Issue

### Problem
The application currently has a compatibility issue between `foundation-rails` (v6.9) and newer versions of SassC (v2.4+) that come with `sass-rails` 6.0. This causes the following error when trying to load pages:

```
SassC::SyntaxError - Error: Invalid CSS after "    @return math": expected expression (e.g. 1px, bold), was ".abs($a);"
```

### Root Cause
Foundation Rails 6.9 uses old Sass syntax (`math.abs($a)`) that requires the `sass:math` module to be loaded, but the gem's internal SCSS files don't include this import. This is incompatible with SassC 2.4.0+.

### Current Status
The application has been partially migrated to use `dartsass-rails` instead of `sass-rails`, which is the modern Rails 7 approach. However, full integration requires:
1. Running `bin/dev` instead of `rails server` to start both the Rails server and Dart Sass watcher
2. Ensuring assets are precompiled before deployment

### Workarounds

**Option 1: Use Dart Sass (Recommended for Rails 7)**
```bash
# Start the development server with Dart Sass
./bin/dev

# Or manually start both processes:
# Terminal 1:
bundle exec rails dartsass:watch

# Terminal 2:
bundle exec rails server
```

**Option 2: Downgrade to older sass-rails (Quick Fix)**
In `Gemfile`, change:
```ruby
gem 'dartsass-rails', '~> 0.5.0'
```
to:
```ruby
gem 'sass-rails', '~> 5.0'
gem 'sassc', '~> 2.1.0'
```

Then run:
```bash
bundle install
bundle exec rails server
```

**Option 3: Replace Foundation (Long-term Solution)**
Replace `foundation-rails` with a modern CSS framework like:
- Bootstrap 5
- Tailwind CSS
- Bulma

### For Production
Precompile assets before deployment:
```bash
RAILS_ENV=production bundle exec rails dartsass:build
RAILS_ENV=production bundle exec rails assets:precompile
```

### What Works
- ✅ Health check endpoint (`/up`) - returns HTTP 200
- ✅ Rails server starts successfully
- ✅ All `before_filter` deprecations fixed
- ✅ SQL injection vulnerabilities fixed
- ✅ Database migrations run successfully

### What Doesn't Work (Yet)
- ❌ Pages that require CSS compilation (most views)
- ❌ Single-command `rails server` startup (needs `bin/dev`)

### Next Steps
1. Complete Dart Sass integration by updating documentation
2. Test all routes with `bin/dev`
3. OR: Switch to a modern CSS framework
4. OR: Use precompiled assets and disable runtime compilation

### Related Files
- `Gemfile` - gem dependencies
- `Procfile.dev` - development process manager config
- `app/assets/stylesheets/application.scss` - main stylesheet
- `app/assets/stylesheets/foundation_and_overrides.scss` - Foundation config
- `app/assets/config/manifest.js` - asset pipeline manifest
