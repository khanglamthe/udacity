#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=khanglt/udacity:v1.0.0

# Step 2
# Run the Docker Hub container with kubernetes
minikube kubectl -- create deployment --image=$dockerpath khanglt-udacity-app

# Step 3:
# List kubernetes pods
minikube kubectl get deploy,rs,svc,pods

# Step 4:
# Forward the container port to a host
podname=$(minikube kubectl -- get pods -l app=khanglt-udacity-app -o jsonpath={.items[0].metadata.name})
minikube kubectl -- expose deployment khanglt-udacity-app --port=80 --name=khanglt-udacity-http-service
minikube kubectl -- port-forward $podname 8089:80

