#! /usr/bin/env bash
# fname: vview-sfjl-efzf
# 20260319  en v1
# last: 20260319
# ---

vcmd='vim -M'
fcmd='fzf --reverse -e'
readarray -t selections < <(cd $HOME && ${fcmd})

if [ "${#selections[@]}" -eq 0 ]; then
	printf "[INFO] nothing selected\n\n"
	exit
fi

printf "[INFO] selected:\n"
for selection in "${selections[@]}"; do
	printf "%s\n" "${HOME}/${selection}"
done

for selection in "${selections[@]}"; do
	printf "${HOME}/${selection} "
done | xargs -ro ${vcmd}

