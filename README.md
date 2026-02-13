# Infrastructure
GitLab, Nexus CI/CD and other infrastructure pet project

1. Need to create folders gitlab/config, gitlab/data, gitlab/logs, nexus-data
2. add this param to Docker Engine config: `"insecure-registries": ["http://localhost:5001"]` 
