# Infrastructure

## backend resources TODO list


### (global)
- [x] registration for decibelduck.com

### (each project)
- [x] iam service account
- [x] create a project
- [x] dns zone for decibelduck.com
- [x] state bucket for terraform
- [ ] parameter store for terraform
- [ ] vpc
    - [ ] igw
- [x] sql instance
- [x] secrets store
- [ ] gs bucket for files

### (each release)
- [ ] cloud run deployment


## New contributor, up and running

1. Install Python 3.8

2. Install gcloud sdk

    [Installer page](https://cloud.google.com/sdk/docs/install).

    <details><summary>Linux</summary>

    1. Download the current x86_64 release
    2. Install according to the instructions in the Linux tab
    3. Make sure to run `gcloud init` and log in
    </details>

    <details><summary>Mac OS</summary>

    1. Download the appropriate release tarball for your Mac
    2. Install according to the instructions in the macOS tab
    3. Make sure to run `gcloud init` and log in
    </details>

```
TBD!

New contributors will follow these steps to get a new dev environment.
cd infra
...
gcloud auth application-default login
...
```

----

## Rebuilding internal infrastructure?

### **These steps are for recreating the INTERNAL infrastructure.**
**Project contributors do not need to run these steps unless a catastrophe has occurred and we're starting over.**


```
cd infra
./tools/bootstrap-internal
gcloud auth application-default login
cd terraform/internal
terraform init
terraform plan -out plan.out
terraform apply
```