#! /usr/bin/env bash
# fname: izklop.sh
# descpt: Logout/restart/shutdow cli-menu
# 20261001 v1
# last: 20261001
# ---

# === GLOBALS ===
mznst=""


# === FUNCTIONS ===
menu() {
	printf "---------------------------------------\n"
	printf "1 - logout $USERNAME\n"
	printf "2 - reboot\n"
	printf "3 - shutdown\n"
	printf "N - back to 'zze'\n"
	printf "---------------------------------------\n"
	printf "0 - exit\n"
	printf "---------------------------------------\n"
}


# === MAIN ===
clear
while true; do
	menu
	printf "[?] insert choice number/char: "
	read -r mznst

	printf "\n"

	case "${mznst}" in
		"1" )
			shutdown -l -t 05
			;;
		"2" )
			shutdown -r -t 05
			;;
		"3" )
			shutdown -s -t 05
			;;
		"N" )
			clear && source ./zze.sh
			break
			;;
		"0" )
			clear
			exit 0
			;;
		* )
			printf "[e] choice not in the list\n"
			read -r -p "[?] press any key to exit"
			clear
			exit 1
			;;
	esac
	clear

done

