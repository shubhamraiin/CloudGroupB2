#!/bin/bash

#script to rebalance the swift ring structure

swift-ring-builder account.builder rebalance
sleep 200s

swift-ring-builder container.builder rebalance
sleep 200s

swift-ring-builder object.builder rebalance
