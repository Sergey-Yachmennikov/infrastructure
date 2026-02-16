# Берем за основу Ubuntu 22.04 (там есть apt-get)
FROM ubuntu:22.04

# Отключаем вопросы при установке (автоматический выбор)
ENV DEBIAN_FRONTEND=noninteractive

# Устанавливаем все необходимые инструменты
# Добавляем репозиторий для Java 21
RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg lsb-release git maven sudo && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y temurin-21-jdk && \
    apt-get clean

# Устанавливаем GitLab Runner
# (Скачиваем бинарник нужной версии)
RUN curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/v16.11.0/binaries/gitlab-runner-linux-amd64" && \
    chmod +x gitlab-runner-linux-amd64 && \
    mv gitlab-runner-linux-amd64 /usr/bin/gitlab-runner

# Создаем пользователя gitlab-runner и даем ему права
RUN useradd -m -s /bin/bash gitlab-runner && \
    usermod -aG sudo gitlab-runner && \
    echo "gitlab-runner ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Добавляем пользователя в группу docker (если docker socket проброшен)
# Группа docker может не существовать, создадим её
RUN groupadd -f docker && usermod -aG docker gitlab-runner

# Указываем точку входа (чтобы контейнер не падал сразу после старта)
ENTRYPOINT ["/usr/bin/gitlab-runner", "run"]