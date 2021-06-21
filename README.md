# Infrastructure as Code Module Skeleton

This project is a skeleton for an Infrastructure as Code (IaC) module on AWS Cloud.

- EC2 instance populated with an `Ubuntu 20.04` base image
- [CloudInit](https://cloudinit.readthedocs.io/en/latest/) template configured with a `install.sh` as the initialization script
- Security Group with open SSH ingress and egress

## Install
1) Clone this repository
2) Modify skeleton to meet your requirements

## Usage
Mind referencing the correct `source` path and required inputs when invoking this module from another Terraform file.
```
module "myModule" {
  source = "./path/to/iac-module-skeleton"
  instanceName = "myModule"
}
```

## Inputs

  - `instanceName` Required
    
  - `instanceType` (Optional) Default: t2.micro
    
  - `diskSize` (Optional) Default: 8

  - `diskType` (Optional) Default: gp2
  
  - `diskEncrypted` (Optional) Default: true
  
  - `diskTermination` (Optional) Default: true

## Outputs
  - `module.myModule.ip` Instance Public IP
