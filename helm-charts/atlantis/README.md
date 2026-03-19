# Atlantis Guide

This repository contains the configuration and operational procedures for `Atlantis`, our primary tool for checking and automating Terraform workflows via Pull Requests.

---
## What is Atlantis?

`Atlantis` is an application that listens for webhooks from our GitHub. It allows teams to run `terraform plan` and `apply` directly from Pull Request comments, ensuring that infrastructure changes are transparent, reviewed, and executed from a centralized environment.

### Core Benefits
* **Visibility:** Everyone can see the output of the plan in the PR comment.
* **Locking:** Prevents two people from modifying the same state file at once by "locking" the project to a specific PR.
* **Compliance:** Ensures that `apply` only happens after a PR is approved.

---
## How to Use Atlantis

Once a Pull Request is opened with changes to Terraform files you can interact with it using comments:

### 1. Plan
To manually trigger a plan:
```text
atlantis plan
```

### 2. Review
Review the output from the `atlantis-ci-atlantis-lsst-cloud` bot comment. Components to be <span style="color:red">removed</span> will be highleted in <span style="color:red">red</span>, components to be <span style="color:green">added</span> will be highleted in <span style="color:green">green</span>. The bottom of the comment will show the plan and how many components will be added, changed or destroyed. 
* Ensure a reveiwer signs off on any changes!

### 3. Apply
Once the PR has been reviewed and approved, you can apply these changes to our google cloud `prompt-proto` project with the following:
```text
atlantis apply
```

### 4. Unlock
Locks and plans after `atlantis apply` will be removed. If you need to close the PR without applying, or want to delete plans and locks, do `atlantis unlock`. This is not required if you did `atlantis apply`.

### 5. URL
Our atlantis app is located at [ci-atlantis.lsst.cloud](ci-atlantis.lsst.cloud), with username and password in the `atlantis-creds` secret in the `atlantis` namespace. Here you can view locks and disable apply commands if need be. 

---
## Upgrade Helm Procedure

We use the official Atlantis Helm chart for deployments.

Chart Source: [Atlantis](https://runatlantis.github.io/helm-charts)

Namespace: `atlantis`

### Add the official repository
```bash
helm repo add atlantis https://runatlantis.github.io/helm-charts
helm repo update
```

### Upgrade the release
Use the values file listed in this repo.
```bash
helm upgrade atlantis runatlantis/atlantis -n atlantis -f values-atlantis.yaml
```
