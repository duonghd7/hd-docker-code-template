#!/bin/bash

export ENV=...
export PROJECT=...
export IMAGE=duonghd/code-template:0.0.2
PREFIX=`date +"%s%M%H%d%m%y"`

## Apply secret
SECRET_FILE_NAME=k1_secret_$PREFIX.yaml
export SECRET_FILE_BASE_64=$(cat ../.env | base64)
cat k1_secret.yaml | envsubst > $SECRET_FILE_NAME
kubectl apply -f $SECRET_FILE_NAME
rm -rf $SECRET_FILE_NAME

## Apply deployment
DEPLOY_FILE_NAME=k2_deployment_$PREFIX.yaml
export CONTAINER_PORT=3000
cat k2_deployment.yaml | envsubst > $DEPLOY_FILE_NAME
kubectl apply -f $DEPLOY_FILE_NAME
rm -rf $DEPLOY_FILE_NAME