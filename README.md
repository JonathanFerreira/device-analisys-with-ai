# Smartphone Sales Listing Analyzer

A Rails application that analyzes smartphone sales listings using AI to detect damage, identify brand and model, and provide confidence levels for each assessment. The application uses both OpenAI and Deepseek APIs for analysis.

## Features

- Automated smartphone analysis from listings
- Damage probability assessment
- Brand and model identification
- Confidence level reporting
- Background job processing with Sidekiq
- Modern UI with Tailwind CSS
- Progressive Web App (PWA) support

## Dependencies

### System Requirements

- Ruby 3.4.4
- Rails 7.2.2
- Node.js (for asset compilation)
- SQLite3
- Docker (for Redis)

### Main Gems

- `ruby-openai`: OpenAI API integration
- `deepseek`: Deepseek API integration
- `sidekiq`: Background job processing
- `tailwindcss-rails`: UI styling
- `turbo-rails` and `stimulus-rails`: Modern frontend features

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd validation_app
   ```

2. Install Ruby 3.4.4:
   ```bash
   # Using rbenv
   rbenv install 3.4.4
   rbenv local 3.4.4
   ```

3. Install dependencies:
   ```bash
   bundle install
   ```

4. Set up Redis using Docker:
   ```bash
   docker run -d -p 6379:6379 --name validation-redis redis:alpine
   ```

5. Set up environment variables:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and add:
   ```
   REDIS_URL=redis://localhost:6379/1
   DEEPSEEK_ACCESS_TOKEN=your_deepseek_token
   RAILS_MASTER_KEY=your_master_key
   ```

6. Set up the database:
   ```bash
   bin/rails db:create db:migrate
   ```

## Running the Application

1. Start Redis (if not running):
   ```bash
   docker start validation-redis
   ```

2. Start Sidekiq worker:
   ```bash
   bundle exec sidekiq
   ```

3. Start the Rails server:
   ```bash
   bin/rails server
   ```

4. Visit `http://localhost:3000` in your browser

## Development

### Code Quality

Run the following checks before committing:

```bash
# Security scan
bin/brakeman --no-pager

# JavaScript security scan
bin/importmap audit

# Lint Ruby code
bin/rubocop
```

### Running Tests

```bash
bin/rails test
```

## Docker Support

### Development with Docker Compose (Recommended)

1. Create your environment file:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and add your API tokens:
   ```
   DEEPSEEK_ACCESS_TOKEN=your_deepseek_token
   RAILS_MASTER_KEY=your_master_key
   ```

2. Build and start the services:
   ```bash
   docker compose build
   docker compose up
   ```

   Or run in detached mode:
   ```bash
   docker compose up -d
   ```

3. View logs (if running in detached mode):
   ```bash
   docker compose logs -f
   ```

4. Stop the services:
   ```bash
   docker compose down
   ```

### Common Docker Compose Commands

```bash
# Rebuild the application
docker compose build web

# Run a Rails command
docker compose run --rm web bin/rails console

# Run database migrations
docker compose run --rm web bin/rails db:migrate

# View service logs
docker compose logs -f web    # Rails app logs
docker compose logs -f redis  # Redis logs

# Stop and remove all containers and networks
docker compose down

# Stop and remove all containers, networks, and volumes
docker compose down -v
```

### Alternative: Manual Docker Setup

If you prefer to run the containers manually:

1. Create a Docker network for the application:
   ```bash
   docker network create validation-app-network
   ```

2. Start Redis:
   ```bash
   docker run -d --name validation-redis \
     --network validation-app-network \
     redis:alpine
   ```

3. Build the image:
   ```bash
   docker build -t validation-app-dev -f Dockerfile.dev .
   ```

4. Run the container:
   ```bash
   docker run -p 3000:3000 \
     --network validation-app-network \
     -e REDIS_URL=redis://validation-redis:6379/1 \
     -e DEEPSEEK_ACCESS_TOKEN=<your-token> \
     -e OPENAI_ACCESS_TOKEN=<your-token> \
     -e REDIS_HOST=validation-redis \
     -v $(pwd):/app \
     --name validation-app-dev \
     validation-app-dev
   ```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `REDIS_URL` | URL for Redis connection | Yes |
| `DEEPSEEK_ACCESS_TOKEN` | API token for Deepseek | Yes |
| `OPENAI_ACCESS_TOKEN` | API token for OpenAI | Yes |
| `RAILS_MASTER_KEY` | Rails master key for credentials | Yes |

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
