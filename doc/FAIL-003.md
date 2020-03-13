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
