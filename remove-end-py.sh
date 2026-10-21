#! /usr/bin/env bash

for FFF in *.py; do mv $FFF ${FFF//.py/}; done

