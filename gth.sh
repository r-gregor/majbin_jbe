#! /usr/bin/env bash

/usr/bin/git ls-files -z | xargs -0 ls -t
