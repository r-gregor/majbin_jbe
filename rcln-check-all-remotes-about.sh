#! /usr/bin/env bash

for RMT in $(rclone listremotes); do echo $RMT; rclone about $RMT; echo "---";done

