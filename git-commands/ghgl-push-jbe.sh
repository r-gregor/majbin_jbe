#! /usr/bin/env bash
# ghgl-push-jbe
# last change:20250406

rmts=( $(git remote) )

for rmt in "${rmts[@]}"; do
	echo "[INFO] git push in: $(git remote get-url ${rmt}) ..."
	git push ${rmt} main
	echo "---"
done
echo ""

