#! /usr/bin/env bash
# filename: get-terminal
# from: https://www.quora.com/How-can-I-identify-the-current-terminal-emulator-from-a-bash-script/answer/Sourav-Goswami-17
# displays terminal app name: xfce4-terminal / kitty / alacritty / urxvt / ...
# 20251126
# ---

get_ppid() { printf `awk -F "PPid:" '{print $2}' "/proc/$1/status"` ; }

get_terminal_name() {
	ppid=$(get_ppid $PPID)

	while [[ -z "$term" ]] ; do
		name=`cat /proc/$ppid/comm`

		case ${name// } in
			"${SHELL/*\/}"|"sh"|"su"* ) ;;

			*)
				echo $name
				break
			;;
		esac

		# ppid=$(get_ppid $ppid)
	done
}

TERMINAL=$(get_terminal_name)

echo "'${TERMINAL}'"

