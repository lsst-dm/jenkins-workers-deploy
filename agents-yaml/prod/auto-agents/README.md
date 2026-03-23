# Auto-Agents Guide

This repository contains the configuration of both dev and prod auto-agents. These agents are workers that are dynamically provisioned by Google Cloud to run when a job requests an agent matching its label and type. Auto-agents can either be linux-x86 or aarch64 machines, named `idf-agent-ldfc` and `idf-agent-ldfc-arch`, respectively.

## Setting up the Auto-Agents

The auto-agents are not a normal statefulset and should NOT be manually added to the cluster. The auto-agent pod templates are defined in the Jenkins helm chart. Any changes should be applied to the values file in `jenkins-dm-jobs` to ensure the changes persist. 

## Testing and Debugging Auto-Agents
You can test a change for the auto-agents using the dev Jenkins at [ci-dev.lsst.org](ci-dev.lsst.org). A quick way to test is to change the pod templates under `Manage Jenkins > Clouds > gke > Pod Templates`. Ensure you are editing the correct machine type. Once saved, the new auto-agent should have your change for testing. Add the change to the values file in `jenkins-dm-jobs` once testing is finished, and schedule an upgrade to persist the changes.