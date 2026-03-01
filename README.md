# Simple Application Form (Laravel + Vue)

This repository contains a simple application form built with:
- **Laravel** for the backend API
- **Vue 3** for the frontend form UI
- **MySQL** for database storage

## Features

- Single-page application form UI in Vue
- API endpoint to submit applications
- Laravel form validation via `FormRequest`
- Eloquent model + migration for persistence
- MySQL setup via Docker Compose and SQL init script

## Project Structure

- `resources/js/components/ApplicationForm.vue` - Vue form component
- `app/Http/Controllers/ApplicationController.php` - API controller
- `app/Http/Requests/StoreApplicationRequest.php` - backend validation
- `app/Models/Application.php` - Eloquent model
- `database/migrations/*create_applications_table.php` - applications table
- `database/mysql/init/01-create-database.sql` - creates MySQL database/user
- `routes/api.php` - API route (`POST /api/applications`)
- `routes/web.php` + `resources/views/welcome.blade.php` - serve Vue app
- `docker-compose.yml` - local MySQL service

## MySQL Database Setup

### Option A: Docker (recommended)

Start MySQL:

```bash
docker compose up -d mysql
```

The container is configured with:

- Host: `127.0.0.1`
- Port: `3306`
- Database: `simple_application_form`
- Username: `app_user`
- Password: `app_password`
- Root password: `root`

### Option B: Manual SQL

Run the SQL file on your MySQL server:

```bash
mysql -u root -p < database/mysql/init/01-create-database.sql
```

## Laravel Environment

Copy `.env.example` and adjust credentials if needed:

```bash
cp .env.example .env
```

Current defaults in `.env.example`:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=simple_application_form
DB_USERNAME=app_user
DB_PASSWORD=app_password
```

## How to run in a Laravel environment

If you use this in a full Laravel install:

1. Install PHP and JS dependencies
   ```bash
   composer install
   npm install
   ```
2. Configure environment and database
   ```bash
   cp .env.example .env
   php artisan key:generate
   php artisan migrate
   ```
3. Run app
   ```bash
   php artisan serve
   npm run dev
   ```
4. Open `http://127.0.0.1:8000`

## API Contract

### `POST /api/applications`

Request JSON:

```json
{
  "full_name": "Jane Doe",
  "email": "jane@example.com",
  "phone": "+1 555 1234",
  "position": "Frontend Developer",
  "cover_letter": "I am excited to apply..."
}
```

Success response (`201`):

```json
{
  "message": "Application submitted successfully.",
  "application_id": 1
}
```
