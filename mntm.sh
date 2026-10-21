#! /usr/bin/env bash

### Name: majstaf/majbin/mntm
###

mount | grep '/media/' | cut -d' ' -f-5

