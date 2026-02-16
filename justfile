images_catalog_in_nexus:
    curl http://localhost:5001/v2/_catalog
docker_login:
    docker login localhost:5001
install_software_to_runner:
    docker exec -it gitlab-runner bash -c "
      apt-get update && \
      apt-get install -y docker.io curl git maven && \
      apt-get clean
    "
install_sudo:
    docker exec -it gitlab-runner bash -c "apt-get update && apt-get install -y sudo"
add_runner_to_docker_group:
    sudo usermod -aG docker gitlab-runner
rights:
    docker exec -it gitlab-runner chmod 666 /var/run/docker.sock

java_install:
    docker exec -it gitlab-runner bash -c "apt-get install -y openjdk-21-jdk"

registration:
    docker exec -it gitlab-runner gitlab-runner register \
      --non-interactive \
      --url "http://gitlab:8929" \
      --clone-url "http://gitlab:8929" \
      --registration-token "glrt-awTXhz90AsXDF-hf94fjTm86MQpwOjEKdDozCnU6MQ8.01.170uz8ecx" \
      --executor "shell" \
      --description "shell-runner"

registration_docker:
    docker exec -it gitlab-runner gitlab-runner register \
      --non-interactive \
      --url "http://gitlab:8929" \
      --clone-url "http://gitlab:8929" \
      --registration-token "glrt-AjBuENv-14ex_JJG_dr7ZG86MQpwOjEKdDozCnU6MQ8.01.171bxr59m" \
      --executor "docker" \
      --description "docker-runner"