#!/bin/bash

kubectl create ns db
kubectl create clusterrolebinding cassandra-clusterbinding --clusterrole=cluster-admin --user=kube-apiserver-kubelet-client --namespace db
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade --install cassandra bitnami/cassandra --namespace db  --set cluster.replicaCount=2,persistence.enabled=false
