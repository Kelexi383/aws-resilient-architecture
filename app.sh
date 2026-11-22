#!/bin/bash
dnf install -y nginx
TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 300"`
IID=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id`
AZ=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone`
echo "<h1>CV0-004 Lab</h1><p>Instance: $IID</p><p>AZ: $AZ</p>" > /usr/share/nginx/html/index.html
echo ok > /usr/share/nginx/html/health
systemctl enable --now nginx
