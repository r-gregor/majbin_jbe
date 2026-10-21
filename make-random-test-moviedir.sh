#! /usr/bin/env bash
# fname: make_random_test_moviedir.sh
# descpt: make random test movie directories
# 20240423
# last: 20240423
# ---

function mkmvdr() {
	MVD="Movie $((0 + RANDOM % 9))$((0 + RANDOM % 9)) ($((2000 + RANDOM % 24)))"
	mkdir -pv "${MVD}"
}

mkmvdr

# $> for N in $(seq 1 10); do mkmvdr; done
# Movie 30 (2004)
# Movie 10 (2004)
# Movie 36 (2017)
# Movie 23 (2005)
# Movie 50 (2012)
# Movie 01 (2002)
# Movie 72 (2012)
# Movie 56 (2009)
# Movie 44 (2000)
# Movie 82 (2004)

