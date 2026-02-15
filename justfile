images_catalog_in_nexus:
    curl http://localhost:5001/v2/_catalog
docker_login:
    docker login localhost:5001
install_software_to_runner:
    docker exec -it gitlab-runner bash -c "
      apt-get update && \
      apt-get install -y docker.io curl git && \
      apt-get clean
    "
install_sudo:
    apt-get update && apt-get install -y sudo
add_runner_to_docker_group:
    sudo usermod -aG docker gitlab-runner
registration:
    docker exec -it gitlab-runner gitlab-runner register \
      --non-interactive \
      --url "http://gitlab:8929" \
      --clone-url "http://gitlab:8929" \
      --registration-token "glrt-IVHhYzWSlAs6dFnYLSosS286MQpwOjEKdDozCnU6MQ8.01.170twegz9" \
      --executor "shell" \
      --description "shell-runner"