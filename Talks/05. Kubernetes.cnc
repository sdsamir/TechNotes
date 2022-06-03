## Introduction
## In order to run kubernetes locally and practice development, we need to install one of the below tools:

## 1. kind: kind lets you run Kubernetes on your local computer. This tool requires that you have Docker installed and configured.

## 2. minikube: minikube is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes. 
##    minikube runs a single-node Kubernetes cluster on your personal computer (including Windows, macOS and Linux PCs) 
##    so that you can try out Kubernetes, or for daily development work.

## 3. kubeadm: You can use the kubeadm tool to create and manage Kubernetes clusters. It performs the actions necessary to get a minimum viable, 
##    secure cluster up and running in a user friendly way. It can create multi node cluster.

## 4. Container rutime: In kubernetes all nodes must have container runtime istalled, includeing master and worker. The kubernetes system pods, running in master node,
##    so master node also need container runtime. Container runtime: Docker, ContainerD, CRI-O etc.


## Start minikube in computer
> minikube start

## Start minikube with a specific driver.
> minikube start --driver=hyper-v/vmware

## Get the information about the runnug cluster
> kubectl cluster-info

## In order to connect to minikube node, we need to know the IP address of the minikube node. 
> minikube ip

## Namespaces in K8S are used to group different resources and configuration objects.
## List all namespaces
> kubectl get namespaces

## Pods are smallest unit in K8S. It is the runs the container. Can be one or more container running in a pod.
## List all pods
> kubectl get pods

## List all pods in a specific namespace
> kubectl get pods --namespace=kube-system

## List all pods in all namespace
> kubectl get pods -A

## List all pods in all namespace with more details
> kubectl get pods -A -o wide

## List all nodes
> kubectl get nodes

## Run a pod with specific image
> kubectl run k8s-nginx[pod name] --image=nginx[image]

## Access the running pod we nee to use port forwarding. After doing this the pod will be accessible in https://host:6666
> kubectl port-forward k8s-nginx 6666:80
