.PHONY: help up down logs build restart stop start status clean health

help:
	@echo "UMMU Infrastructure Management"
	@echo ""
	@echo "Available commands:"
	@echo "  make up       - Start all services"
	@echo "  make down     - Stop all services"
	@echo "  make logs     - Show service logs"
	@echo "  make build    - Build/rebuild services"
	@echo "  make restart  - Restart all services"
	@echo "  make stop     - Stop services (keep data)"
	@echo "  make start    - Start stopped services"
	@echo "  make status   - Check service status"
	@echo "  make clean    - Remove all data and containers"
	@echo "  make health   - Check service health"

up:
	docker-compose up -d
	@echo "Services starting..."
	@sleep 5
	@make status

down:
	docker-compose down
	@echo "Services stopped"

logs:
	docker-compose logs -f

build:
	docker-compose build --no-cache
	@echo "Build complete"

restart:
	docker-compose restart
	@echo "Services restarted"

stop:
	docker-compose stop
	@echo "Services stopped"

start:
	docker-compose start
	@echo "Services started"

status:
	docker-compose ps

clean:
	docker-compose down -v
	@echo "All data cleaned"

health:
	@echo "Checking Kong..."
	@curl -s http://localhost:8001/status | grep -q '"database":{"reachable":true}' && echo "✓ Kong OK" || echo "✗ Kong DOWN"
	
	@echo "Checking Auth Service..."
	@curl -s http://localhost:3001/health | grep -q '"status":"ok"' && echo "✓ Auth Service OK" || echo "✗ Auth Service DOWN"
	
	@echo "Checking Jaeger..."
	@curl -s http://localhost:16686/ > /dev/null && echo "✓ Jaeger OK" || echo "✗ Jaeger DOWN"
	
	@echo "Checking Prometheus..."
	@curl -s http://localhost:9090 > /dev/null && echo "✓ Prometheus OK" || echo "✗ Prometheus DOWN"
	
	@echo "Checking Grafana..."
	@curl -s http://localhost:3000 > /dev/null && echo "✓ Grafana OK" || echo "✗ Grafana DOWN"
