# Failure Mode 2 - Immediate Termination of Single Node

## Overview
Simulate failure of a single node by means of an immediate termination of VM. With a
three node cluster we expect that the two surviving nodes will maintain a quorum
and broker operations will continue unaffected.

## Failure Procedure
Determine one of the three nodes that you would like to simulate failure. For
demonstration purposes, we will choose *rabbit-2*
