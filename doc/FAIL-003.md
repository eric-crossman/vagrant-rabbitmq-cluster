# Failure Mode 3 - Network Segmentation

## Overview
Simulate network segmentation between data centers by means of a VirtualBox NIC
disconnection. With a three node cluster we expect that the two surviving nodes
will maintain a quorum and the disconnected node will pause broker operation.

## Failure Procedure
Determine one of the three nodes that you would like to simulate failure. For
demonstration purposes, we will choose *rabbit-1*

In VirtualBox, navigate the VM corresponding to "rabbit-1".
Under Settings -> Network -> Adapter 2, de-select "Cable connected". This will
disconnect the VM from the host-only network being used to communicate with the
other Rabbit nodes.

Within about 5 seconds, the nodes in the majority partition will detect the
network partitioning and show the election of a new leader for the quorum queue:

2020-03-17 20:30:46.988 [info] <0.2445.0> queue 'erc_quorum_queue' in vhost '/': granting vote for {'%2F_erc_quorum_queue','rabbit@rabbit-3'} with last indexterm {1,1} for term 2 previous term was 1
2020-03-17 20:30:47.000 [info] <0.2445.0> queue 'erc_quorum_queue' in vhost '/': detected a new leader {'%2F_erc_quorum_queue','rabbit@rabbit-3'} in term 2

This can be valiated with "rabbitmq-queues":

Status of quorum queue erc_quorum_queue on node rabbit@rabbit-2 ...
┌─────────────────┬────────────┬───────────┬──────────────┬────────────────┬──────┬─────────────────┐
│ Node Name       │ Raft State │ Log Index │ Commit Index │ Snapshot Index │ Term │ Machine Version │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-3 │ leader     │ 2         │ 2            │ undefined      │ 2    │ 0               │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-2 │ follower   │ 2         │ 2            │ undefined      │ 2    │ 0               │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-1 │ follower   │ 2         │ 2            │ undefined      │ 2    │ 0               │
└─────────────────┴────────────┴───────────┴──────────────┴────────────────┴──────┴─────────────────┘

On the node with the designated failure, we can see that the partitioning has
been detected:

`sudo rabbitmqctl cluster_status`

Network Partitions

Node rabbit@rabbit-3 cannot communicate with rabbit@rabbit-1

## Recovery Procedure
In VirtualBox, re-connect the cable for the host only network interface.

Within about 5 seconds, cluster nodes notice the heartbeat from rabbit-1 but
cluster still seems to be in the partitioned state. A restart of rabbit on
rabbit-1 seems to resolve this.

`rabbitmqctl stop_app`

`rabbitmqctl start_app`

Running Nodes

rabbit@rabbit-1

rabbit@rabbit-2

rabbit@rabbit-3

Quorum Status:
Status of quorum queue erc_quorum_queue on node rabbit@rabbit-2 ...
┌─────────────────┬────────────┬───────────┬──────────────┬────────────────┬──────┬─────────────────┐
│ Node Name       │ Raft State │ Log Index │ Commit Index │ Snapshot Index │ Term │ Machine Version │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-3 │ follower   │ 4         │ 4            │ undefined      │ 4    │ 0               │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-2 │ leader     │ 4         │ 4            │ undefined      │ 4    │ 0               │
├─────────────────┼────────────┼───────────┼──────────────┼────────────────┼──────┼─────────────────┤
│ rabbit@rabbit-1 │ follower   │ 4         │ 4            │ undefined      │ 4    │ 0               │
└─────────────────┴────────────┴───────────┴──────────────┴────────────────┴──────┴─────────────────┘
