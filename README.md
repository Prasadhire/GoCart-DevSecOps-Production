# 🛒 GoCart: Production-Grade DevSecOps & GitOps E-Commerce Blueprint

![GoCart Banner](./GoCart%20Banner.png)

GoCart is a modern Next.js e-commerce platform orchestrated for enterprise-level scale, running inside a zero-trust **AWS EKS Kubernetes** cluster and continuous delivery managed via **ArgoCD GitOps** controllers.

Designed and Architected by **Prasad Hire**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/prasad-hire-4a818b337)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Prasadhire)

---

## 🛠️ Technology Stack & Badges

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![ArgoCD](https://img.shields.io/badge/ArgoCD-F3F4F6?style=for-the-badge&logo=argo&logoColor=orange)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-%232088FF.svg?style=for-the-badge&logo=github-actions&logoColor=white)
![SonarCloud](https://img.shields.io/badge/SonarCloud-F30032?style=for-the-badge&logo=sonarcloud&logoColor=white)
![Trivy](https://img.shields.io/badge/Trivy-38A3E5?style=for-the-badge&logo=trivy&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)

---

## 🏛️ System Architecture Flow

```text
User Request (Browser HTTP/HTTPS)
  │
  ▼
AWS Classic / Network Load Balancer (created dynamically via Ingress NGINX service)
  │
  ▼
NGINX Ingress Controller Pod (routing engine)
  │
  ▼
ClusterIP Service (gocart-service:80 -> forwards to target port 3000)
  │
  ▼
GoCart Next.js Container Pod (Next.js server execution - running as non-root user UID 1001)
  │
  ▼
AWS RDS PostgreSQL Database (isolated in private subnets on port 5432)
```

---

## 🚦 DevSecOps Continuous Integration Pipeline (GitHub Actions)

Every commit to `main` initiates parallel vulnerability scanning jobs before compilation:

```text
[SonarCloud SAST] ─────────┐
[Trivy Filesystem Scan]  ──┼─> [Docker Build & Push] ──> [Trivy Container Scan]
[OWASP Dependency Check] ──┘
```

*   **SonarCloud**: Scans React/Next.js files for bugs, logic vulnerability triggers, and security hotspots.
*   **Trivy Filesystem**: Identifies vulnerabilities inside third-party `package-lock.json` libraries.
*   **OWASP Dependency Check**: Validates the codebase against the National Vulnerability Database (NVD).
*   **Trivy Container Scan**: Evaluates the compiled container layers before registry publication.
*   **Non-Root Execution**: Hardened `Dockerfile` running standalone builds restricted strictly to system UID `1001`.

---

## ⚙️ GitOps Continuous Delivery Architecture (ArgoCD)

*   **App-of-Apps Design Pattern**: A single `root-app` declaratively tracks and syncs the entire cluster setup (`gocart-app`, NGINX Ingress, Monitoring, Alerting rules).
*   **Self-Healing State**: ArgoCD monitors the cluster environment and auto-reconciles any resource drift (e.g. manual `kubectl` updates).
*   **Image Updater Integration**: Automatically monitors Docker Hub, deploys updated tags, and writes the deployment values back to Git (`write-back-method: git`).
*   **SMTP Alerting Layouts**: Custom glassmorphic HTML email templates delivered over Gmail SMTP gateway on successful/failed sync status changes.

---

## 🐳 Running Locally

### Prerequisites
*   Node.js (v18+)
*   Docker Desktop / Daemon

### 1. Install Dependencies
```bash
npm install
```

### 2. Run with Docker Compose
```bash
docker compose up -d --build
```
*Builds the Next.js container from the multi-stage optimization setup and starts PostgreSQL (port 5432).*

### 3. Deploy Local Database Schema
```bash
npx prisma@5.18.0 db push
```

---

## ☁️ Running on AWS EKS Production

### 1. Terraform Base Infrastructure
```bash
cd devops/terraform
terraform init
terraform apply
```
*Deploys the 3-AZ VPC, EKS Cluster nodes, and private RDS Postgres DB.*

### 2. Configure credentials
```bash
aws eks update-kubeconfig --region ap-south-1 --name gocart-prod-eks
```

### 3. Bootstrap GitOps
```bash
kubectl apply -f devops/argocd/root-app.yaml
```
*ArgoCD will automatically reconcile, deploy, and scale the components.*
