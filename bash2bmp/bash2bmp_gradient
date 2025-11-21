#! /usr/bin/env bash
# --------------------------------------------------------------------------------------------------
# from:      https://www.youtube.com/watch?v=XjAIhULJsjc
#            I Created a Bitmap Image using Just Bash! (yes, really) - Graphics Programming in Bash?!
#
# BMP file
# structure: http://www.ue.eti.pg.gda.pl/fpgalab/zadania.spartan3/zad_vga_struktura_pliku_bmp_en.html
# ---
# filename:       bash2bmp_gradient
# desc:           emits a gradient BMP image to stdout (must bbe redirected to *.bmp iamge file)
# ---
# 20251121 v1 en: export 2x2 bytes img
# 20251121 v2 en: put header part into function bmp_header()
#                 everything else into main() function
# 20251121 v3 en: make 'bmp' library: mv bash-bmp into 'lib/bmp' subfolder and source it from main
#                 script , and remove main() function from 'lib/bmp'
# 20251121 v4 en: move bmp building part into make_bmp function, so it can write image into image,
#                 so no redirection is needed
# last: 20251121
# --------------------------------------------------------------------------------------------------

source ./lib/bmp || exit

# v4
debug() {
	# must be redirected to stderr, otherwise it would end up inside bmp image data ...
	echo '[DEBUG]' "$@" >&2
}

make_bmp() {
	local width=$1
	local height=$2
	bmp_header "${width}" "${height}"
	local padding=${REPLY}

	#v4
	local r g b
	# loop over every row and in each row loop over every ...
	for ((y=0; y < height; y++)); do
		for ((x=0; x < width; x++)); do
			((r = x * 255 / width))  # from 0 to 255
			((b = y * 255 / height)) # from 0 to 255
			bmp_rgb "${r}" 0 "${b}"

		done
		debug "handled row ${y}/${height}"
		bmp_pad "${padding}"
	done
}


main () {
	local width=400
	local height=400

	local OPTIND OPTARG opt
	while getopts 'w:h:' opt; do
		case "${opt}" in
			w) width="${OPTARG}";;
			h) height="${OPTARG}";;
		esac
	done

	local fname="gradient-w${width}-h${height}-$(date +"%H%M%S").bmp"
	local dest="./output/${fname}"

	make_bmp "${width}" "${height}" > ${dest}
	echo "[INFO] finished creating ${dest}"
}

# v2
main "$@"

