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
- [ ] firestore
- [ ] secrets store
- [ ] gs bucket for files

### (each release)
- [ ] cloud run deployment


## up and running from zero

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
cd infra
./tools/bootstrap-internal
gcloud auth application-default login
```

Create yourname.auto.tfvars

```
env_label = "yourname"
# extra_label = "anything you want, like a case number" (optional)
user_account_email = "your@email"
```
