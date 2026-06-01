@echo off
REM UMMU Infrastructure Health Check Script for Windows

echo.
echo 🔍 UMMU Infrastructure Health Check
echo ====================================
echo.

echo Checking Services...
echo.

REM Check Kong Admin API
echo Checking Kong Admin API...
curl -s http://localhost:8001/status >nul 2>&1
if errorlevel 1 (
    echo [✗] Kong Admin API - NOT RUNNING
) else (
    echo [✓] Kong Admin API - OK
)

REM Check Kong Proxy
echo Checking Kong Proxy...
curl -s http://localhost:8000 >nul 2>&1
if errorlevel 1 (
    echo [✗] Kong Proxy - NOT RUNNING
) else (
    echo [✓] Kong Proxy - OK
)

REM Check Auth Service
echo Checking Auth Service...
curl -s http://localhost:3001/health >nul 2>&1
if errorlevel 1 (
    echo [✗] Auth Service - NOT RUNNING
) else (
    echo [✓] Auth Service - OK
)

REM Check Jaeger
echo Checking Jaeger UI...
curl -s http://localhost:16686/ >nul 2>&1
if errorlevel 1 (
    echo [✗] Jaeger - NOT RUNNING
) else (
    echo [✓] Jaeger - OK
)

REM Check Prometheus
echo Checking Prometheus...
curl -s http://localhost:9090/-/healthy >nul 2>&1
if errorlevel 1 (
    echo [✗] Prometheus - NOT RUNNING
) else (
    echo [✓] Prometheus - OK
)

REM Check Grafana
echo Checking Grafana...
curl -s http://localhost:3000/api/health >nul 2>&1
if errorlevel 1 (
    echo [✗] Grafana - NOT RUNNING
) else (
    echo [✓] Grafana - OK
)

echo.
echo ====================================
echo.

echo Docker Compose Services:
echo.
docker-compose ps

echo.
echo ====================================
echo.
echo Dashboard URLs:
echo.
echo   Kong Admin:    http://localhost:8001
echo   Jaeger:        http://localhost:16686
echo   Prometheus:    http://localhost:9090
echo   Grafana:       http://localhost:3000 (admin/admin)
echo.
echo ====================================
