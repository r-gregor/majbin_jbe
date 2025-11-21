#! /usr/bin/env bash
# --------------------------------------------------------------------------------------------------
# from:      https://www.youtube.com/watch?v=XjAIhULJsjc
#            I Created a Bitmap Image using Just Bash! (yes, really) - Graphics Programming in Bash?!
#
# BMP file
# structure: http://www.ue.eti.pg.gda.pl/fpgalab/zadania.spartan3/zad_vga_struktura_pliku_bmp_en.html
# ---
# filename:       bash-bmp
# 20251121 v1 en: export 2x2 bytes img
# last: 20251121
# --------------------------------------------------------------------------------------------------

# FUNCTIONS
# convert number string into unsigned 32 bit litle endian binary
u32le() {
	local n=$1 out

	# convert number into 4 octets
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

# test2
# bash way to print hex nuber: $((16#...))
# xxd creates hexdump or converts hex into original binary
# test: bash-bmp |xxd
# output:
# $> ./bash-bmp |xxd
# 00000000: 7856 3412                                xV4.

u32le "$((16#12345678))"
exit

# GLOBALS
width=2
height=2

bits_per_px=24
bytes_per_px=$((bits_per_px / 8)) # (=3)

row_size=$((width * bytes_per_px))

# each row must be a multiple of 4 so it needs to bi aligned
# align to 4 bytes boundary: padding with 0
padding=0
while ((row_size % 4 != 0)); do
	((padding++))
	((row_size++))
done

# size of color image data
pixel_data_size=$((row_size * height))

# size of image headers
pixel_data_offset=$((14 + 40))

# size of entire file
file_size=$((pixel_data_size + pixel_data_offset))



# Header (14 bytes)
## Signature
printf 'BM'

## FileSize (4 bytes)
## u32le function to print: unsigned 32 bit number - little endian
u32le "${file_size}"

## Reserved (=0)

## Data offset

# InfoHeader (40 bytes)
## Size (4 bytes)

## Width (4 bytes)

## Height (4 bytes)

## Planes (2 bytes)

## BitCount (2 bytes)

## Compressio (4 bytes)

## ImageSize (4 bytes)

## XpixelsPerM (4 bytes)

## YpixelsPerM (4 bytes)

## ColorsUsed (4 bytes)

## ColorsImportant (4 bytes)










