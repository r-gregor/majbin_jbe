#! /usr/bin/env bash
# --------------------------------------------------------------------------------------------------
# from:      https://www.youtube.com/watch?v=XjAIhULJsjc
#            I Created a Bitmap Image using Just Bash! (yes, really) - Graphics Programming in Bash?!
#
# BMP file
# structure: http://www.ue.eti.pg.gda.pl/fpgalab/zadania.spartan3/zad_vga_struktura_pliku_bmp_en.html
# ---
# filename:       bash2bmp_simple_bmp
# desc:           emits very simple BMP to stdout (must be redirected to *.bmp iamge file)
# ---
# 20251121 v1 en: export 2x2 bytes img
# 20251121 v2 en: put header part into function bmp_header()
#                 everything else into main() function
# 20251121 v3 en: make 'bmp' library: mv bash_bmp into 'lib/bmp' subfolder and source it from main
#                 script , and remove main() function from 'lib/bmp'
# 20251121 v4 en: copy simple-bmp into gradient ...
# last: 20251121
# --------------------------------------------------------------------------------------------------

source ./lib/bmp || exit

# v2
main () {
	local width=2
	local height=2
	bmp_header "${width}" "${height}"

	local padding=${REPLY}

	# little endian: img constructed fron bottom up
	# bottom row
	bmp_rgb   0   0   0
	bmp_rgb 255 255 255
	bmp_pad "${padding}" #v2

	# top row
	bmp_rgb 255   0   0
	bmp_rgb   0 255   0
	bmp_pad "${padding}" #v2
}

# v2
main "$@"

