#! /usr/bin/env bash
# filename: ff-personal-launch-mdb-v5
# from ff-launch-en
# 20260216 en
# 20260229 jbe v2: add info what was selected
#                  change the fzf display to full height
#                  inside infinite while loop --> Quit to quit
# 20260229 jbe v3: keys in separate array for arranged order with 'Quit' as last option
# 20260303 mdb v4: added $delline
# 20260304 jbe v5: $delline calculated from longest KEY line with get_longest function
#                  sorted output to fzf command
# last: 20260304
#---

clear
unset URLS
unset KEYS

# globals
FFCMD='/usr/bin/firefox'
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
# FZFCMD="fzf -e --reverse --height 50% --border rounded"
FZFCMD='fzf -e --reverse --border rounded'

# arrays
declare KEYS=(
	"Moj račun Energetika Ljubljana"
	"ELEKTRO-LJUBLJANA -- Prijava v portal Moja energija"
	"Moj Petrol - elektrika (Valvasorjeva 5)"
	"ZD za študente: dr. Darja Marija ŽNIDARŠIČ"
	"Prijava | doZdravnika.si"
	"eAsistent - Špela"
	"T-2: login"
	"TRIGLAV Zavarovalnica: login"
	"moja POŠTA.si: login"
	"T-2 tv2go: login"
	"URBANA JHL: login"
	"eInženir IZS.si: login"
)

declare -A URLS=(
	["Moj račun Energetika Ljubljana"]="https://mojracun.energetika-lj.si/login"
	["ELEKTRO-LJUBLJANA -- Prijava v portal Moja energija"]="https://me.elektro-energija.si/Prijava"
	["Moj Petrol - elektrika (Valvasorjeva 5)"]="https://www.petrol.si/moj-petrol/"
	["ZD za študente: dr. Darja Marija ŽNIDARŠIČ"]="https://zdstudenti.si/doctor/darja-marija-znidarsic/"
	["Prijava | doZdravnika.si"]="https://dozdravnika.si/#!/auth/login"
	["eAsistent - Špela"]="https://www.easistent.com/stran/"
	["T-2: login"]="https://login.t-2.net/"
	["TRIGLAV Zavarovalnica: login"]="https://login.triglav.si"
	["moja POŠTA.si: login"]="https://auth.posta.si/realms/mojaposta/protocol/openid-connect/auth?client_id=mojaposta-webclient&redirect_uri=https%3A%2F%2Fmoja.posta.si%2Fauth-redirect&response_type=code&scope=openid&state=1becfe48a3ff4cf084d1fa8ec739c90d&code_challenge=O3B_Oqn7GCWDDZsPHDXgKhpFL_DIDLU8gACctKlEoJg&code_challenge_method=S256&ui_locales=sl-SI"
	["T-2 tv2go: login"]="https://tv2go.t-2.net"
	["URBANA JHL: login"]="https://urbana.jhl.si"
	["eInženir IZS.si: login"]="https://einzenir.izs.si/m_login.cfm"
)

# functions
get_longest() {
	if [ ! $# -eq 1 ]; then
		echo "[ERROR1] must supply array of sentences as parameter"
		exit 1
	fi

	local len=0
	local longest
	local -n lines2=$1 # new way: must call array as < array_name >

	for line in "${lines2[@]}"; do
		llen="${#line}"
		if [ "${llen}" -gt "${len}" ]; then
			len="${llen}"
			longest="${line}"
		else
			continue
		fi
	done

	echo "${longest}"
}

ff_personallaunch() {
	local selection=$((for KEY in "${KEYS[@]}"; do echo "$KEY"; done | sort; echo "${delline}" ; echo "Quit") | fzf --reverse)

	if [ "x${selection}" == "x" ]; then
		echo -e "[INFO] nothing selected\n"
		exit 0
	fi

	if [ "${selection}" == "Quit" ]; then
		echo -e "[INFO] leaving\n"
		exit 0
	fi

	if [ "${selection}" != "${delline}" ]; then
		echo "[INFO] selected: ${selection}"
		nohup ${FFCMD} "${URLS["${selection}"]}" >&/dev/null &
	fi
}

# MAIN
longest_l=$(get_longest KEYS)
delline=$(for((i = 0; i < ${#longest_l}; i++)); do printf "-"; done)

while true; do
	ff_personallaunch
done

