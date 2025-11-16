# Project Sync Tool

A Rails-based project management application for tracking projects, deadlines, and team member assignments.

[![Ruby](https://img.shields.io/badge/Ruby-3.3.6-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1-red.svg)](https://rubyonrails.org/)

## Features

- **Project Management**: Create and manage projects with detailed information
- **Deadline Tracking**: Assign deadlines to team members for specific projects
- **Team Management**: Assign members to projects and track their responsibilities
- **Role-Based Access**: Separate views for managers and team members
- **User Authentication**: Secure login system using Devise

### User Capabilities

**Managers can:**
- Create and manage projects
- Assign deadlines to team members
- Add/remove members from projects
- View all projects and deadlines

**Members can:**
- View their assigned deadlines
- View their assigned projects
- See other team members on their projects
- Track their project managers

## Tech Stack

- **Framework**: Ruby on Rails 7.1
- **Ruby Version**: 3.3.6
- **Database**:
  - SQLite3 (development/test)
  - MySQL (production)
- **Authentication**: Devise 4.9
- **CSS Framework**: Foundation 6.7
- **Forms**: SimpleForm 5.3
- **Asset Pipeline**: Sprockets

## Prerequisites

- Ruby 3.3.6
- Bundler
- SQLite3 (for development)
- MySQL (for production, optional)

## Installation

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd cins465-p8
   ```

2. **Install dependencies**
   ```bash
   bundle install --without production
   ```

3. **Setup database**
   ```bash
   rake db:create db:migrate
   ```

4. **Seed database (optional)**
   ```bash
   rake db:seed
   ```

5. **Start the server**
   ```bash
   rails server
   ```

6. **Visit the application**
   ```
   http://localhost:3000
   ```

### Docker Setup

See [AGENTS.md](AGENTS.md) for Docker deployment instructions.

## Configuration

### Environment Variables

For production deployment, set these environment variables:

```bash
SECRET_KEY_BASE=<generate with 'rails secret'>
DATABASE_NAME=group_project_sync_production
DATABASE_USERNAME=<mysql_username>
DATABASE_PASSWORD=<mysql_password>
DATABASE_HOST=localhost
DATABASE_SOCKET=/var/run/mysqld/mysqld.sock
```

### Database Configuration

- **Development/Test**: Uses SQLite3 (no configuration needed)
- **Production**: Uses MySQL with environment variables (see above)

## Testing

Run the test suite:

```bash
rake test
```

## Deployment

### Production Checklist

1. Set all required environment variables
2. Install production dependencies: `bundle install`
3. Setup database: `RAILS_ENV=production rake db:create db:migrate`
4. Precompile assets: `RAILS_ENV=production rake assets:precompile`
5. Start server: `RAILS_ENV=production rails server`

### Docker Deployment

```bash
docker-compose up -d
```

See [AGENTS.md](AGENTS.md) for detailed Docker instructions.

## Security

This application has been upgraded from Rails 4.0.2 to 7.1 with critical security fixes:

- ✅ SQL injection vulnerabilities fixed
- ✅ Secrets moved to environment variables
- ✅ Database credentials secured
- ✅ All dependencies updated to secure versions

See [UPGRADE_NOTES.md](UPGRADE_NOTES.md) for complete security audit details.

## Project Structure

```
├── app/
│   ├── controllers/     # Application controllers
│   ├── models/          # ActiveRecord models
│   ├── views/           # ERB templates
│   └── assets/          # CSS, JavaScript, images
├── config/              # Application configuration
├── db/
│   ├── migrate/         # Database migrations
│   └── schema.rb        # Current database schema
├── test/                # Test files
└── Dockerfile           # Docker configuration
```

## Key Models

- **Member**: User accounts (can be managers or regular members)
- **Project**: Projects that can be assigned to members
- **Deadline**: Deadlines associated with projects and members
- **MemberProjectGrouping**: Join table for member-project associations
- **MemberDeadlineGroupings**: Join table for member-deadline associations

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a pull request

## Development Notes

### Recent Upgrades

This application was recently upgraded from Rails 4.0.2 (2013) to Rails 7.1 (2024). See [UPGRADE_NOTES.md](UPGRADE_NOTES.md) for:
- Complete upgrade details
- Breaking changes
- Migration guide
- Security fixes

### Future Improvements

- Gantt chart visualization for deadlines
- Calendar view (similar to Google Calendar)
- Email notifications for deadline reminders
- File attachments for projects
- Activity timeline/audit log
- Advanced reporting and analytics

## Support

For issues or questions:
1. Check existing GitHub issues
2. Review [UPGRADE_NOTES.md](UPGRADE_NOTES.md)
3. Create a new issue with detailed description

## Acknowledgments

- Built with Ruby on Rails
- Authentication by Devise
- UI by Foundation Framework
