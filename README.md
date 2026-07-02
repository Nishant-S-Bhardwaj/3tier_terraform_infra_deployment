# 🚀 Production-Ready AWS Infrastructure using Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws)
![DevOps](https://img.shields.io/badge/DevOps-Learning-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-In_Progress-success?style=for-the-badge)

---

# 📖 About this Project

This repository documents my journey of building a **production-inspired AWS Infrastructure** completely using **Terraform**.

Instead of provisioning infrastructure manually from the AWS Console, every networking, security, compute, scaling, and monitoring component is created as Infrastructure as Code (IaC).

The objective of this project is not only to automate infrastructure creation but also to understand **why each AWS service exists, how it communicates with other services, and how production cloud environments are designed.**

This project is intentionally built step-by-step, with every milestone maintained in a dedicated Git branch so the complete learning journey is preserved.

---

# 🏗 Current Architecture

> **Current Branch:** `networking`

![Networking Architecture](images/networking-architecture.png)
```



# 🎯 Project Objectives

The infrastructure is designed around the following goals:

- Build a reusable Infrastructure as Code project using Terraform.
- Understand AWS networking from scratch.
- Design a highly available Multi-AZ infrastructure.
- Implement secure communication between different infrastructure layers.
- Automate EC2 provisioning using Launch Templates.
- Maintain application availability using Auto Scaling Groups.
- Distribute traffic using Application Load Balancers.
- Monitor infrastructure health using CloudWatch.
- Learn production-level Terraform project structuring using modules.

---

# 🏗 High-Level Architecture

```text
                     Internet
                         │
                         ▼
              Internet Gateway
                         │
                         ▼
          External Application Load Balancer
                         │
                         ▼
            Frontend Target Group
                         │
                         ▼
          Frontend Auto Scaling Group
                         │
                         ▼
            Frontend EC2 Instances
                         │
                         ▼
          Internal Application Load Balancer
                         │
                         ▼
             Backend Target Group
                         │
                         ▼
          Backend Auto Scaling Group
                         │
                         ▼
             Backend EC2 Instances
```

---

# 🌐 Infrastructure Layers

```text
+----------------------------------------------------+
|                  AWS Cloud                         |
|                                                    |
|   +--------------------------------------------+   |
|   |                VPC                         |   |
|   |                                            |   |
|   |  Public Subnets                            |   |
|   |     │                                      |   |
|   |     ├── Internet Gateway                   |   |
|   |     ├── NAT Gateway                        |   |
|   |     └── External ALB                       |   |
|   |                                            |   |
|   |--------------------------------------------|   |
|   |                                            |   |
|   | Private Application Subnets                |   |
|   |     ├── Frontend ASG                       |   |
|   |     ├── Backend ASG                        |   |
|   |     └── Internal ALB                       |   |
|   |                                            |   |
|   |--------------------------------------------|   |
|   |                                            |   |
|   | Private Database Subnets                   |   |
|   |     └── Reserved                           |   |
|   |                                            |   |
|   +--------------------------------------------+   |
+----------------------------------------------------+
```

---

# 🔄 Complete Resource Dependency Graph

Terraform provisions resources in the following dependency order.

```text
Terraform

│

▼

AWS Provider

│

▼

VPC

│

├─────────────┐
│             │

▼             ▼

Public      Private
Subnets     Subnets

│             │

│             ├────────────┐
│             │            │

▼             ▼            ▼

IGW         Security     Route Tables

│             │

▼             ▼

NAT Gateway  IAM Role

│             │

▼             ▼

Public RT   Instance Profile

│             │

└──────┐      ▼

       ▼

Launch Templates

       │

       ▼

Auto Scaling Groups

       │

       ▼

Target Groups

       │

       ▼

Application Load Balancers

       │

       ▼

Listeners

       │

       ▼

CloudWatch

       │

       ▼

Scaling Policies

       │

       ▼

SNS Alerts
```

---

# 🌍 End-to-End Request Flow

The following diagram shows how a client request travels through the infrastructure.

```text
User

│

▼

DNS

│

▼

External ALB

│

▼

Listener :80

│

▼

Frontend Target Group

│

▼

Healthy Frontend EC2

│

▼

Internal ALB

│

▼

Backend Target Group

│

▼

Healthy Backend EC2

│

▼

Application Response

│

▼

User
```

---

# 📂 Repository Structure

```text
.
├── modules
│
├── vpc
│      ├── main.tf
│      ├── subnet.tf
│      ├── routes.tf
│      ├── nat.tf
│      ├── internet_gateway.tf
│      └── outputs.tf
│
├── security
│      ├── security_groups.tf
│      └── outputs.tf
│
├── compute
│      ├── iam.tf
│      ├── launch_template.tf
│      ├── autoscaling.tf
│      └── outputs.tf
│
├── alb
│      ├── alb.tf
│      ├── listeners.tf
│      ├── target_groups.tf
│      └── outputs.tf
│
├── monitoring
│      ├── cloudwatch.tf
│      ├── sns.tf
│      └── scaling_policy.tf
│
├── provider.tf
├── variables.tf
├── main.tf
├── dev.tfvars
└── README.md
```

---

# 🌿 Learning Branch Strategy

Rather than building everything in a single commit, each infrastructure milestone has its own Git branch.

| Branch | Description | Status |
|----------|-------------|---------|
| `networking` | VPC, Subnets, Route Tables, NAT Gateway | ✅ |
| `security` | Security Groups, IAM Role | ✅ |
| `compute-autoscaling` | Launch Templates, ASG, ALB | ✅ |
| `monitoring` | CloudWatch, SNS, Scaling Policies | 🚧 |
| `final-production` | Complete Infrastructure | 🚧 |

# 🌐 Networking Layer

The networking layer is the foundation of the entire infrastructure. Every AWS resource created later—including Security Groups, EC2 instances, Load Balancers, and Auto Scaling Groups—depends on the network being available.

Without networking, nothing else can exist.

---

# Why Networking Comes First

Think of building a smart city.

Before constructing buildings, roads, or installing electricity, you first need land.

AWS follows exactly the same concept.

```text
Buy Land
     │
     ▼
Divide Land
     │
     ▼
Create Roads
     │
     ▼
Construct Buildings
```

AWS Equivalent

```text
VPC
     │
     ▼
Subnets
     │
     ▼
Route Tables
     │
     ▼
Internet Gateway / NAT Gateway
     │
     ▼
EC2 • ALB • RDS
```

---

# 🏗 Step 1 — Virtual Private Cloud (VPC)

## Purpose

A Virtual Private Cloud (VPC) creates an isolated private network inside AWS.

It acts as the network boundary where every other AWS resource is deployed.

No resource such as EC2, RDS, ALB, or Security Group can exist without a VPC.

---

## Real World Analogy

Imagine purchasing a large piece of land.

Only after purchasing the land can you:

- Divide plots
- Construct roads
- Build houses
- Install security
- Connect utilities

The VPC is that piece of land.

---

## Dependency Graph

```text
VPC

│

├── Public Subnets

├── Private Subnets

├── Route Tables

├── Internet Gateway

├── NAT Gateway

├── Security Groups

├── EC2

├── Load Balancers

└── Database
```

Everything depends on the VPC.

---

## Terraform Resource

```hcl
resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_support = true

  enable_dns_hostnames = true

}
```

---

# 🌍 Step 2 — Subnets

## Why Subnets?

A VPC is usually very large.

Example

```
10.0.0.0/16
```

contains over **65,000 IP addresses**.

Managing everything inside one huge network would be inefficient.

Instead, we divide the VPC into smaller logical sections called **Subnets**.

---

## Subnets Created

### Public Subnets

```text
Public Subnet 1

10.0.1.0/24

AZ-1
```

```text
Public Subnet 2

10.0.2.0/24

AZ-2
```

Purpose

- External ALB
- NAT Gateway
- Bastion Host (Future)

---

### Private Application Subnets

```text
Private App Subnet 1

10.0.11.0/24
```

```text
Private App Subnet 2

10.0.12.0/24
```

Purpose

- Frontend EC2
- Backend EC2
- Auto Scaling Groups

These instances are never directly exposed to the Internet.

---

### Database Subnets

```text
10.0.21.0/24

10.0.22.0/24
```

Reserved for future database deployment.

---

## Multi Availability Zone Design

Instead of keeping everything inside one data center, resources are distributed across two Availability Zones.

```text
             AWS Region

     ap-south-1

     ┌───────────────┐

     │               │

AZ-1 │               │ AZ-2

     │               │

     └───────────────┘
```

Our Deployment

```text
AZ-1

├── Public Subnet 1

├── Private App 1

└── Database 1

AZ-2

├── Public Subnet 2

├── Private App 2

└── Database 2
```

---

## Why Multiple AZs?

If one Availability Zone fails,

```text
AZ-1 ❌

↓

Traffic automatically moves

↓

AZ-2 ✅
```

This increases availability and fault tolerance.

---

# 🌍 Step 3 — Internet Gateway

## Problem

The VPC is completely isolated.

Resources inside it cannot communicate with the Internet.

---

## Solution

Attach an Internet Gateway.

```text
Internet

│

▼

Internet Gateway

│

▼

VPC
```

The Internet Gateway acts as the entrance and exit gate of the VPC.

---

## Important

The Internet Gateway is attached to the **VPC**, not individual subnets.

Why?

Because multiple subnets inside the same VPC can share one gateway.

```text
VPC

│

├── Public Subnet 1

├── Public Subnet 2

├── Private Subnet 1

└── Private Subnet 2

        │

        ▼

One Internet Gateway
```

---

# 🌍 Step 4 — Route Tables

Having an Internet Gateway does **not** automatically give Internet access.

AWS still needs to know where traffic should go.

That responsibility belongs to the Route Table.

---

## Public Route Table

```text
Destination

0.0.0.0/0

↓

Internet Gateway
```

Meaning

"If traffic is going anywhere outside this VPC, send it to the Internet Gateway."

---

## Dependency

```text
Public Subnet

↓

Route Table Association

↓

Public Route Table

↓

Internet Gateway

↓

Internet
```

---

## Route Table Association

A Route Table has no effect until it is associated with a subnet.

```text
Subnet

↓

Association

↓

Route Table
```

Without this association, the subnet uses the default VPC route table.

---

# 🌍 Step 5 — NAT Gateway

## Problem

Private EC2 instances should download updates, install packages, or contact AWS APIs.

However,

they should **NOT** receive traffic directly from the Internet.

---

## Solution

Use a NAT Gateway.

```text
Private EC2

↓

Private Route Table

↓

NAT Gateway

↓

Internet Gateway

↓

Internet
```

---

## Why NAT Gateway Lives in Public Subnet

The NAT Gateway itself needs Internet access.

Therefore,

AWS requires it to be deployed inside a Public Subnet.

```text
Public Subnet

↓

Elastic IP

↓

NAT Gateway

↓

Private EC2
```

---

# 🌍 Elastic IP

Every NAT Gateway requires one static public IP.

AWS provides this using an Elastic IP.

```text
Elastic IP

↓

NAT Gateway

↓

Private EC2
```

---

# 🌍 Private Route Table

Unlike Public Route Tables,

Private Route Tables send external traffic to the NAT Gateway instead of the Internet Gateway.

```text
Destination

0.0.0.0/0

↓

NAT Gateway
```

---

## Complete Networking Flow

### Public Resources

```text
Internet

↓

Internet Gateway

↓

Public Route Table

↓

Public Subnet

↓

External ALB
```

---

### Private Resources

```text
Private EC2

↓

Private Route Table

↓

NAT Gateway

↓

Internet Gateway

↓

Internet
```

Notice that the Internet can never directly reach the Private EC2.

Only outbound communication is allowed.

---

# 🧩 Complete Networking Dependency Graph

```text
VPC

│

├──────────────┐

│              │

▼              ▼

Public      Private

Subnets     Subnets

│              │

▼              ▼

IGW       Private RT

│              │

▼              ▼

Public RT   NAT Gateway

│              ▲

▼              │

Route Table Association

│

▼

Public Resources

(ALB, NAT)
```

---

# 💡 Key Takeaways

✅ VPC is the network boundary.

✅ Subnets divide the network into logical sections.

✅ Multiple AZs improve availability.

✅ Internet Gateway connects the VPC to the Internet.

✅ Route Tables decide where traffic goes.

✅ Route Table Associations apply routing rules to subnets.

✅ NAT Gateway provides secure outbound Internet access for private resources.

✅ Elastic IP gives the NAT Gateway a static public IP.

Without this networking layer, no compute, security, or load balancing resources could be deployed.

---

# 🔜 Next Section

The next layer is **Security**, where we'll build communication rules using:

- Security Groups
- IAM Roles
- IAM Instance Profiles

These resources determine **who is allowed to communicate with whom** inside the infrastructure.

# 🔒 Security Layer

Networking provides connectivity, but it does **not** control who is allowed to communicate.

The Security Layer protects every component by enforcing the **Principle of Least Privilege**—each resource only receives the traffic it actually needs.

---

# Why Security Groups?

Security Groups act as **virtual firewalls** attached to AWS resources.

Instead of protecting an entire subnet, they protect individual resources like:

- Application Load Balancers
- EC2 Instances
- RDS Databases

Every inbound and outbound packet is checked against Security Group rules before AWS allows the connection.

---

# Security Group Communication Flow

```text
                 Internet
                     │
                     ▼
            ALB Security Group
                     │
                     ▼
        Frontend Security Group
                     │
                     ▼
         Backend Security Group
                     │
                     ▼
         Database Security Group
```

Each layer can communicate **only** with the layer immediately behind it.

---

# Security Groups Created

## External ALB Security Group

Purpose

- Accept HTTP (80)
- Accept HTTPS (443)
- Forward traffic to Frontend EC2

```text
Internet

↓

ALB SG

↓

Frontend SG
```

---

## Frontend Security Group

Allows

- HTTP only from ALB Security Group

Blocks

- Direct Internet access

```text
ALB SG

↓

Frontend EC2
```

---

## Backend Security Group

Allows

- HTTP traffic only from Frontend Security Group

```text
Frontend SG

↓

Backend SG
```

---

## Database Security Group (Reserved)

Allows

- MySQL (3306)
- PostgreSQL (5432)

Only from Backend Security Group.

```text
Backend SG

↓

Database SG
```

---

# IAM Role & Instance Profile

EC2 instances should never store AWS credentials.

Instead,

AWS provides temporary credentials using IAM Roles.

```text
EC2

↓

Instance Profile

↓

IAM Role

↓

AWS Services
```

This improves security while eliminating credential management.

---

# 💻 Compute Layer

The Compute Layer is responsible for running the application.

Instead of manually launching EC2 instances, Terraform creates reusable templates that Auto Scaling Groups use whenever new instances are required.

---

# Launch Templates

A Launch Template is a blueprint for creating EC2 instances.

It defines:

- Amazon Machine Image (AMI)
- Instance Type
- Key Pair
- IAM Instance Profile
- Security Group
- Storage Configuration

Instead of configuring EC2 repeatedly, AWS simply launches new instances from this template.

---

# Compute Dependency Graph

```text
IAM Role

↓

Instance Profile

↓

Launch Template

↓

Auto Scaling Group

↓

EC2 Instances
```

---

# Auto Scaling Groups

Auto Scaling Groups ensure the application remains available.

Responsibilities

- Launch new instances
- Replace unhealthy instances
- Maintain desired capacity
- Scale infrastructure automatically

Current Configuration

```text
Desired Capacity : 2

Minimum Capacity : 2

Maximum Capacity : 4
```

---

# Auto Scaling Flow

```text
Launch Template

↓

Auto Scaling Group

↓

EC2 Instance

↓

Health Check

↓

Healthy

or

Replace Instance
```

---

# Scaling Policies

Scaling Policies automatically increase or decrease the number of EC2 instances.

## Scale Out

```text
CPU > 70%

↓

CloudWatch Alarm

↓

Scale Out Policy

↓

Launch New EC2
```

---

## Scale In

```text
CPU < 30%

↓

CloudWatch Alarm

↓

Scale In Policy

↓

Terminate EC2
```

---

# 🌐 Load Balancing Layer

The Load Balancer distributes incoming traffic across multiple EC2 instances.

This prevents one server from becoming overloaded while improving availability.

---

# External Application Load Balancer

Purpose

- Internet-facing
- Receives client requests
- Distributes traffic to Frontend EC2

```text
Internet

↓

External ALB

↓

Frontend Target Group

↓

Frontend EC2
```

---

# Internal Application Load Balancer

Purpose

- Private
- Routes requests between application layers

```text
Frontend EC2

↓

Internal ALB

↓

Backend Target Group

↓

Backend EC2
```

---

# Target Groups

Target Groups maintain the list of EC2 instances that receive traffic.

The Load Balancer never communicates directly with EC2.

Instead,

```text
ALB

↓

Target Group

↓

Healthy EC2
```

Health checks ensure only healthy instances receive requests.

---

# Listeners

Listeners define what should happen when requests arrive.

Example

```text
Port 80

↓

Forward

↓

Frontend Target Group
```

---

# Complete Request Flow

```text
User

↓

DNS

↓

External ALB

↓

HTTP Listener

↓

Frontend Target Group

↓

Healthy Frontend EC2

↓

Internal ALB

↓

Backend Target Group

↓

Healthy Backend EC2

↓

Application Response
```

---

# 📈 Monitoring Layer

CloudWatch continuously monitors infrastructure health.

Metrics include

- CPU Utilization
- Network Traffic
- Instance Health
- Auto Scaling Metrics

---

# Monitoring Flow

```text
EC2 Metrics

↓

CloudWatch

↓

Alarm

↓

SNS Notification

↓

Administrator
```

---

# SNS Notifications

When CloudWatch detects abnormal conditions,

SNS immediately sends alerts.

Examples

- Email
- SMS
- Lambda
- Webhooks

---

# Complete Infrastructure Dependency Graph

```text
Terraform

↓

AWS Provider

↓

VPC

↓

Subnets

↓

Internet Gateway

↓

Route Tables

↓

Security Groups

↓

IAM Role

↓

Instance Profile

↓

Launch Templates

↓

Auto Scaling Groups

↓

Target Groups

↓

Application Load Balancers

↓

Listeners

↓

CloudWatch

↓

Scaling Policies

↓

SNS Alerts
```

---

# Terraform Workflow

Terraform follows the same lifecycle every time infrastructure is deployed.

```bash
terraform init

terraform fmt

terraform validate

terraform plan -var-file="dev.tfvars"

terraform apply -var-file="dev.tfvars"

terraform destroy -var-file="dev.tfvars"
```

---

# Repository Module Structure

```text
modules/

├── vpc
│
├── security
│
├── compute
│
├── alb
│
└── monitoring
```

Each module manages one layer of infrastructure, making the project modular and reusable.

---

# Production Best Practices

✔ Use Modules

✔ Store variables separately

✔ Never hardcode secrets

✔ Enable Multi-AZ deployment

✔ Use Security Groups instead of exposing resources publicly

✔ Keep EC2 instances inside Private Subnets

✔ Expose only the Load Balancer to the Internet

✔ Monitor infrastructure using CloudWatch

✔ Use Auto Scaling instead of manually managing EC2 instances

---

# Common Interview Questions

### Why create a VPC first?

Every AWS resource must belong to a network.

---

### Why use two Availability Zones?

To improve availability and tolerate failures in a single data center.

---

### Difference between Internet Gateway and NAT Gateway?

Internet Gateway provides two-way Internet communication for public resources.

NAT Gateway provides outbound Internet access for private resources without exposing them publicly.

---

### Why use Launch Templates?

They provide a reusable blueprint for creating identical EC2 instances.

---

### Why use Auto Scaling Groups?

To maintain availability and automatically replace failed instances.

---

### Why use a Load Balancer?

To distribute incoming traffic across multiple healthy EC2 instances.

---

### Why Target Groups?

The Load Balancer forwards requests to Target Groups, and Target Groups determine which healthy EC2 instances receive the traffic.

---

# Future Improvements

- Remote Terraform Backend (S3 + DynamoDB)
- CI/CD Pipeline using GitHub Actions
- HTTPS using AWS Certificate Manager
- AWS WAF
- Route 53 Custom Domain
- Kubernetes (Amazon EKS)
- Blue-Green Deployment
- Infrastructure Testing

---

# Conclusion

This project demonstrates how to design and automate a production-inspired AWS infrastructure using Terraform.

Instead of provisioning resources manually, the complete infrastructure is built using reusable Terraform modules following Infrastructure as Code (IaC) principles.

Throughout this project, I learned how networking, security, compute, load balancing, monitoring, and auto scaling work together as a complete cloud infrastructure rather than as isolated AWS services.

The project also strengthened my understanding of resource dependencies, Terraform execution flow, and production architecture design—skills that are directly applicable to modern DevOps and Cloud Engineering roles.

---

# 👨‍💻 Author

**Nishant Bhardwaj**

- 🌐 GitHub: https://github.com/Nishant-S-Bhardwaj
- 💼 LinkedIn: https://linkedin.com/in/Nishant0Bhardwaj
- 🌍 Portfolio: https://nishant-portfolio-kappa-six.vercel.app

⭐ If you found this project useful, consider giving it a star.
