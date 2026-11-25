# Inception (`gate-to-containers`)

A containerized multi-service infrastructure built from scratch using **Docker** and **Docker Compose** as part of the **1337 (42 Network)** curriculum.

Every service runs in its own isolated container built from a custom `Dockerfile` (no pre-built application hub images), connected over a dedicated bridge network with persistent bind-mounted volumes and TLS/SSL encryption.

## Architecture

### Core Stack (`make`)
- **Nginx**: Reverse proxy & web server configured with TLS 1.2/1.3 SSL termination on port `443`
- **WordPress + PHP-FPM**: Content management engine serving dynamic PHP requests via FastCGI
- **MariaDB**: Isolated relational database container initialized via environment configuration and persistent storage

### Extended Infrastructure (`make bonus`)
- **Redis**: In-memory object caching integrated with WordPress
- **vsftpd**: Secure FTP server mapped to the WordPress volume
- **Adminer**: Lightweight web-based database administration tool (`:8080`)
- **Portainer**: Container management & monitoring UI (`:9000`)
- **Static Site (`thursday`)**: Containerized standalone static web service (`:3000`)

## Usage

```bash
# Build and start the core stack (Nginx, WordPress, MariaDB)
make

# Build and start the extended stack including bonus services
make bonus

# Stop containers
make down
make down_bonus

# Full cleanup (containers, volumes, images, and bind data)
make fclean
```

## Project Structure

```text
gate-to-containers/
├── Makefile
└── srcs/
    ├── docker-compose.yml
    ├── docker-compose-bonus.yml
    └── requirements/
        ├── mariadb/
        ├── nginx/
        ├── wordpress/
        └── bonus/
            ├── adminer/
            ├── portainer/
            ├── redis/
            ├── thursday/
            └── vsftpd/
```
