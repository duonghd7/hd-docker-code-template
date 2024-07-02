#!/bin/bash

export ENV=test
export PROJECT=duonghd
export IMAGE=339712908302.dkr.ecr.us-east-1.amazonaws.com/test-duonghd-backend:0.0.1
PREFIX=`date +"%s%M%H%d%m%y"`

# Apply secret
SECRET_FILE_NAME=k1_secret_$PREFIX.yaml
export SECRET_FILE_BASE_64=$(cat ../.env | base64)
cat k1_secret.yaml | envsubst > $SECRET_FILE_NAME
kubectl apply -f $SECRET_FILE_NAME
rm -rf $SECRET_FILE_NAME

# Apply deployment
DEPLOY_FILE_NAME=k2_deployment_$PREFIX.yaml
export CONTAINER_PORT=8080
cat k2_deployment.yaml | envsubst > $DEPLOY_FILE_NAME
kubectl apply -f $DEPLOY_FILE_NAME
rm -rf $DEPLOY_FILE_NAME

# Apply auto scale
APP_AUTOSCALE_FILE_NAME=k4_app_autoscale_$PREFIX.yaml
cat k4_app_autoscale.yaml | envsubst > $APP_AUTOSCALE_FILE_NAME
kubectl apply -f $APP_AUTOSCALE_FILE_NAME
rm -rf $APP_AUTOSCALE_FILE_NAME

# Apply auto scale system
# SYS_AUTOSCALE_FILE_NAME=k5_sys_autoscale_$PREFIX.yaml
# export EKS_CLUSTER_NAME=test-duonghd-eks2
# export EKS_AUTO_SCALE_ROLE_ARN=arn:aws:iam::339712908302:role/test-duonghd-iam-role-backend2
# cat k5_sys_autoscale.yaml | envsubst > $SYS_AUTOSCALE_FILE_NAME
# kubectl apply -f $SYS_AUTOSCALE_FILE_NAME
# rm -rf $SYS_AUTOSCALE_FILE_NAME
