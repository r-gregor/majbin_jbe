#! /usr/bin/env bash

for FFF in $(find * -executable); do ln -snfv $(realpath $(dirname ${FFF}))/${FFF} ${HOME}/.local/bin/${FFF}; done

