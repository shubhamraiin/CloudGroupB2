#!/bin/bash

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.71  # and the IP address
export WEIGHT=14              # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.72   # and the IP address
export WEIGHT=16               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.73    # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.74   # and the IP address
export WEIGHT=30               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.75    # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.87    # and the IP address
export WEIGHT=15               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.88    # and the IP address
export WEIGHT=28               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=1                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.89    # and the IP address
export WEIGHT=50               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=2                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.76    # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=2                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.77    # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=2                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.78  # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT


export ZONE=2                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.79   # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=2                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.80    # and the IP address
export WEIGHT=20               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=3                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.81    # and the IP address
export WEIGHT=15               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=3                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.82    # and the IP address
export WEIGHT=15               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=3                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.83    # and the IP address
export WEIGHT=40               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=3                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.84    # and the IP address
export WEIGHT=12               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=3                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.85    # and the IP address
export WEIGHT=18               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT

export ZONE=4                    # set the zone number for that storage device
export STORAGE_LOCAL_NET_IP=10.176.128.86    # and the IP address
export WEIGHT=100               # relative weight (higher for bigger/faster disks)
export DEVICE=sdb1
swift-ring-builder account.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6002/$DEVICE $WEIGHT
swift-ring-builder container.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6001/$DEVICE $WEIGHT
swift-ring-builder object.builder add z$ZONE-$STORAGE_LOCAL_NET_IP:6000/$DEVICE $WEIGHT
