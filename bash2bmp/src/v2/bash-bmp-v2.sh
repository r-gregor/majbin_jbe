#! /usr/bin/env bash
# --------------------------------------------------------------------------------------------------
# from:      https://www.youtube.com/watch?v=XjAIhULJsjc
#            I Created a Bitmap Image using Just Bash! (yes, really) - Graphics Programming in Bash?!
#
# BMP file
# structure: http://www.ue.eti.pg.gda.pl/fpgalab/zadania.spartan3/zad_vga_struktura_pliku_bmp_en.html
# ---
# filename:       bash-bmp
# desc:           emits very simple BMP to stdout (must bbe redirected to *.bmp iamge file)
# ---
# 20251121 v1 en: export 2x2 bytes img
# 20251121 v2 en: put header part into function bmp_header()
#                 everything else into main() function
#
# last: 20251121
# --------------------------------------------------------------------------------------------------

# FUNCTIONS
# convert number string into unsigned 32 bit litle endian binary
u32le() {
	local n=$1 out

	# convert number into 4 octets (4 bytes)
	# 0x12345678 --> 0x12, 0x34, 0x56, 0x78
	local octet1=$(( (n >> 24) & 0xFF ))
	local octet2=$(( (n >> 16) & 0xFF ))
	local octet3=$(( (n >>  8) & 0xFF ))
	local octet4=$(( (n >>  0) & 0xFF ))

	# print out binary representation
	# reverse order --> little endian!
	printf -v out '\\x%02x\\x%02x\\x%02x\\x%02x' \
		"${octet4}" \
		"${octet3}" \
		"${octet2}" \
		"${octet1}"

	# print out raw binary number
	printf '%b' "${out}"
}

u16le() {
	local n=$1 out

	# convert number into 2 octets (2 bytes)
	# 0x1234 --> 0x12, 0x34
	local octet1=$(( (n >>  8) & 0xFF ))
	local octet2=$(( (n >>  0) & 0xFF ))

	# print out binary representation
	# reverse order --> little endian!
	printf -v out '\\x%02x\\x%02x' \
		"${octet2}" \
		"${octet1}"

	# print out raw binary number
	printf '%b' "${out}"
}

# constructed from u32le (iz actually is u24le)
bmp_rgb() {
	local r=$1
	local g=$2
	local b=$3
	local out

	# print out binary representation
	# reverse order --> little endian!
	printf -v out '\\x%02x\\x%02x\\x%02x' \
		"${b}" \
		"${g}" \
		"${r}"

	# print out raw binary number
	printf '%b' "${out}"
}

# v2 header into finction
bmp_header() {
	# v2: new function parameters --> no more globals
	local width=$1
	local height=$2

	local bits_per_px=24
	local bytes_per_px=$((bits_per_px / 8)) # (=3)

	local row_size=$((width * bytes_per_px))

	# each row must be a multiple of 4 so it needs to bi aligned
	# align to 4 bytes boundary: padding with 0
	local padding=0
	while ((row_size % 4 != 0)); do
		((padding++))
		((row_size++))
	done

	# size of color image data
	local pixel_data_size=$((row_size * height))

	# size of image headers
	local pixel_data_offset=$((14 + 40))

	# size of entire file
	local file_size=$((pixel_data_size + pixel_data_offset))

	# Header (14 bytes) -------------------------------------------------
	## Signature
	printf 'BM'

	## FileSize (4 bytes)
	## u32le function to print: unsigned 32 bit number - little endian
	u32le "${file_size}"

	## Reserved (=0) (4 bytes)
	u32le 0

	## Data offset (4 bytes)
	u32le "${pixel_data_offset}"

	# InfoHeader (40 bytes)
	## Size (4 bytes)
	u32le 40

	## Width (4 bytes)
	u32le "${width}"

	## Height (4 bytes)
	u32le "${height}"

	## Planes (=1) (2 bytes)
	u16le 1

	## BitCount (2 bytes)
	u16le "${bits_per_px}"

	## Compression (4 bytes)
	u32le 0

	## ImageSize (4 bytes)
	u32le 0

	## XpixelsPerM (4 bytes)
	u32le 0

	## YpixelsPerM (4 bytes)
	u32le 0

	## ColorsUsed (4 bytes)
	u32le 0

	## ColorsImportant (4 bytes)
	u32le 0
	# end of Header -----------------------------------------------------

	# export padding, which is used outside of function
	REPLY=${padding}
}

# v2
bmp_pad() {
	local padding=$1
	for ((i = 0; i < padding; i++)); do
		printf '\0'
	done
}

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

