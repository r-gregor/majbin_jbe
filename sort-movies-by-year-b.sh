#! /usr/bin/env bash

/bin/ls | sed 's/\(.*\)(\(.*\))/\2 \1/' | sort -r
