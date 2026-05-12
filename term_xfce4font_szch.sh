#! /usr/bin/env bash
# term_xfce4font_szch
# increase/decrease/reset font size in xfce4-terminal
# 20251126
# --

fname="${HOME}/.config/xfce4/terminal/terminalrc"
original_fs=18

curr_line=$(grep FontName "${fname}")
curr_fs=$(echo "${curr_line}" | grep -o "[0-9][0-9]")

# test
# echo "Current line:      ${curr_line}"
# echo "Current font size: ${curr_fs}"
# read -p "OK?"

# displays terminal app name: xfce4-terminal / kitty / alacritty / urxvt / ...
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
# displays terminal app name: xfce4-terminal / kitty / alacritty / urxvt / ...

TERMINAL=$(get_terminal_name)

if [ "${TERMINAL}" != "xfce4-terminal" ]; then

	echo "[ERROR] wrong terminal app"
	exit
fi







###################################################################################

incrs() {
	sed -i "s/\(FontName.*\) ${curr_fs}/\1 $(( ${curr_fs} + 2 ))/" ${fname}
}

decrs() {
	sed -i "s/\(FontName.*\) ${curr_fs}/\1 $(( ${curr_fs} - 2 ))/" ${fname}
}


reset() {
	sed -i "s/\(FontName.*\) ${curr_fs}/\1 ${original_fs}/" ${fname}
}

if [ $# -ne 1 ]; then
	echo "+ ... increase"
	echo "- ... decrease"
	echo "0 ... reset"
	echo ""
	exit
else
	selection="$1"
fi

while true; do
	case "${selection}" in
		"+")
			incrs
			break ;;
		"-")
			decrs
			break ;;
		"0")
			reset
			break ;;
		*)
			echo "unknown command"
			break ;;
	esac
done

