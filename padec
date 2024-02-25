#! /bin/bash

### Name:	padec.sh
### Author:	RgregoR
### Date:	20141023
### Decription:	izracun padca glede na dve visinski tocki in tazdaljo
### 		(-) pada, (+) narasca ...
### 
### 

# CLEAR-ing the screen:
clear

# INTRO:
cat <<INTRO
Name:		padec.sh
Author:		RgregoR
Date:		20141023
Decription:	izracun padca glede na dve visinski tocki in tazdaljo
		(-) pada, (+) narasca ...

INTRO


# declaring variables:
declare RG_RAZD01
declare RG_VTOC01
declare RG_VTOC02
declare RG_RAZL
declare RG_PADEC
declare RG_PPADEC
declare RG_VKON

# getting input from user:
echo "Vnesi 1. visinsko tocko VTOC01 - absolutna visina [m]: "
read RG_VTOC01
echo

echo "Vnesi 2. visinsko tocko VTOC02 - absolutna visina [m]: "
read RG_VTOC02
echo

echo "Vnesi razdaljo med podanima tockama [m]: "
read RG_RAZD01
echo

printf "%-15s%s\n" "VTOC01:" "${RG_VTOC01} [m]"
printf "%-15s%s\n" "VTOC02:" "${RG_VTOC02} [m]"
printf "%-15s%s\n" "Razdalja:" "${RG_RAZD01} [m]"
echo

RG_RAZL=$(echo "scale=3; ${RG_VTOC02}-${RG_VTOC01}" | bc -l)

# print 'height diff' in [m] and replace .NUM with 0.NUM ...
printf "%-15s%s\n" "Razlika [Y]:" "$(echo "${RG_RAZL} [m]" | sed 's/\./0./')"

RG_PADEC=$(echo "scale=3; ${RG_RAZL}/${RG_RAZD01}" | bc -l)

# print abs value of 'padec' in [m/m] and replace .NUM with 0.NUM ...
printf "%-15s%s\n" "Padec [abs]):" "$(echo "${RG_PADEC} [m/m]" | sed 's/^\.\|^-\./0./')"

RG_PPADEC=$(echo "scale=3; ${RG_PADEC}*100" | bc -l)

# print 'padec' in [%] and replace .NUM with 0.NUM ...
printf "%-15s%s\n" "Padec:" "$(echo "${RG_PPADEC} [%]" | sed 's/\./0./')"


echo
exit

