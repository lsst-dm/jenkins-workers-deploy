# Static-Agents Guide

This repository contains the configuration of both dev and prod static agents. These agents are workers that are on the Google Cloud cluster 24/7, named `snowflake` and `manager`. They are normal statefulsets and are manually added to the cluster. 

## Setting up the Static Agents

1. Add the statefulset to the cluster.
2. In the Jenkins Helm chart, the agents are already configured as inbound agents with the names `manager-0/snowflake-0` for prod and `manager-dev-0/snowflake-dev-0` for dev. 
3. If the agents do not automatically connect, click on the agent in Jenkins. Copy the secret, change it to base64 and add it to the corresponding secret in GKE: 
- `manager-secret`/`snowflake-secret` for prod in the `jenkins` namespace, 
- `manager-dev-secret`/`snowflake-dev-secret` for dev in the `jenkins-dev` namespace.
4. Ensure the correct secret names are referenced in the statefulset. 

## Debugging Static Agents

The logs on the Jenkins control pods can be helpful to debug an agent disconnection. Ensure the name of the pod matches the name in the Jenkins UI, and that the secret name matches the secret referenced in the statefulset.