#!/bin/bash

arg="$@"

BIG=$(echo $arg | tr [:lower:] [:upper:])

echo $BIG
echo $BIG | putclip