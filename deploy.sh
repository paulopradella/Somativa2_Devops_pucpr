#!/bin/bash
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker tag myapp $DOCKER_USERNAME/myapp
docker push $DOCKER_USERNAME/myapp
telegram-send "Deployment completed!"
