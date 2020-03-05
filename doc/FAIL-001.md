# Failure Mode 1 - Graceful Shutdown of Single Node

## Overview
Simulate failure of a single node by means of a graceful shutdown of VM. With a
three node cluster we expect that the two surviving nodes will maintain a quorum
and broker operations will continue unaffected.

## Failure Procedure
Determine one of the three nodes that you would like to simulate failure. For
demonstration purposes, we will choose *rabbit-2*

`$ vagrant halt rabbit-2`

Both surviving nodes should notice the disappearance of rabbit-2. In the main
RabbitMQ log, messages will be logged as such:

2020-03-05 20:09:44.414 [info] <0.402.0> rabbit on node 'rabbit@rabbit-2' down
2020-03-05 20:09:44.419 [info] <0.402.0> Keeping rabbit@rabbit-2 listeners: the node is already back
2020-03-05 20:09:45.454 [info] <0.402.0> node 'rabbit@rabbit-2' down: connection_closed

Cluster status will also confirm the offline state of rabbit-2:

Running Nodes

rabbit@rabbit-1

rabbit@rabbit-3

## Recovery Procedure
Bring the node back online by simply starting the VM once again. We expect that cluster state will be synchronized from one of the other upon
broker startup.

`$ vagrant up rabbit-2`

The surviving nodes will see the heartbeat from rabbit-2 upon startup:

2020-03-05 20:16:23.318 [info] <0.2848.0> node 'rabbit@rabbit-2' up
2020-03-05 20:16:29.245 [info] <0.2848.0> rabbit on node 'rabbit@rabbit-2' up

Log on rabbit-2 shows re-synchronization of mnesia tables:
2020-03-05 20:16:29.085 [info] <0.385.0> Running boot step database defined by a
pp rabbit
2020-03-05 20:16:29.090 [info] <0.385.0> Waiting for Mnesia tables for 30000 ms,
 9 retries left
2020-03-05 20:16:29.091 [info] <0.385.0> Waiting for Mnesia tables for 30000 ms,
 9 retries left
2020-03-05 20:16:29.092 [info] <0.385.0> Waiting for Mnesia tables for 30000 ms,
 9 retries left
2020-03-05 20:16:29.136 [info] <0.385.0> Waiting for Mnesia tables for 30000 ms,
 9 retries left

Validate Quorum status of demonstration queue

Status of quorum queue erc_quorum_queue on node rabbit@rabbit-2 ...
┌─────────────────┬────────────┬───────────┬──────────────┬────────────────┬──────┬─────────────────┐
│ Node Name       │ Raft State │ Log Index │ Commit Index │ Snapshot Index │ Term │ Machine Version │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-3 │ follower   │ 1         │ 1            │ undefined      │ 1    │ 0               │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-2 │ follower   │ 1         │ 1            │ undefined      │ 1    │ 0               │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-1 │ leader     │ 1         │ 1            │ undefined      │ 1    │ 0               │
└─────────────────┴────────────┴───────────┴──────────────┴────────────────┴──────┴─────────────────┘
