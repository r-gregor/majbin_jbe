#! /usr/bin/env bash
# gadd-gcmt-jbe
# last change: 20250406

gcmd="/usr/bin/git add --verbose ."
gcmt="${HOME}/.local/bin/gcommit-timestamp-jbe"


# display commands
echo -en "running: ${gcmd}\n" && ${gcmd}
echo
echo -en "running: ${gcmt}\n" && ${gcmt}

