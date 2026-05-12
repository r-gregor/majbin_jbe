#! /usr/bin/env bash
# filename: vedit-files-from-vim-history
# 20260211 en v1
# last: 20260211
# ---

unset fljs
unset selection
unset finallist
fljs=()

for LINE in $(grep -E "^> .*[0-9]{8}\.txt" ~/.viminfo | cut -d' ' -f2-); do
	fljs+=("${LINE//\~/${HOME}}")
done

selection=$(for fjl in "${fljs[@]}"; do echo "$fjl"; done 2>/dev/null | fzf -e -m --reverse)

if [ "x${selection}" == "x" ]; then
	echo -e "[INFO] nothing selected\n"
	exit 0
fi

for vfjl in ${selection[@]}; do
	if [ ! -f ${vfjl} ]; then
		echo "[INFO] file: $(basename ${vfjl}) no longer exists. Skipping ..."
	else
		finallist+=("${vfjl}")
	fi
done

if [ "x${finallist}" == "x" ]; then
	echo -e "[INFO] nothing selected\n"
	exit 0
fi

for fjl in "${finallist[@]}"; do
	echo -n "${fjl} "
done | xargs -ro vim -p

