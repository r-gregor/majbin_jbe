#! /usr/bin/env bash

grep export ~/majstaf/majrcs/bashrc-* | cut -d':' -f2 | grep -v '^\#' | sort | uniq

