# Failure Mode 2 - Immediate Termination of Single Node

## Overview
Simulate failure of a single node by means of an immediate termination of VM. With a
three node cluster we expect that the two surviving nodes will maintain a quorum
and broker operations will continue unaffected.

## Failure Procedure
Determine one of the three nodes that you would like to simulate failure. For
demonstration purposes, we will choose *rabbit-3*

`vagrant destroy rabbit-3`

The surviving nodes will show the node down messages after about 90 seconds.

2020-03-11 13:44:20.487 [error] <0.3080.0> ** Node 'rabbit@rabbit-3' not responding **
** Removing (timedout) connection **
2020-03-11 13:44:20.487 [info] <0.409.0> rabbit on node 'rabbit@rabbit-3' down
2020-03-11 13:44:20.521 [info] <0.409.0> Node rabbit@rabbit-3 is down, deleting its listeners
2020-03-11 13:44:20.524 [info] <0.409.0> node 'rabbit@rabbit-3' down: net_tick_timeout

Cluster Status:
Running Nodes

rabbit@rabbit-1
rabbit@rabbit-2

Status of quorum queue:

┌─────────────────┬──────────────────────────────┬───────────┬──────────────┬────────────────┬──────┬─────────────────┐
│ Node Name       │ Raft State                   │ Log Index │ Commit Index │ Snapshot Index │ Term │ Machine Version │
├─────────────────┼──────────────────────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-3 │ {nodedown,'rabbit@rabbit-3'} │           │              │                │      │                 │
├─────────────────┼──────────────────────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-2 │ follower                     │ 1         │ 1            │ undefined      │ 1    │ 0               │
├─────────────────┼──────────────────────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-1 │ leader                       │ 1         │ 1            │ undefined      │ 1    │ 0               │
└─────────────────┴──────────────────────────────┴───────────┴──────────────┴────────────────┴──────┴─────────────────┘

## Recovery Procedure
Bring the node back online by simply starting the VM once again. We expect that cluster state will be synchronized from one of the other upon
broker startup.

`$ vagrant up rabbit-3`

The surviving nodes will see the heartbeat from rabbit-3 upon startup:

2020-03-11 13:51:46.395 [info] <0.409.0> node 'rabbit@rabbit-3' up
2020-03-11 13:52:09.717 [info] <0.409.0> node 'rabbit@rabbit-3' down: connection_closed
2020-03-11 13:52:19.395 [info] <0.409.0> node 'rabbit@rabbit-3' up

Due to initial puppet config, newly provisioned node will come up as a single node cluster. We will
now need to re-join the cluster.
