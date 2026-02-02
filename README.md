# **CortexEDR**

**AI-Powered Multi-Agent Application Security & Code Intelligence Platform**
*Continuous Security Analysis, Vulnerability Detection, and Intelligent Remediation for Modern Development Teams*

---

## **Overview**

CortexEDR is an enterprise-grade, AI-native application security platform designed to continuously analyze source code repositories, detect vulnerabilities, simulate exploit paths, and deliver prioritized, actionable remediation guidance.

Unlike traditional static scanners, CortexEDR operates as a **multi-agent orchestration system** powered by large language models and security tooling. It combines classical SAST, dependency analysis, and AI reasoning into a unified, automated security pipeline that integrates directly into developer workflows via GitHub, APIs, and real-time dashboards.

CortexEDR is built for:

* **Startups** seeking automated security without a full AppSec team
* **Engineering teams** who want security embedded in CI/CD
* **Enterprises** requiring audit-ready reporting, access controls, and compliance-grade observability

---

## **Core Capabilities**

### 🔹 Multi-Agent AI Security System

CortexEDR uses a master **Orchestrator Agent** to coordinate specialized agents in parallel:

* **Security Agent** – Static analysis, CVE mapping, exploit feasibility
* **Logic Agent** – Business logic flaw detection and flow simulation
* **Dependency Agent** – Package vulnerability analysis and risk prioritization

All agents share a real-time **memory layer (Redis)** and stream progress to the live dashboard.

### 🔹 GitHub-Native Workflow

* Install as a GitHub App
* Auto-scan on push, PR, or schedule
* Create GitHub Issues with security findings
* Track fix status across commits

### 🔹 Enterprise Reporting

* AI-generated PDF audit reports
* Security scoring and trend analysis
* SLA-ready vulnerability tracking
* Exportable compliance artifacts

### 🔹 Real-Time Dashboard

* Live agent “thinking” and scan progress
* Severity breakdowns
* Security posture trends
* Repository health scoring

---

## **High-Level Architecture**

CortexEDR follows a **layered, cloud-native, asynchronous architecture**:

```
Frontend (Next.js / Vercel)
        ↓
API Gateway (FastAPI + Nginx)
        ↓
Orchestration Engine (Claude-powered agents)
        ↓
Shared Memory (Redis) + PostgreSQL + Vector DB
        ↓
External Services (GitHub, Stripe, SendGrid, Claude)
```

### Design Principles

* **Async-first** (FastAPI + Celery)
* **Event-driven agents**
* **Zero-trust authentication (JWT + RLS)**
* **Horizontal scalability**
* **Enterprise observability**

---

## **Technology Stack**

### Frontend

* **Next.js 14 (App Router)**
* TypeScript
* TailwindCSS + Shadcn/UI
* Zustand (state)
* Supabase Client
* Stripe.js
* PostHog + Sentry
* Vercel Hosting

### Backend

* **FastAPI (Python 3.11)**
* Nginx (Reverse Proxy)
* Celery + Redis (Task Queue)
* SQLAlchemy (Async ORM)
* Supabase Auth (JWT)
* Railway Hosting

### Data Layer

* PostgreSQL (Supabase Managed)
* Redis (Shared Memory + Queue)
* Pinecone (Vector Database)
* Supabase Storage (S3-Compatible)

### AI & Security

* Claude Sonnet 4 (Primary LLM)
* Semgrep
* npm audit / safety
* OSV API
* pgvector (Code similarity search)

---

## **System Components**

### Orchestrator Engine

Responsible for:

* Task planning
* Agent spawning
* Progress monitoring
* Result synthesis
* Priority scoring

### Agent Subsystem

Each scan runs agents in parallel:

* Writes to shared memory
* Streams logs to dashboard
* Feeds results to the Orchestrator for synthesis

### Background Workers

Powered by Celery:

* Repository scanning
* Scheduled audits
* PDF generation
* Cleanup jobs
* Email notifications

---

## **Getting Started (Development Setup)**

### Prerequisites

Ensure you have:

* **Node.js 18+**
* **Python 3.11+**
* **Docker (optional but recommended)**
* **Redis**
* **PostgreSQL**
* **GitHub Account**
* **Supabase Project**
* **Claude API Key**
* **Stripe Account**

---

## **Repository Structure**

```
cortex-edr/
├── frontend/          # Next.js app
├── backend/           # FastAPI API
│   ├── app/
│   │   ├── api/       # Routes
│   │   ├── core/     # Config, security, middleware
│   │   ├── agents/   # Orchestrator + AI agents
│   │   ├── models/  # SQLAlchemy models
│   │   ├── services # GitHub, Stripe, Email, LLM
│   │   └── workers/ # Celery tasks
│   └── main.py
├── infrastructure/   # Nginx, Docker, CI/CD
└── docs/
```

---

## **Backend Setup (FastAPI)**

### 1. Create Virtual Environment

```bash
cd backend
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Environment Variables

Create `.env`:

```env
DATABASE_URL=postgresql+asyncpg://user:pass@localhost:5432/cortex
REDIS_URL=redis://localhost:6379
SUPABASE_JWT_SECRET=your_secret
CLAUDE_API_KEY=your_key
STRIPE_SECRET_KEY=your_key
SENDGRID_API_KEY=your_key
GITHUB_APP_PRIVATE_KEY=path_to_key.pem
```

### 4. Run Migrations

```bash
alembic upgrade head
```

### 5. Start API Server

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 6. Start Workers

```bash
celery -A app.workers worker --loglevel=info
celery -A app.workers beat --loglevel=info
```

---

## **Frontend Setup**

### Install Dependencies

```bash
cd frontend
npm install
```

### Environment Variables

Create `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=your_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_key
NEXT_PUBLIC_API_BASE_URL=http://localhost:8000
```

### Run Development Server

```bash
npm run dev
```

---

## **API Documentation**

Once running, access:

* **Swagger UI:**
  `http://localhost:8000/docs`
* **OpenAPI Spec:**
  `http://localhost:8000/openapi.json`

---

## **Scan Execution Flow**

1. Trigger via UI, GitHub webhook, or cron
2. Celery queues scan
3. Repo cloned and analyzed
4. Orchestrator plans agent execution
5. Agents run in parallel
6. Findings synthesized
7. Results stored and scored
8. GitHub issue created
9. Email/report sent
10. Dashboard updated live

---

## **Security Model**

* JWT-based authentication (Supabase)
* Row-Level Security (Postgres RLS)
* Role-based access
* API rate limiting (Nginx)
* Secrets vaulting
* Audit logs for webhooks and payments

---

## **Subscription Tiers**

| Tier       | Repos  | Scans | Features                  |
| ---------- | ------ | ----- | ------------------------- |
| Free       | 1      | 2/mo  | Basic scan, GitHub issues |
| Pro        | 10     | ∞     | AI remediation, reports   |
| Team       | 50     | ∞     | Slack, Jira, dashboards   |
| Enterprise | Custom | ∞     | SSO, SLA, Compliance      |

---

## **Monitoring & Observability**

* **Sentry** – Error tracking
* **Prometheus + Grafana** – Metrics
* **PostHog** – Product analytics
* **Structured JSON logs**
* **OpenTelemetry tracing**

---

## **Deployment**

### Production Stack

* Frontend: **Vercel**
* Backend: **Railway**
* Database: **Supabase**
* Cache/Queue: **Redis**
* Vector DB: **Pinecone**
* Storage: **Supabase S3**
* CDN: **Global Edge**

---

## **Roadmap**

* SOC 2 Compliance
* Enterprise SSO (SAML/OAuth)
* Jira Integration
* GitLab Support
* Custom Agent SDK
* On-Prem Deployment
* AI-Powered Auto-Fix PRs

---

## **Governance**

* Secure development lifecycle (SDLC)
* Mandatory PR reviews
* Automated security scans
* Quarterly dependency audits
* Data retention policies
* Compliance logging

---

## **License**

Copyright © 2026
**CortexEDR, Inc.**
All Rights Reserved.

---

## **Founder**

**Hamza Hafeez**
Founder & CEO
Founded: **February 1, 2026**

---

## **Contact**

Enterprise Sales & Partnerships
**[security@cortex-edr.com](mailto:security@cortex-edr.com)**
