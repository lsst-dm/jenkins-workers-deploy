# jenkins-workers-deploy
Rubin DM Jenkins worker deployment at Google Cloud Kubernetes engine (prompt-proto). Agents are connected via port 20000 to a kubernetes service at SLAC via the external IP and port number. Agents may also be connected via WebSocket in the form:
<br /> 

```
- name: JSWARM_OTHER_ARGS
  value: -webSocket
```
Agents are deployed via kubernetes statefulset, under `agents-yaml`. Copy these yaml files and use `kubectl apply -f <filename>` to redeploy an agent. Helm swarm templates are available under `swarm-agent-helm`. 
