#!/bin/bash

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

PREFIX=`date +"%s%M%H%d%m%y"`

## Apply service
SERVICE_FILE_NAME=k3_service_$PREFIX.yaml
export SVC_NAME=...
export LB_CERT_ARN=...
export SVC_SELECTOR=... ## Pod label label: $ENV-$PROJECT-pod 
export SVC_TARGET_PORT=...
cat k3_service.yaml | envsubst > $SERVICE_FILE_NAME
kubectl apply -f $SERVICE_FILE_NAME
rm -rf $SERVICE_FILE_NAME

## Apply app autoscale
APP_AUTOSCALE_FILE_NAME=k4_app_autoscale_$PREFIX.yaml
export ENV=...
export PROJECT=...
cat k4_app_autoscale.yaml | envsubst > $APP_AUTOSCALE_FILE_NAME
kubectl apply -f $APP_AUTOSCALE_FILE_NAME
rm -rf $APP_AUTOSCALE_FILE_NAME

## Apply system autoscale
SYS_AUTOSCALE_FILE_NAME=k4_sys_autoscale_$PREFIX.yaml
export EKS_AUTO_SCALE_ROLE_ARN=...
export EKS_CLUSTER_NAME=...
cat k4_sys_autoscale.yaml | envsubst > $SYS_AUTOSCALE_FILE_NAME
kubectl apply -f $SYS_AUTOSCALE_FILE_NAME
rm -rf $SYS_AUTOSCALE_FILE_NAME
