# 🛍️ Retail Store Sample - Docker Compose Setup

This project runs a complete microservices-based retail application using Docker Compose. It includes services for cart, catalog, orders, checkout, UI, and supporting databases and messaging systems.

---

## 📦 Architecture Overview

The application consists of the following services:

### 🔹 Core Microservices

* **Cart Service** – Manages shopping cart (uses DynamoDB)
* **Catalog Service** – Product catalog (uses MySQL/MariaDB)
* **Orders Service** – Handles order processing (uses PostgreSQL + RabbitMQ)
* **Checkout Service** – Checkout workflow (uses Redis)
* **UI Service** – Frontend application

---

### 🔹 Databases & Messaging

* **DynamoDB Local** – For cart persistence
* **MariaDB** – For catalog data
* **PostgreSQL** – For orders data
* **Redis** – For checkout caching
* **RabbitMQ** – Messaging broker

---

## 🧰 Prerequisites

Make sure you have:

* Docker installed
* Docker Compose v2 (`docker compose` command)
* Minimum 4GB RAM recommended

---

## ⚙️ Environment Variables

Create a `.env` file in the root directory:

```env
DB_PASSWORD=your_secure_password
```

> ⚠️ This password is used across multiple services (PostgreSQL, MariaDB, RabbitMQ).

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd <project-folder>
```

### 2. Start the application

```bash
docker compose up -d
```

### 3. Check running containers

```bash
docker compose ps
```

---

## 🌐 Access the Application

Once everything is running:

👉 Open in browser:

```
http://localhost:8888
```

---

## ❤️ Health Checks

All services include built-in health checks. You can verify status:

```bash
docker compose ps
```

Or inspect logs:

```bash
docker compose logs -f <service-name>
```

---

## 🔐 Security Features

This setup follows container security best practices:

* Read-only root filesystem (`read_only: true`)
* Dropped Linux capabilities (`cap_drop: all`)
* `no-new-privileges` enabled
* Writable `/tmp` via `tmpfs`

---

## 🧪 Useful Commands

### Stop services

```bash
docker compose down
```

### Stop and remove volumes (reset data)

```bash
docker compose down -v
```

### Rebuild containers

```bash
docker compose up --build
```

---

## 🐞 Troubleshooting

### 1. Database password not set

If you see:

```
DB_PASSWORD variable is not set
```

👉 Ensure `.env` file exists and contains:

```env
DB_PASSWORD=your_password
```

---

### 2. Services failing due to `/tmp` error

If you see:

```
Read-only file system
```

✔ Already handled using:

```
tmpfs: /tmp
```

---

### 3. Services not starting

Check dependencies:

```bash
docker compose logs <service-name>
```

---

## 📊 Ports

| Service | Port |
| ------- | ---- |
| UI      | 8888 |

All other services run internally within the Docker network.

---

## 🧱 Network

Custom Docker network:

```
retail-sample_default
```

---

## 📁 Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

---

## 📌 Notes

* This setup is intended for **development and learning purposes**
* Not optimized for production deployment
* Uses local versions of cloud services (e.g., DynamoDB Local)

---

## 🙌 Credits

Based on AWS retail store sample microservices architecture.

---

## 📬 Need Help?

If something breaks:

* Check logs first
* Verify environment variables
* Restart with `docker compose down -v`

---

Happy coding! 🚀
