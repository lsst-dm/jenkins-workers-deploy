# jenkins-workers-deploy
Rubin DM Jenkins worker deployment at Google Cloud Kubernetes engine (prompt-proto). Agents are connected via port 20000 to a kubernetes service at SLAC via the external IP and port number. Agents may also be connected via WebSocket in the form:
<br /> 
```
- name: JSWARM_OTHER_ARGS
  value: -webSocket
```
