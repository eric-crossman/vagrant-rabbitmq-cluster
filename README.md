# vagrant-rabbitmq-cluster
Vagrant  demo of RabbitMQ clustered queues

## Overview
This repository provides a demonstration of a three node RabbitMQ cluster
utilizing quorum-based queues for message durability. Once the demo environment
is provisioned, it can be used to exercise the various failover/recovery
scenarios. Some examples of common failure modes will be provided here as a
reference.

## Assumptions/Dependencies
The demo environment provided here is based on Puppet, Vagrant, and VirtualBox.
The local machine used to run the demo will need to have those components
already installed and functioning.

## Vagrant Preparation
The demo environment is also reliant on a vagrant plugin to manage **/etc/hosts**
for name resolution inside of the guest virtual machines. The plugin can be
installed as follows:

`$ vagrant plugin install vagrant-hostmanager`

## Starting the Demo Environment
Start the environment:

`vagrant up`

The three nodes will be installed and configured for RabbitMQ in about 9-10
minutes. Please note that due to the serial nature of vagrant provisioning,
the cluster formation will be done as a separate post step below.
