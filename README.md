# GoCart - Multivendor E-Commerce Platform

GoCart is a modern, open-source multi-vendor e-commerce platform built with **Next.js** and **Tailwind CSS**. It supports vendor storefront management, customer dashboards, and platform administration.

---

## 🛠️ Tech Stack

- **Frontend & Backend:** Next.js (App Router, Standalone Build)
- **Database ORM:** Prisma
- **Database:** PostgreSQL
- **State Management:** Redux Toolkit
- **Styling:** Tailwind CSS
- **Containerization:** Docker & Docker Compose

---

## 🚀 Getting Started Locally

Follow the steps below to set up and run the application locally on your host machine.

### Prerequisites
- Node.js (v18+)
- npm

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Create a `.env` file at the root of the project:
```env
DATABASE_URL="postgresql://gocart:gocart_secure_pass@localhost:5432/gocart?schema=public"
DIRECT_URL="postgresql://gocart:gocart_secure_pass@localhost:5432/gocart?schema=public"
NEXT_PUBLIC_CURRENCY_SYMBOL="$"
```

### 3. Run Development Server
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## 🐳 Docker Local Development

The project is fully containerized. You can run the Next.js app and the PostgreSQL database in isolated Docker containers with a custom network.

### 1. Build and Run Containers
Ensure **Docker Desktop** is running, then execute:
```bash
docker compose up -d --build
```
This command builds the Next.js app from the production-optimized multi-stage `Dockerfile` and runs PostgreSQL on port `5432`.

### 2. Sync Database Schema
To generate database tables inside the Docker Postgres container, run the database migrations:
```bash
npx prisma@5.18.0 db push
```

### 3. Access the Application
- Open [http://localhost:3000](http://localhost:3000) to browse the Next.js application.
- To view the database tables visually, launch Prisma Studio:
  ```bash
  npx prisma@5.18.0 studio
  ```
  Open [http://localhost:5555](http://localhost:5555) to view records.
