# jenkins-workers-deploy
Rubin DM Jenkins worker deployment at Google Cloud Kubernetes engine (prompt-proto). 

Agents are deployed via kubernetes statefulset, under `agents-yaml`. Copy these yaml files and use `kubectl apply -f <filename>` to redeploy a static agent. Auto-agents are also defined in this directory under `auto-agents`, follow the instructions there to manage them.
Helm values files for services on the cluster are available under `helm-charts`. 
