# AWS Resilient Cloud Architecture Lab

## Overview
This repository documents a hands-on lab completed as part of the CompTIA Cloud+ (CV0-004) curriculum. The goal was to take a fragile, single-server application and transform it into a resilient, highly available, multi-AZ three-tier architecture on AWS.

## Architecture Diagram
Internet -> ALB (Public Subnets) -> Auto Scaling Group (EC2) -> RDS Multi-AZ (Private Subnets)
                                      |
                                   S3 Bucket (Object Storage)

## Technologies Used
- **Compute:** Amazon EC2 (t3.micro), Auto Scaling Groups, Launch Templates
- **Networking:** Amazon VPC, Public/Private Subnets, Internet Gateway, Application Load Balancer (ALB)
- **Database:** Amazon RDS (MySQL) with Multi-AZ failover
- **Storage:** Amazon S3 (Object) and Amazon EBS (Block)
- **Security:** Security Groups (least privilege), IAM, AWS Secrets Manager

## Key Concepts Proven
1. **High Availability:** Deployed resources across two Availability Zones (AZs). Proved fault tolerance by terminating an active EC2 instance under load; the ALB routed traffic to the healthy instance, and the ASG automatically launched a replacement.
2. **Elasticity:** Configured a Target Tracking Scaling Policy to automatically scale instances based on average CPU utilization (target 50%).
3. **Disaster Recovery (RTO/RPO):** Forced an RDS Multi-AZ failover, measuring a real Recovery Time Objective (RTO) of ~75 seconds with an RPO of ~0 (synchronous replication).
4. **Stateless Design:** Web tier is stateless. Session and application data are offloaded to RDS and S3, allowing instances to be treated as disposable.

## Setup & Execution
The lab was executed entirely via the **AWS CLI** in AWS CloudShell (Amazon Linux 2023).
- `app.sh`: Contains the EC2 user-data script to bootstrap Nginx, utilizing IMDSv2 for secure metadata retrieval.
- *Note: Environment variables (`env.sh`) are excluded via `.gitignore` for security.*

## Cost Management
Strict cleanup procedures were followed immediately after testing to ensure all billable resources (ALB, RDS, EC2) were destroyed, keeping the total lab cost under $0.20.
