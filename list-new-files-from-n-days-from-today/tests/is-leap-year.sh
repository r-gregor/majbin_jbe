#! /usr/bin/env bash
# fname: /home/gregor.redelonghi/majstaf/_NERAZPOREJENO/__DANES__/is-leap-year.sh
# 20260902 v1
# ---

curryr=$(date +"%Y")

isleap() { 
	year=$1
	(( !(year % 4) && ( year % 100 || !(year % 400) ) )) && echo "leap year" || echo "not a leap"
}


printf "${curryr} is "; isleap ${curryr}
printf "2000 is "; isleap 2000

printf "is leap 2026: %d\n" $(( !(year % 4) && ( year % 100 || !(year % 400) ) ))
