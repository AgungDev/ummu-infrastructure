# UMMU Infrastructure

Infrastructure repository for the UMMU University Microservices Ecosystem.

This repository contains all infrastructure components used to run, monitor, secure, and observe the microservices architecture.

---

## Overview

The goal of this repository is to provide a centralized infrastructure layer for all services within the UMMU ecosystem.

Current architecture:

```text
Client
   │
   ▼
API Gateway (Kong)
   │
   ├── Auth Service
   ├── Student Service
   ├── Dosen Service
   ├── Finance Service
   ├── Payment Service
   ├── Notification Service
   └── BAAK Service
```

Future architecture:

```text
                          Grafana
                              │
                              ▼
                         Prometheus

Client
   │
   ▼
Kong Gateway
   │
   ├── Auth Service
   ├── Student Service
   ├── Dosen Service
   ├── Finance Service
   ├── Payment Service
   ├── Notification Service
   └── BAAK Service

           │
           ▼
    OpenTelemetry
           │
           ▼
         Jaeger
```

---

## Repository Structure

```text
ummu-infrastructure/
│
├── docker-compose.yml
│
├── kong/
│   ├── kong.yml
│   └── certs/
│
├── otel-collector/
│   └── otel-collector.yml
│
├── jaeger/
│
├── prometheus/
│   └── prometheus.yml
│
├── grafana/
│   └── dashboards/
│
└── README.md
```

---

## Technologies

### API Gateway

* Kong Gateway

Responsibilities:

* API Routing
* Reverse Proxy
* Authentication Layer
* Rate Limiting
* Request Transformation
* Centralized Gateway Management

---

### Observability

#### OpenTelemetry

Used to collect telemetry data from services.

Provides:

* Tracing
* Metrics
* Logs

---

#### Jaeger

Used for distributed tracing.

Example:

```text
POST /api/v1/auth/login

Client
  │
  ▼
Kong Gateway
  │
  ▼
Auth Service
  │
  ▼
PostgreSQL
```

Allows developers to inspect request flow across services.

---

#### Prometheus

Used to collect metrics.

Examples:

* Request Count
* Error Rate
* CPU Usage
* Memory Usage
* Database Metrics

---

#### Grafana

Used to visualize metrics and monitoring dashboards.

Examples:

* Traffic Monitoring
* Service Health
* Error Tracking
* Infrastructure Monitoring

---

## Development Roadmap

### Phase 1

Infrastructure Foundation

* [x] Repository Initialization
* [ ] Docker Compose Setup
* [ ] Kong Gateway Setup
* [ ] Auth Service Integration

---

### Phase 2

Observability

* [ ] OpenTelemetry Collector
* [ ] Jaeger Integration
* [ ] Trace Visualization

---

### Phase 3

Monitoring

* [ ] Prometheus Setup
* [ ] Grafana Setup
* [ ] Metrics Dashboard

---

### Phase 4

Production Readiness

* [ ] HTTPS
* [ ] SSL Certificates
* [ ] Centralized Logging
* [ ] CI/CD Pipeline
* [ ] Kubernetes Migration

---

## Related Repositories

### Services

* ummu-auth-service
* ummu-student-service
* ummu-dosen-service
* ummu-finance-service
* ummu-payment-service
* ummu-notification-service
* ummu-baak-service

---

## Goals

This repository is designed as a learning and production-oriented infrastructure environment to simulate real-world enterprise microservices architecture.

The primary objective is to understand:

* API Gateway Architecture
* Distributed Systems
* Observability
* Monitoring
* Tracing
* Service Communication
* Cloud Native Architecture

---

## License

MIT License
