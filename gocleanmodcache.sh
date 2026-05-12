#! /usr/bin/env bash

echo "Cleaning \$GOPATH/pkg/mod/* modules cache ... [ go clean -modcache ]"
go clean -modcache
echo "Done!"
