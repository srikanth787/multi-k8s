#!/usr/bin/env bash

docker build -t vishnu787/multi-client:latest -t vishnu787/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vishnu787/multi-server:latest -t vishnu787/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t vishnu787/multi-worker:latest -t vishnu787/multi-worker:$SHA -f ./client/Dockerfile ./worker


docker push vishnu787/multi-client:latest
docker push vishnu787/multi-server:latest
docker push vishnu787/multi-worker:latest

docker push vishnu787/multi-client:#SHA
docker push vishnu787/multi-server:#SHA
docker push vishnu787/multi-worker:#SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vishnu787/multi-server:$SHA
kubectl set image deployments/client-deployment client=vishnu787/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vishnu787/multi-worker:$SHA