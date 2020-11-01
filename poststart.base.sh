#!/usr/bin/env bash

# create matching folders to mount the farm
if [ ! -d /nfs ] || [ ! -d /lustre ] || [ ! -d /warehouse ]; then
    sudo mkdir -p /nfs
    sudo mkdir -p /lustre
    sudo mkdir -p /warehouse
fi

# set env vars for nbresuse limits
export MEM_LIMIT=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
CPU_NANOLIMIT=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
export CPU_LIMIT=$(($CPU_NANOLIMIT/100000))

export USER=jovyan
