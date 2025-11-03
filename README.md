# 3-Tier Cloud-Native Application on Azure Kubernetes Service (AKS)
## Final Project — SDA x IronHacks DevOps & Cloud Computing Bootcamp -Team 3
---

## 📌 Overview
This repository demonstrates the re-architecture and migration of a traditional 3-tier web application into a cloud-native, loosely coupled system deployed on Azure Kubernetes Service (AKS).
Originally hosted on a tightly coupled Azure setup (VMs, Web Apps, and Azure SQL), the system experienced scaling limitations, slow response times, and manual, fragile deployments.
Our mission was to modernize the platform for scalability, high availability, observability, and automated delivery using GitHub Actions, Terraform, and Azure-native services.

---

## 🧩 Architecture Summary

| Layer             | Technology                     | Description                                               |
| ----------------- | ------------------------------ | --------------------------------------------------------- |
| **Frontend**      | React + TypeScript + Vite      | Containerized SPA served via Ingress (NGINX/AGIC)         |
| **Backend**       | Spring Boot (Java 21)          | REST API deployed to AKS (ClusterIP service)              |
| **Database**      | Azure SQL (Private Endpoint)   | Managed relational database for production                |
| **Orchestration** | AKS (2+ node pools)            | System & user node pools, autoscaling enabled             |
| **Networking**    | Azure VNet                     | Private subnets, secure communication, ingress controller |
| **Secrets**       | Azure Key Vault + CSI          | Centralized, secure secret management                     |
| **Registry**      | Docker Hub                     | Stores signed and immutable container images              |
| **Monitoring**    | Prometheus + Grafana           | End-to-end observability for workloads and cluster health |


---

## 🏗️ Architecture Diagram
<p align="center">
<img width="1920" height="1080" alt="Project Diagram" src="https://github.com/user-attachments/assets/4933b97a-5634-4477-9a0f-86ac848e55a1" />
</p>

### Key Features
- AKS Cluster with autoscaling  
- Ingress Controller (NGINX or AGIC) with TLS  
- Azure SQL behind a Private Endpoint  
- Key Vault + CSI for secure secrets  
- Prometheus & Grafana monitoring stack  
- Network isolation and RBAC  

---

## ⚙️ Automation: GitHub Actions + Terraform

### 🔹 Infrastructure as Code (IaC)
- Managed with **Terraform**
- Stored in `terraform/` directory
- Executed via **GitHub Actions**
- Remote backend on Azure Storage for state locking


**Resources Provisioned:**
- AKS Cluster  
- Azure SQL (Private Endpoint)  
- ACR  
- Key Vault  
- Log Analytics + Monitoring  

---

### 🔹 CI/CD Pipelines

<p align="center">
  <img src="https://github.com/user-attachments/assets/3b48f8d1-51d6-4794-8b76-5b681ac713f7"
       alt="Frontend-Backend CI/CD Flow"
       width="1000" />
</p>

#### Frontend
- Triggered on changes in `frontend/**`
- Build → Test → Containerize → Push → Deploy
- Health checks and rolling updates with no downtime

#### Backend
- Triggered on changes in `backend/**`
- Unit & integration tests
- Immutable tagging (no `:latest`)
- Helm or K8s manifest deployment

---

## 🔒 Security & Compliance
- **Secrets:** Managed via Azure Key Vault (no plaintext)  
- **Auth:** GitHub OIDC → Azure (no static credentials)  
- **RBAC:** Least privilege service accounts  
- **Private Networking:** SQL via private endpoint  
- **Images:** Scanned, signed, immutable  
- **Network Policies:** Restrict access between namespaces  

---

## 📊 Observability
- **Stack:** Prometheus + Grafana + Alertmanager  
- **Dashboards:** API latency, error rates, saturation, pod health  
- **Alerts:** High error rate, pod crash, unschedulable pods  
- **Runbooks:** Deployment, rollback, scaling, secret rotation  

---

## 🧱 Reference Repositories
This project builds upon the official bootcamp application:  
[github.com/saurabhd2106/devops-project2-ih](https://github.com/saurabhd2106/devops-project2-ih)  
---

## 👥 Team Members
| Name                | GitHub                                                       |
| -------------       | ------------------------------------------------------------ |
| Zainb Al-Atawi      | [@zainbsuliman](https://github.com/zainbsuliman)             |
| Shahad Al-Johani    | [@Elenore68](https://github.com/Elenore68)                   |
| Abdulkarim Al-Sahli | [@Abdulkarim-Alsahli](https://github.com/Abdulkarim-Alsahli) |
| Wafa Allihaibi      | [@Waf-DPM-dev](https://github.com/Waf-DPM-dev)               |
| Shada Haddad        | [@Shada11haddad](https://github.com/Shada11haddad)           |
| Shouq Alsulami      | [@76ilq](https://github.com/76ilq)                           |


---

## 🎥 Presentation / Demo
🎬 [Watch the Presentation](https://drive.google.com/file/d/1b8uBTV1va76lS0mKsL4AHqCaI-zlEU-x/view?usp=sharing)

