# Docker (Django + Gunicorn + NginX + PostgreSQL)
<hr>

#### [ссылка на образ](https://hub.docker.com/r/stepanov1999/e4)
Если ссылка не работает, можно скопировать путь до образа - https://hub.docker.com/r/stepanov1999/e4

## Скачать образ можно командой:
````shell
docker pull stepanov1999/e4
````

## Запускается командой:
```shell
docker run -p 8000:8000 -p 80:80 stepanov1999/e4
```

## Административный web-сайт:
### Для входа используйте следующие данные:
**Логин:** admin

**Пароль:** admin

<hr>

## Сборка образа:
#### Для сборки образа необходимо сделать следующее:
1. Скачайте этот проект. Например: `git pull https://github.com/stepanov1999/E4.git`
2. В терминале перейдите в директорию, где находится Dockerfile этого проекта
3. Выполните следующую команду
```shell
docker build -t <имя_будущего_образа> .
```
Например:
```shell
docker build -t e4 .
```

Теперь можно залить образ на Docker Hub

## Заливаем образ на Docker Hub
1. Выполните действия, описанные ниже:
```shell
# Логин на Docker Hub
docker login

# Тэгируем образ перед публикацией
docker tag e4 stepanov1999/e4:latest

# Публикуем образ на Docker Hub
docker push <ваш_username_на_docker-hub>/<имя_образа>:latest
```

Например:
```shell
docker tag django_server stepanov1999/e4:latest
```
```shell
docker push stepanov1999/e4:latest
```
