FROM python:3.10-slim-buster
ENV PYTHONUNBUFFERED 1

# Личная информация
LABEL maintainer="Степанов Андрей <a@stepanov1999.ru>"

# Установка зависимости ОС
RUN apt-get update \
    && apt-get install -y postgresql libpq-dev nginx \
    && rm -rf /var/lib/apt/lists/*

# Обновление pip
RUN pip install --upgrade pip

# Создание и установка рабочей директории, копирование файлов в рабочую директорию
WORKDIR /www
COPY . /www/
RUN pip install --no-cache-dir -r requirements.txt

# Копирование конфигурационного файла NginX
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/sites-enabled/
RUN rm nginx.conf

# Создание БД, пользователя БД, установка
RUN service postgresql start \
    && su - postgres -c "psql -c \"CREATE DATABASE postgres_db;\"" \
    && su - postgres -c "psql -c \"CREATE USER db_user WITH PASSWORD 'db_password';\"" \
    && su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE postgres_db TO db_user;\"" \
    && python manage.py migrate && sleep 5 \
    && echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | python manage.py shell

# Сборка всех статических файлов
RUN python manage.py collectstatic --noinput

# Экспорт портов
EXPOSE 8000
EXPOSE 80

# Запуск
CMD service postgresql start && service nginx start && sleep 5 && gunicorn --bind 0.0.0.0:8000 project_to_server.wsgi
