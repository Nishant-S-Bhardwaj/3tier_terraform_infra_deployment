# 🚀 AWS 3-Tier Infrastructure Deployment using Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws)
![Status](https://img.shields.io/badge/Status-Networking_Completed-success?style=for-the-badge)
![Learning](https://img.shields.io/badge/Learning-In_Public-blue?style=for-the-badge)

---

# 📖 About This Project

This repository documents my journey of building a **production-inspired AWS 3-Tier Infrastructure** completely from scratch using **Terraform**.

Instead of pushing the final code all at once, every major infrastructure layer is developed on a dedicated Git branch, allowing anyone to follow the project step-by-step just like a real-world infrastructure development lifecycle.

The goal is not just to build infrastructure—but to understand **why** each AWS service exists, **how** they communicate, and **how** production-grade cloud infrastructure is designed.

---

# 🎯 Learning Ladder

```
🏁 Start

│

├── ✅ Branch 1 : Networking
│       ├── VPC
│       ├── Public & Private Subnets
│       ├── Internet Gateway
│       ├── Route Tables
│       ├── NAT Gateway
│       └── Multi-AZ Networking
│

├── ⏳ Branch 2 : Security
│       ├── Security Groups
│       ├── NACLs
│       └── IAM Roles
│

├── ⏳ Branch 3 : Compute
│       ├── EC2
│       ├── Launch Templates
│       └── Auto Scaling Groups
│

├── ⏳ Branch 4 : Load Balancing
│       ├── Application Load Balancer
│       ├── Target Groups
│       └── Health Checks
│

├── ⏳ Branch 5 : Database
│       ├── RDS
│       ├── DB Subnet Groups
│       └── Multi-AZ Database
│

├── ⏳ Branch 6 : Observability
│       ├── CloudWatch
│       ├── SNS
│       ├── Alarms
│       └── Monitoring
│

└── 🚀 Final Production Infrastructure
```

---

# 🌿 Branch Strategy

Each branch represents a complete milestone in the infrastructure.

| Branch | Description | Status |
|---------|-------------|--------|
| `networking` | AWS Networking Foundation | ✅ Completed |
| `security` | Security Groups & IAM | ⏳ Planned |
| `compute` | EC2 & Auto Scaling | ⏳ Planned |
| `load-balancer` | Application Load Balancer | ⏳ Planned |
| `database` | Amazon RDS | ⏳ Planned |
| `observability` | Monitoring & Alerts | ⏳ Planned |
| `main` | Fully integrated production architecture | ⏳ Final |

---

# 🏗 Current Architecture

> **Current Branch:** `networking`

![Networking Architecture](images/networking-architecture.png)
```

---

# 📦 Networking Components

### VPC

| Resource | Configuration |
|----------|---------------|
| CIDR | `10.0.0.0/16` |
| DNS Support | ✅ |
| DNS Hostnames | ✅ |

### Public Subnets

| Name | CIDR | AZ |
|------|------|----|
| Public-1 | `10.0.1.0/24` | ap-south-1a |
| Public-2 | `10.0.2.0/24` | ap-south-1b |

### Private Application Subnets

| Name | CIDR | AZ |
|------|------|----|
| App-1 | `10.0.11.0/24` | ap-south-1a |
| App-2 | `10.0.12.0/24` | ap-south-1b |

### Private Database Subnets

| Name | CIDR | AZ |
|------|------|----|
| DB-1 | `10.0.21.0/24` | ap-south-1a |
| DB-2 | `10.0.22.0/24` | ap-south-1b |

---

# 🌍 Network Traffic Flow

## Public Traffic

```
Internet
      │
Internet Gateway
      │
Public Route Table
      │
Public Subnets
```

## Private Traffic

```
Private EC2
      │
Private Route Table
      │
NAT Gateway
      │
Internet Gateway
      │
Internet
```

---

# 📂 Repository Structure

```text
.
├── modules
│   └── vpc
│       ├── main.tf
│       ├── subnet.tf
│       ├── internet_gateway.tf
│       ├── nat_gateway.tf
│       ├── route_tables.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── provider.tf
├── version.tf
├── variables.tf
├── dev.tfvars
└── README.md
```

---

# ⚙ Terraform Workflow

```bash
terraform init

terraform fmt

terraform validate

terraform plan -var-file="dev.tfvars"

terraform apply -var-file="dev.tfvars"

terraform destroy -var-file="dev.tfvars"
```

---

# 📚 Key Concepts Learned

- Infrastructure as Code (IaC)
- Terraform Modules
- Variable Management
- CIDR Planning
- AWS VPC Design
- Multi-AZ Networking
- Public vs Private Networking
- Internet Gateway
- Route Tables
- NAT Gateway
- Route Table Associations

---

# 📌 What's Next?

The next milestone is the **Security Layer**, where I'll implement:

- Security Groups
- IAM Roles
- Least Privilege Access
- Network Security Design

---

# 👨‍💻 Author

**Nishant Bhardwaj**

Building production-inspired cloud infrastructure while documenting the learning journey.

⭐ If you found this repository useful, consider giving it a star.
