FROM python:3.9.20-alpine3.20

# Установка необходимых пакетов
RUN apk add --no-cache python3 py3-pip shadow bash && \
    python3 -m ensurepip && \
    python3 -m pip install --upgrade pip

# Создание non-root пользователя
RUN useradd -m -s /bin/bash diffustion

# Установка прав на директорию
RUN mkdir -p /home/diffustion/.local/lib/python3.9/site-packages && \
    chown -R diffustion:diffustion /home/diffustion/.local

# Настройка переменных окружения для non-root пользователя
RUN echo "export PYTHONUSERBASE=/home/diffustion/.local" >> /home/diffustion/.bashrc && \
    echo "export PATH=/home/diffustion/.local/bin:$PATH" >> /home/diffustion/.bashrc

COPY stable-diffusion-webui/* ./stable-diffusion-webui

# Переключение на non-root пользователя
USER diffustion

# Установка зависимостей
RUN python3 -m pip install numpy

WORKDIR /stable-diffusion-webui

# Задача на удержание контейнера
CMD ["python3", "launch.py"]