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

## References
* https://www.rabbitmq.com/management-cli.html
* https://www.compose.com/articles/configuring-rabbitmq-exchanges-queues-and-bindings-part-2/
* https://www.rabbitmq.com/clustering.html


## Vagrant Preparation
The demo environment is also reliant on a vagrant plugin to manage **/etc/hosts**
for name resolution inside of the guest virtual machines. The plugin can be
installed as follows:

`$ vagrant plugin install vagrant-hostmanager`

## Starting the Demo Environment
Start the environment:

`$ vagrant up`

The three nodes will be installed and configured for RabbitMQ in about 9-10
minutes. Please note that due to the serial nature of vagrant provisioning,
the cluster formation will be done as a separate post step below.

At completion, ensure that all three nodes are running:

`Current machine states:`

`rabbit-1                  running (virtualbox)`

`rabbit-2                  running (virtualbox)`

`rabbit-3                  running (virtualbox)`

## Cluster formation
Initially, the three nodes will be operating as independent single node brokers.
The following steps are needed to instruct rabbit-2 and rabbit-3 to join the cluster.

`$ vagrant ssh rabbit-2`

`sudo rabbitmqctl stop_app`

`sudo rabbitmqctl reset`

`sudo rabbitmqctl join_cluster rabbit@rabbit-1`

`sudo rabbitmqctl start_app`

`exit`

`$ vagrant ssh rabbit-3`

`sudo rabbitmqctl stop_app`

`sudo rabbitmqctl reset`

`sudo rabbitmqctl join_cluster rabbit@rabbit-1`

`sudo rabbitmqctl start_app`

`exit`

Verify status of the cluster. All three nodes should be running as disk nodes:

`sudo rabbitmqctl cluster_status`

`Disk Nodes`

`rabbit@rabbit-1`

`rabbit@rabbit-2`

`rabbit@rabbit-3`

`Running Nodes`

`rabbit@rabbit-1`

`rabbit@rabbit-2`

`rabbit@rabbit-3`

## Queue Definition
Quorum based queues need to have their queue type set at queue declaration time.
This can be done either at the command line with **rabbitmqadmin** or via the
management console. Here we will use the CLI:

From rabbit-1:

`$ vagrant ssh rabbit-1`

`$ wget -O rabbitmqadmin http://localhost:15672/cli/rabbitmqadmin`

`$ chmod +x ./rabbitmqadmin`

`$ ./rabbitmqadmin declare queue name=erc_quorum_queue 'arguments={"x-queue-type":"quorum"}'`

> queue declared

Verify queue settings:

`$ ./rabbitmqadmin list queues vhost node type`

+-------+-----------------+--------+

| vhost |      node       |  type  |

+-------+-----------------+--------+

| /     | rabbit@rabbit-1 | quorum |

+-------+-----------------+--------+

`exit`

## Example Failure Scenarios
* [Failure 1 - Graceful VM Shutdown](doc/FAIL-001.md)
* [Failure 2 - Immediate VM Shutdown](doc/FAIL-002.md)
* [Failure 3 - Network Segmentation](doc/FAIL-003.md)
