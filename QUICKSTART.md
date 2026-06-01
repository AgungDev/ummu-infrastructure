# UMMU Infrastructure - Quick Start Guide

Panduan cepat untuk menjalankan UMMU Infrastructure dengan Auth Service saja.

## Prerequisites

- Docker Desktop (dengan Docker Compose)
- Git
- Terminal/Command Prompt

## Struktur Direktori

```
ummu-infrastructure/
├── docker-compose.yml           # Konfigurasi semua services
├── kong/
│   ├── kong.yml                 # Konfigurasi Kong Gateway
│   └── certs/                   # SSL Certificates
├── otel-collector/
│   └── otel-collector.yml       # OpenTelemetry Collector config
├── prometheus/
│   └── prometheus.yml           # Prometheus monitoring config
├── grafana/
│   └── dashboards/              # Grafana dashboard configurations
├── jaeger/                      # Jaeger distributed tracing
├── .env.example                 # Example environment variables
└── README.md                    # This file
```

## Services yang Berjalan

1. **Kong Gateway** (8000, 8001) - API Gateway
2. **Auth Service** (3001) - Authentication Service
3. **PostgreSQL** (5432, 5433) - Database
4. **Jaeger** (16686) - Distributed Tracing UI
5. **Prometheus** (9090) - Metrics Collection
6. **Grafana** (3000) - Monitoring Dashboard
7. **OpenTelemetry Collector** (4317, 4318) - Telemetry Data Collection

## Cara Menjalankan

### 1. Clone dan Setup

```bash
# Masuk ke direktori
cd ummu-infrastructure

# Copy environment variables
cp .env.example .env
```

### 2. Build dan Start Services

```bash
# Start semua services
docker-compose up -d

# Lihat status services
docker-compose ps

# Lihat logs
docker-compose logs -f

# Hanya lihat logs specific service
docker-compose logs -f auth-service
docker-compose logs -f kong
```

### 3. Verifikasi Services

#### Kong Admin API
```bash
curl http://localhost:8001/status
```

#### Auth Service Health
```bash
curl http://localhost:3001/health
```

#### Jaeger UI
Buka browser: http://localhost:16686

#### Prometheus UI
Buka browser: http://localhost:9090

#### Grafana Dashboard
Buka browser: http://localhost:3000
- Username: admin
- Password: admin

## Testing Routes

### Login ke Auth Service melalui Kong

```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

### Register

```bash
curl -X POST http://localhost:8000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "newuser@example.com",
    "password": "password123",
    "name": "New User"
  }'
```

### Verify Token

```bash
curl -X GET http://localhost:8000/api/v1/auth/verify \
  -H "Authorization: Bearer <token>"
```

## Troubleshooting

### Service tidak jalan

```bash
# Restart services
docker-compose restart

# Rebuild images
docker-compose up -d --build

# Check specific service logs
docker-compose logs auth-service
```

### Port sudah digunakan

```bash
# Find process using port
# Windows:
netstat -ano | findstr :8000

# Kill process (ganti PID dengan process ID)
taskkill /PID <PID> /F

# Atau ubah port di docker-compose.yml
```

### Database connection error

```bash
# Reset databases
docker-compose down -v

# Start fresh
docker-compose up -d
```

## Environment Variables

Edit `.env` untuk customize:

```env
# Kong
KONG_DATABASE=postgres
KONG_PG_PASSWORD=kong123

# Auth Service
AUTH_JWT_SECRET=your_secret_key_here
AUTH_SERVICE_PORT=3001

# Grafana
GF_SECURITY_ADMIN_PASSWORD=admin

# OpenTelemetry
OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317
```

## Stopping Services

```bash
# Stop tanpa delete data
docker-compose stop

# Stop dan delete semua (keep volumes)
docker-compose down

# Stop dan delete semua termasuk volumes
docker-compose down -v
```

## Next Steps

1. Build Auth Service image:
   ```bash
   # Clone auth-service repo
   git clone <auth-service-repo>
   cd auth-service
   docker build -t auth-service:latest .
   ```

2. Tambah service baru ke Kong di `kong/kong.yml`

3. Configure monitoring dashboards di Grafana

4. Setup CI/CD pipeline untuk deployment

## Resources

- Kong Documentation: https://docs.konghq.com/
- OpenTelemetry: https://opentelemetry.io/
- Jaeger: https://www.jaegertracing.io/
- Prometheus: https://prometheus.io/
- Grafana: https://grafana.com/

## Support

Untuk pertanyaan atau issue, silakan buat issue di repository.
