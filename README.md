# _.env_ File
You need to define your own _.env_ file with necessary variables:
- POSTGRES_DB=db_name
- POSTGRES_USER=username
- POSTGRES_PASSWORD=password
- DEBUG=0
- SECRET_KEY=your_secret_key (secret key for django)

# Docker Image and Compose
Build docker image and push it to ur dockerhub
```
docker build -t ur_username/ur_dockername:tag
docker push ur_username/ur_dockername:tag
```
After run
```
docker compose up
```

do not forget to change web service's image source to yours in _docker-compose.yaml_ file
```
web:
  image: ur_username/ur_dockername:tag
  container_name: django_backend
```
