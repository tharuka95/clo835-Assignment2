#!/bin/bash
yum -y update
yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user