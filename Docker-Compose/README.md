# Retail Sample Application (Docker Compose)

This project is a microservices-based retail application that I ran using Docker Compose. It includes multiple services like cart, catalog, orders, checkout, UI, and their respective databases.

---

## 🧱 Architecture Overview

The application consists of:

### Core Services

* Cart Service (uses DynamoDB)
* Catalog Service (uses MariaDB)
* Orders Service (uses PostgreSQL + RabbitMQ)
* Checkout Service (uses Redis)
* UI Service (Frontend)

### Supporting Services

* DynamoDB Local
* MariaDB
* PostgreSQL
* Redis
* RabbitMQ

---

## ⚙️ Prerequisites

Make sure the following are installed:

* Docker
* Docker Compose (v2 → `docker compose`)
* Basic understanding of containers

---

## 🔑 Environment Variable Setup

This project requires a database password.

Before running the containers, export the variable:

```bash
export DB_PASSWORD='mydbkalyan101'
```

⚠️ Important:
If using `sudo`, you must preserve the environment:

```bash
sudo -E docker compose up -d
```

Otherwise, Docker Compose will not pick up `DB_PASSWORD`.

---

## 🚀 Steps I Followed

### 1. Stop existing containers (if any)

```bash
sudo docker compose down
```

### 2. Set environment variable

```bash
export DB_PASSWORD='mydbkalyan101'
```

### 3. Start services

```bash
sudo -E docker compose up -d
```

---

## 🔍 Useful Commands I Used

### Check running containers

```bash
sudo docker compose ps
```

### View logs (example: orders-db)

```bash
sudo docker compose logs -f orders-db
```

### Stop and remove everything (including volumes)

```bash
sudo docker compose down -v
```

### Restart UI service (if needed)

```bash
sudo -E docker compose up -d --force-recreate ui
```

---

## 🌐 Access Application

Once everything is up, access UI at:

```
http://localhost:8888
```

---

## 🐞 Issues I Faced & Fixes

### 1. DB_PASSWORD not detected

**Issue:**

```
The "DB_PASSWORD" variable is not set
```

**Fix:**
Use:

```bash
sudo -E docker compose up -d
```

---

### 2. PostgreSQL initialization error

**Issue:**

```
Database is uninitialized and superuser password is not specified
```

**Fix:**
Make sure `DB_PASSWORD` is properly exported before running.

---

### 3. Orders service crash (/tmp issue)

**Issue:**

```
Read-only file system
```

**Fix:**
Already handled in compose file using:

```yaml
tmpfs:
  - /tmp
```

---

## 🔐 Security Notes

* Containers use `read_only: true`
* Minimal Linux capabilities (`cap_drop: all`)
* `no-new-privileges` enabled
* Writable `/tmp` handled using `tmpfs`

---

## 📁 Project Files

```
docker-compose.yaml
README.md
```

---

## 📌 Notes

* This setup is mainly for learning / practice
* Not production-ready
* Uses local versions of cloud services (like DynamoDB)

---

## ✅ Final Status

After fixing environment variable issues and restarting services:

* All containers are running ✅
* Database connections working ✅
* UI accessible ✅

---

## 💬 Final Thoughts

This was a good hands-on exercise to understand:

* Docker Compose multi-service setup
* Environment variable handling with sudo
* Service dependencies and health checks
* Debugging container issues using logs

---
