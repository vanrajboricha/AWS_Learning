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

🎨 Customize UI Theme (Color Change)

If you want to change the UI theme (for example, font color or overall theme styling), you can modify the UI service environment variable in the docker-compose.yaml file.

Default UI will look like this.
<img width="1181" height="325" alt="Screenshot from 2026-05-05 16-43-57" src="https://github.com/user-attachments/assets/b088f958-d060-4f85-be1e-a8c654c31a1c" />


Update this line under the UI service:

RETAIL_UI_THEME=orange

You can experiment with different values depending on supported themes, but orange works by default in this setup.

After making changes, restart the UI service:

sudo -E docker compose up -d --force-recreate ui

After Updating to Orange Color as mentioned it will look like this.

<img width="834" height="291" alt="Screenshot from 2026-05-05 16-42-29" src="https://github.com/user-attachments/assets/d8c0a6bf-3cfc-462a-b61b-63baf7d9efdd" />


## 🐞 Issues I Faced & Fixes

### 1. DB_PASSWORD not detected

**Issue:**

```
The "DB_PASSWORD" variable is not set
```
**Error Screenshot **
<img width="949" height="243" alt="Screenshot from 2026-05-05 16-36-34" src="https://github.com/user-attachments/assets/194bcd4f-2dbb-4c8b-9726-9a8050954074" />


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

## ✅ Final Status

After fixing environment variable issues and restarting services:

* All containers are running ✅
  <img width="1915" height="577" alt="Screenshot from 2026-05-05 16-47-59" src="https://github.com/user-attachments/assets/5f7283d6-8529-4f9f-9c0b-ba31ee82c038" />

* Database connections working ✅
* UI accessible on port 8888 with localhost✅
  <img width="1899" height="1103" alt="Screenshot from 2026-05-05 16-49-20" src="https://github.com/user-attachments/assets/8cf1e0b6-b8a2-4c4c-9b2c-b169bbe6ef86" />


---

## 💬 Final Thoughts

This was a good hands-on exercise to understand:

* Docker Compose multi-service setup
* Environment variable handling with sudo
* Service dependencies and health checks
* Debugging container issues using logs

---
